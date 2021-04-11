class FixTmdbidColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :movies, :tmdbid, :tmdb_id
  end
end
