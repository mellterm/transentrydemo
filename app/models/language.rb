class Language < ActiveRecord::Base
  attr_accessible :code
  
  has_many :source_tus
  has_many :target_tus
  
end
