class Movie < ApplicationRecord
  validates_presence_of :title, :tmdb_id

  has_many :movie_availabilities
  has_many :services, through: :movie_availabilities
  has_many :movie_genres
  has_many :genres, through: :movie_genres

  def self.estimated_update_time(movie_count)
    total_seconds = (movie_count.to_f / 100 * 23).round(0)
    if total_seconds > 3599
      hours = total_seconds / 3600
      minutes = (total_seconds % 3600) / 60
      seconds = total_seconds % 60
      "#{hours} hour(s), #{minutes} minute(s), #{seconds} second(s)"
    elsif total_seconds > 59
      minutes = total_seconds / 60
      seconds = total_seconds % 60
      "#{minutes} minute(s), #{seconds} second(s)"
    else
      "#{total_seconds} second(s)"
    end
  end
end
