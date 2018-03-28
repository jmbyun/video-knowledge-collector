class Project < ApplicationRecord
  belongs_to :user
  has_many :knowledge_offers
  validates_uniqueness_of :id_str
  validates_presence_of :id_str
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :user

  def approved_knowledge_offers
    self.knowledge_offers.select {|knowledge_offer| knowledge_offer.approved}
  end
end
