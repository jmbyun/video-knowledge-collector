class Knowledge < ApplicationRecord
  belongs_to :video
  belongs_to :knowledge_offer
  belongs_to :user
  validates_uniqueness_of :knowledge_offer_id, scope: :video_id
end
