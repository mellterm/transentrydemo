# == Schema Information
# Schema version: 20110309094442
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  document_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Tag < ActiveRecord::Base
  attr_accessible :name, :document_id
  
  belongs_to :document

  validates_presence_of :name
  validates_length_of :name, :maximum => 20
  validates_uniqueness_of :name, :scope => :document_id
  
  
  
end
