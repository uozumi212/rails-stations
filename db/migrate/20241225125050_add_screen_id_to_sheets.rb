class AddScreenIdToSheets < ActiveRecord::Migration[7.1]
  def change
    add_column :sheets, :screen_id, :bigint, null: false
    add_column :sheets, :reserved, :boolean, default: false
    add_foreign_key :sheets, :screens, column: :screen_id
  end
end
