class Knowledge < ApplicationRecord
  belongs_to :video
  belongs_to :knowledge_offer
  belongs_to :user
  validates_uniqueness_of :knowledge_offer_id, scope: :video_id
  after_save :check_collected_knowledges

  private
    def check_collected_knowledges
      self.video.check_collected_knowledges
    end
end
