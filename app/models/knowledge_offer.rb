class KnowledgeOffer < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates_uniqueness_of :id_str
end
