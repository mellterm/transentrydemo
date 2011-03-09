class Tag < ActiveRecord::Base
  attr_accessible :name, :document_id
  
  belongs_to :document

  validates_presence_of :name
  
end
