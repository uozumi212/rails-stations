class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :date, null: false
      t.references :schedule, null: false, foreign_key: { to_table: :schedules }, index: true
      t.references :sheet, null: false, foreign_key: { to_table: :sheets }, index: true
      t.string :email, null: false, comment: '予約者メールアドレス'
      t.string :name, null: false, comment: '予約者名'


      t.timestamps
    end
  end
end
