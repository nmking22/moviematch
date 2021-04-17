class AddTmdbIdToGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :genres, :tmdb_id, :integer
  end
end
