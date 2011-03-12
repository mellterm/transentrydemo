# == Schema Information
# Schema version: 20110309094442
#
# Table name: documents
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  translation_type :string(255)
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Document < ActiveRecord::Base
  attr_accessible :name, :translation_type, :user_id
  
  has_many :tags, :dependent => :destroy
  belongs_to :user	
  
  TRANSLATION_TYPES = %w{memory glossary sourcedoc reference}
  
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..65
  validates_inclusion_of :translation_type,  :in => TRANSLATION_TYPES, 
  								:message => "must be one of: #{TRANSLATION_TYPES.join(', ')}"
  validates_uniqueness_of :name, :scope => :user_id
end
