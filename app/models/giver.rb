class Giver < ApplicationRecord
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :status, presence: true

end
