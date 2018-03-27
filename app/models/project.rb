class Project < ApplicationRecord
  belongs_to :user
  has_many :knowledge_offers
  validates_uniqueness_of :id_str

  def approved_knowledge_offers
    self.knowledge_offers.select {|knowledge_offer| knowledge_offer.approved}
  end
end
