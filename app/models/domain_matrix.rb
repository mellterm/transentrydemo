# == Schema Information
# Schema version: 20110309094442
#
# Table name: domain_matrices
#
#  id             :integer         not null, primary key
#  translation_id :integer
#  domain_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class DomainMatrix < ActiveRecord::Base
  attr_accessible :translation_id, :domain_id
  
  belongs_to :domain
  belongs_to :translation
  
end
