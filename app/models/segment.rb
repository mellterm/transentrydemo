class Segment < ActiveRecord::Base
  attr_accessible :source_content, :target_content, :source_language_id, :target_language_id, :user_id, :document_id, :domain_id, :crd, :cru, :raw_data
end
