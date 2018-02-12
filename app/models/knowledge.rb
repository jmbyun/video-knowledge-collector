class Knowledge < ApplicationRecord
  belongs_to :video
  belongs_to :knowledge_offer
  belongs_to :user
end
