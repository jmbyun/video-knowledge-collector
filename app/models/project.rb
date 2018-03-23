class Project < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :id_str
end
