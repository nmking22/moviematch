class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :tmdbid
      t.string :poster_path
      t.string :description
      t.string :genres
      t.float :vote_average
      t.integer :vote_count
      t.string :year

      t.timestamps
    end
  end
end
