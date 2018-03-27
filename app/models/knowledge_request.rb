class KnowledgeRequest < ApplicationRecord
  belongs_to :knowledge_offer
  belongs_to :video
  before_create :request

  private
    def request
      uri = URI.parse(self.url)
      header = {"Content-Type": "application/x-www-form-urlencoded"}

      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, header)
      video_json_url = "/projects/#{self.video.project.id}/videos/#{self.video.id}.json"
      callback_url = "/projects/#{self.video.project.id}/videos/#{self.video.id}/knowledges.json?"
      request.body = URI.encode_www_form({
        type: "knowledge_request",
        verify_url: video_json_url,
        video_url: self.video.url,
        callback_url: callback_url,
        knowledge_offer_id_str: self.knowledge_offer.id_str
      })

      # Send the request
      begin
        response = http.request(request)
        self.response_body = response.body
        if response.code == "200"
          self.succeed = true
        else
          self.succeed = false
        end
      rescue
        self.response_body = 'VKC::request_failed'
        self.succeed = false
      end
    end
end
