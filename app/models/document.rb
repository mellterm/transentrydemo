# == Schema Information
# Schema version: 20110315040826
#
# Table name: documents
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  translation_type  :string(255)
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#

class Document < ActiveRecord::Base
  attr_accessible :name, :translation_type, :user_id
  
  has_many :tags, :dependent => :destroy
  belongs_to :user	
  
  
  has_attached_file :data, 
  					:default_url => '/assets/documents/temple.png', 
					:url => "/assets/documents/:id/:style/:basename.:extension",
					:path => ":rails_root/public/assets/documents/:id/:style/:basename.:extension"
		
	validates_attachment_content_type :data, :content_type => ['application/pdf', 'text/xml']	
	validates_attachment_presence :data

  
  TRANSLATION_TYPES = %w{memory glossary sourcedoc reference}
  
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..65
  validates_inclusion_of :translation_type,  :in => TRANSLATION_TYPES, 
  								:message => "must be one of: #{TRANSLATION_TYPES.join(', ')}"
  validates_uniqueness_of :name, :scope => :user_id
  
  after_save :set_mime, :process_file
  
  #File Handling
  
  def is_csv?
    self.data_file_name.match("(\.csv)$")
  end
  
  def on_windows?
    if RUBY_PLATFORM =~ /(:?mswin|win32|mingw|bccwin)/
      return true
    else
      return false
    end
  end
  
  def set_mime
    self.data_content_type = self.mime_type
    self.file_encoding = self.mime_encoding
    self.send(:update_without_callbacks)
  end
  
  def process_file
    return true if on_windows?
    file_path = self.data.path
    
    # If extension is CSV
    if file_path.match("(\.csv)$")
      Rails.logger.info("[file] #{file_path} is CSV")
      #import_csv
      return true
    else
      # Import the files if we have a file object
      import_processed_file(file_path)
    end
  end
  

# Importing TMX Files
  def import_tmx(data)
    header = data["header"].first
    body = data["body"].first
    tu = body["tu"]

    # Some info from header
    creationtoolversion = header["creationtoolversion"] # Need to add to DB.
    creationtool = header["creationtool"] # Need to add to DB.
    creationdate = header["creationdate"] # Need to add to DB.
    creationid = header["creationid"] # Need to add to DB.
    segtype = header["segtype"] # Need to add to DB.
    otmf = header["o-tmf"]
    srclang = header["srclang"]
    adminlang = header["adminlang"]
    
    self.tmx_version = data["version"].to_s
    self.tmx_source_language = srclang.to_s.downcase
    self.tmx_datatype = header["datatype"]
    self.tmx_xmlns = otmf
    
    # counters
    @total=0
    @rejected=0
    

    #@from_lang = tu[0]["tuv"][0]["xml:lang"]
    from_lang = srclang.to_s.downcase # get source language from header
    to_lang   = tu[0]["tuv"][1]["xml:lang"].to_s.downcase
    
    source_language = Language.find_or_create_by_code(from_lang)
    target_language = Language.find_or_create_by_code(to_lang)
    
    domain_id = 1
    
    # Looking for the language on the database, 
    # if not found, then create new one.
    if self.tmx_source_language && !self.tmx_source_language.empty?
      lang = Language.find_or_create_by_title(self.tmx_source_language)
      lang_id = lang.id
    else
      lang_id = nil
    end
    
    tu.each do |t|
      from      = t["tuv"][0]["seg"][0]["content"].to_s
      to        = t["tuv"][1]["seg"][0]["content"].to_s
      logger.debug "[tmx] #{from_lang} -> #{from}"
      logger.debug "[tmx] #{to_lang} -> #{to}"
      logger.debug "======"
      
      if Segment.create(
        :source_content => from,
        :target_content => to,
        :source_language_id => source_language.id,
        :target_language_id => target_language.id,
        :domain_id => domain_id,
        :document_id => self.id,
        :user_id => self.user_id,
        :crd => creationdate,
        :cru => creationid,
        :raw_data => t.to_s
        )
        @total+=1
      else
        @rejected+=1
      end
    end
    
    # Memory Clean up
    tu =nil
    body=nil
    header=nil
    data=nil
    GC.start
    
    self.send(:update_without_callbacks)
  end
  
  protected
  
      # Check File Encoding from File System. Linux/BSD only
    def get_mime_encoding(filepath)
      `file -b --mime-encoding #{filepath}`.chomp.upcase unless on_windows?
    end
    # Check File Type from File System. Linux/BSD only
    def get_mime_type(filepath)
      `file -b --mime-type #{filepath}`.chomp.downcase unless on_windows?
    end
    
    # Check for Allowed file types.
    def validate
      errors.add("file_type", "is SdlXliff. This type of file is not supported.") if
        self.data.path.downcase.match("(\.sdlxliff)$")
      errors.add("file_type", "Only PDF, TMX, CSV are supported.") unless 
        self.data.path.downcase.match("(\.tmx|\.csv|\.pdf)$")
    end
  
  
  
      # Check the type of document and parse it
    def import_processed_file(file)
      require 'xmlsimple'
      data = XmlSimple.xml_in(File.read(file), {'ForceContent' => true})

      # check if the file is really an xliff file
      if (data && data["xmlns:sdl"] && data["xmlns:sdl"].match("SdlXliff"))
        Rails.logger.info("[file] #{file} is xmlns. Not Processing")
        return false
      elsif (data && data["file"] && data["version"] && data["xmlns"] && data["xmlns"].match("xliff:document"))
        import_xlf(data)
      elsif (data && data["header"] && data["version"] && data["body"] && data["body"].size > 0 && data["body"].first["tu"])
        import_tmx(data)
      else
        return false
      end
    end
  
  
  
  
end
