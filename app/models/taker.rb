class Taker < ApplicationRecord
  validates :phone_number, presence: true
  validates :cross_street1, presence: true
  validates :cross_street2, presence: true

end
