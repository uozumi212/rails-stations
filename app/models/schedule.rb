class Schedule < ApplicationRecord
  belongs_to :movie
  belongs_to :theater
  belongs_to :screen
  has_many :reservations
end
