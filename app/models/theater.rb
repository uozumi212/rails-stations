class Theater < ApplicationRecord
  # アソシエーション
  has_many :movies_theaters
  has_many :movies, through: :movies_theaters
  has_many :screens, dependent: :destroy
  has_many :schedules
  has_many :reservations
end
