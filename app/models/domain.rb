# == Schema Information
# Schema version: 20110309094442
#
# Table name: domains
#
#  id         :integer         not null, primary key
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Domain < ActiveRecord::Base
  attr_accessible :code
  
  
  has_many :translations, :through => :domain_matrix
  has_many :domain_matrices
  
end
