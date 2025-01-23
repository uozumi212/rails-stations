class AddTheaterIdToSchedules < ActiveRecord::Migration[7.1]
  def change
    add_reference :schedules, :theater, null: false, foreign_key: true
  end
end
