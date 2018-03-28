class Video < ApplicationRecord
  belongs_to :project
  has_many :knowledge_requests
  has_many :knowledges
  has_many :knowledge_update_notifications
  after_create :notify_video_add
  after_create :add_to_project_video_list
  after_destroy :remove_from_project_video_list

  def set_knowledge_body
    # TODO: implement knowledge merging.
    knowledge_bodies = []
    self.knowledges.map do |knowledge|
      knowledge_bodies.push(knowledge.body)
    end
    self.knowledge_body = knowledge_bodies.join("\n")
  end

  def notify_knowledge_body_update
    knowledge_update_notification = KnowledgeUpdateNotification.new(
      url: self.project.callback_url,
      video_id: self.id
    )
    knowledge_update_notification.save!
  end

  def is_all_knowledges
    knowledge_offer_ids = self.knowledges.map {|knowledge| knowledge.knowledge_offer.id}
    self.project.approved_knowledge_offers.each do |knowledge_offer|
      unless knowledge_offer_ids.include? knowledge_offer.id
        return false
      end
    end
    return true
  end

  def check_collected_knowledges
    if self.is_all_knowledges
      self.set_knowledge_body
      self.notify_knowledge_body_update
    end
  end

  private
    def notify_video_add
      self.project.approved_knowledge_offers.each do |knowledge_offer|
        knowledge_request = KnowledgeRequest.new(
          url: knowledge_offer.callback_url,
          knowledge_offer_id: knowledge_offer.id,
          video_id: self.id
        )
        knowledge_request.save
      end
    end

    def add_to_project_video_list
      video_ids = JSON.parse self.project.video_list
      video_ids.push self.id
      self.project.video_list = video_ids.to_json
      self.project.save!
    end

    def remove_from_project_video_list
      video_ids = JSON.parse self.project.video_list
      video_ids = video_ids.select {|id| id != self.id}
      self.project.video_list = video_ids.to_json
      self.project.save!
    end
end
