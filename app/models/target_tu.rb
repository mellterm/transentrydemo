# == Schema Information
# Schema version: 20110309094442
#
# Table name: target_tus
#
#  id          :integer         not null, primary key
#  content     :string(255)
#  language_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class TargetTu < ActiveRecord::Base
  attr_accessible :content, :language_id
  
  belongs_to :language
  
  has_many :translations
  
end
