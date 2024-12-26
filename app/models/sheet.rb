class Sheet < ApplicationRecord
  has_many :reservations
  belongs_to :screen

  # validates :seat_number,  presence: true ,uniqueness: { scope: :screen_id }
end
