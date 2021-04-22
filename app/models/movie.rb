class Movie < ApplicationRecord
  validates_presence_of :title, :tmdb_id

  has_many :movie_availabilities
  has_many :services, through: :movie_availabilities
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  has_many :swipes
  has_many :users, through: :swipes

  def self.needs_details
    Movie.where(description:nil)
  end

  def self.estimated_update_time(movie_count)
    total_seconds = convert_movie_count_to_estimated_seconds(movie_count)
    if hour_plus?(total_seconds)
      time_in_hours(total_seconds)
    elsif minute_plus?(total_seconds)
      time_in_minutes(total_seconds)
    else
      time_in_seconds(total_seconds)
    end
  end

  def self.convert_movie_count_to_estimated_seconds(movie_count)
    (movie_count.to_f / 100 * 23).round(0)
  end

  def self.hour_plus?(seconds)
    seconds > 3599
  end

  def self.minute_plus?(seconds)
    seconds > 59
  end

  def self.time_in_hours(total_seconds)
    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60
    "#{hours} hour(s), #{minutes} minute(s), #{seconds} second(s)"
  end

  def self.time_in_minutes(total_seconds)
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    "#{minutes} minute(s), #{seconds} second(s)"
  end

  def self.time_in_seconds(seconds)
    "#{seconds} second(s)"
  end

  def self.random_unswiped(user_id)
    available_movies = Movie.joins(:movie_availabilities)
    invalid_movies = Movie.joins(:swipes).where(swipes: {user_id:user_id})
    valid_movies = available_movies - invalid_movies
    valid_movies.sample
  end
end
