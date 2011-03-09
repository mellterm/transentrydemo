class Document < ActiveRecord::Base
  attr_accessible :name, :translation_type, :user_id
  
  has_many :tags, :dependent => :destroy
  belongs_to :user
  belongs_to :translation_type
  	
  validates_presence_of :name
  
  
end
