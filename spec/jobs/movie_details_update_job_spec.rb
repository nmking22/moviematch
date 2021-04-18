require 'rails_helper'

RSpec.describe MovieDetailsUpdateJob, type: :job do
  it 'populates details for incomplete movies', :vcr do
    movies = []
    movies << Movie.create(
      title: 'Austin Powers: International Man of Mystery',
      tmdb_id: 816
    )
    movies << Movie.create(
      title: 'Nightcrawler',
      tmdb_id: 242582
    )
    movies << Movie.create(
      title: 'The Theory of Everything',
      tmdb_id: 266856
    )

    MovieDetailsUpdateJob.perform_now

    austin_powers = Movie.find_by(tmdb_id:816)
    nightcrawler = Movie.find_by(tmdb_id:242582)
    theory_of_everything = Movie.find_by(tmdb_id:266856)
    updated_movies = [austin_powers, nightcrawler, theory_of_everything]

    # tests movie objects have been updated
    updated_movies.each do |movie|
      expect(movie.poster_path).to be_a(String)
      expect(movie.description).to be_a(String)
      expect(movie.vote_average).to be_a(Float)
      expect(movie.vote_count).to be_a(Integer)
      expect(movie.year).to be_a(String)
      expect(movie.genres).not_to eq([])
    end
  end
end
