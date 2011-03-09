class Translation < ActiveRecord::Base
  attr_accessible :source_tu_id, :target_tu_id, :source_id, :is_public
  
  belongs_to :source_tu
  belongs_to :target_tu
  
  has_many :domains, :through => :domain_matrices
  has_many :domain_matrices
  
  belongs_to :source
  
  accepts_nested_attributes_for :source_tu
  
end
