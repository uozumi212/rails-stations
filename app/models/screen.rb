class Screen < ApplicationRecord
  # アソシエーション
  has_many :movies
  has_many :sheets, dependent: :destroy
  belongs_to :theater, dependent: :destroy
end
