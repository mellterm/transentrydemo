class Domain < ActiveRecord::Base
  attr_accessible :code
  
  
  has_many :translations, :through => :domain_matrix
  has_many :domain_matrices
  
end
