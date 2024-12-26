class Screen < ApplicationRecord
  has_many :movies
  has_many :sheets, dependent: :destroy
end
