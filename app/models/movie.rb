class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true # タイトルの重複を防ぐ
  validates :year, presence: true
  validates :description, presence: true
  validates :image_url, presence: true

  has_many :schedules, dependent: :destroy

  scope :search, ->(keyword) {
    where("name LIKE :keyword OR description LIKE :keyword", keyword: "%#{keyword}%")
  }


  scope :by_showing_status, ->(status) {
    return all if status.blank?
    where(is_showing: status == "true")
  }
end
