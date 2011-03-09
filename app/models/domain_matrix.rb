class DomainMatrix < ActiveRecord::Base
  attr_accessible :translation_id, :domain_id
  
  belongs_to :domain
  belongs_to :translation
  
end
