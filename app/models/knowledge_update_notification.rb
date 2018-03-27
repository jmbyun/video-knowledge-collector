class KnowledgeUpdateNotification < ApplicationRecord
  belongs_to :video
  before_create :notify

  private
    def notify
      uri = URI.parse(self.url)
      header = {"Content-Type": "application/x-www-form-urlencoded"}

      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, header)
      video_json_url = "/projects/#{self.video.project.id}/videos/#{self.video.id}.json"
      request.body = URI.encode_www_form({
        type: "video_knowledge_update_notification",
        video_knowledge_url: video_json_url,
        project_id_str: self.video.project.id_str
      })

      # Send the request
      begin
        response = http.request(request)
        # self.response_body = response.body
        if response.code == "200"
          self.succeed = true
        else
          self.succeed = false
        end
      rescue
        self.succeed = false
      end
    end
end
