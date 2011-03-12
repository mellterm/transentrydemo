# == Schema Information
# Schema version: 20110309094442
#
# Table name: translations
#
#  id           :integer         not null, primary key
#  source_tu_id :integer
#  target_tu_id :integer
#  source_id    :integer
#  is_public    :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class Translation < ActiveRecord::Base
  attr_accessible :source_tu_id, :target_tu_id, :source_id, :is_public
  
  belongs_to :source_tu
  belongs_to :target_tu
  
  has_many :domains, :through => :domain_matrices
  has_many :domain_matrices
  
  belongs_to :source
  belongs_to :user
  accepts_nested_attributes_for :source_tu
  
end
