class Reservation < ApplicationRecord
  # アソシエーション
  belongs_to :sheet
  belongs_to :schedule
  has_one :movie, through: :schedule
  belongs_to :theater
  belongs_to :screen

  # バリデーション
  validates :sheet_id, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: "無効なメールアドレスです" }
  validate :unique_sheet_reservation
  validates :schedule_id, uniqueness: { scope: [:sheet_id, :theater_id, :screen_id] }

  private

  # カスタムバリデーション
  def unique_sheet_reservation
    if Reservation.exists?(schedule_id: schedule_id, sheet_id: sheet_id, date: date)
      errors.add(:sheet_id, 'その座席は既に予約されています')
    end
  end
end
