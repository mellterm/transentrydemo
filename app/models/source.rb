# == Schema Information
# Schema version: 20110309094442
#
# Table name: sources
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Source < ActiveRecord::Base
  attr_accessible :name
  
  has_many :translations
  
end
