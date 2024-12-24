class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule
  has_one :movie, through: :schedule

  validates :sheet_id, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with:  /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: "無効なメールアドレスです" }
  validate :unique_sheet_reservation

  private

  def unique_sheet_reservation
    if Reservation.exists?(schedule_id: schedule_id, sheet_id: sheet_id, date: date)
      errors.add(:sheet_id, 'その座席は既に予約されています')
    end
  end
end
