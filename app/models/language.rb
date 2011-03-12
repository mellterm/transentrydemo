# == Schema Information
# Schema version: 20110309094442
#
# Table name: languages
#
#  id         :integer         not null, primary key
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
  attr_accessible :code
  
  has_many :source_tus
  has_many :target_tus
  
end
