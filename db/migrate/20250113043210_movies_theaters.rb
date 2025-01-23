class MoviesTheaters < ActiveRecord::Migration[7.1]
  def change
    create_table :movies_theaters do |t|
      t.references :movie
      t.references :theater
      t.timestamps
    end
  end
end
