class KnowledgeOffer < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates_uniqueness_of :id_str
  before_create :set_default_values

  def get_knowledge(video)
    knowledges = Knowledge.where(video_id: video.id, knowledge_offer_id: self.id)
    unless knowledges.empty?
      return knowledges.first
    else
      return nil
    end
  end

  def get_knowledge_request(video)
    knowledge_requests = KnowledgeRequest.where(video_id: video.id, knowledge_offer_id: self.id)
    unless knowledge_requests.empty?
      return knowledge_requests.first
    else
      return nil
    end
  end

  private
    def set_default_values
      self.approved = false
    end
end
