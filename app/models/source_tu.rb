class SourceTu < ActiveRecord::Base
  attr_accessible :content, :language_id
  
  belongs_to :language
  
  has_many :translations
  
end
