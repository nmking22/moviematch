require 'rails_helper'

RSpec.describe ServiceUpdateJob, type: :job do
  it 'creates movies and movie availabilities' do
    hulu = Service.create(
      name: 'Hulu',
      watchmode_id: 157,
      logo: 'hulu_logo.png'
    )

    expect(Movie.all).to eq([])
    expect(MovieAvailability.all).to eq([])

    json = File.read('spec/fixtures/movie_pages.json')
    movie_pages = JSON.parse(json, symbolize_names:true)

    ServiceUpdateJob.perform_now(hulu, movie_pages)

    movies = Movie.all
    availabilities = MovieAvailability.all

    expect(movies.length).to eq(10)
    expect(availabilities.length).to eq(10)

    movies.each do |movie|
      expect(movie).to be_a(Movie)
      expect(movie.services).to eq([hulu])
    end

    availabilities.each do |availability|
      expect(availability).to be_a(MovieAvailability)
      expect(availability.service).to eq(hulu)
    end
  end

  it 'does not create duplicate movies or availabilities when they already exist' do
    hulu = Service.create(
      name: 'Hulu',
      watchmode_id: 157,
      logo: 'hulu_logo.png'
    )
    spy_cat = Movie.create(
      title: 'Spy Cat',
      tmdb_id: 509733
    )
    spy_cat_on_hulu = hulu.movie_availabilities.create(
      movie: spy_cat
    )

    expect(Movie.all).to eq([spy_cat])
    expect(MovieAvailability.all).to eq([spy_cat_on_hulu])

    json = File.read('spec/fixtures/movie_pages.json')
    movie_pages = JSON.parse(json, symbolize_names:true)

    ServiceUpdateJob.perform_now(hulu, movie_pages)

    movies = Movie.all
    availabilities = MovieAvailability.all

    expect(movies.length).to eq(10)
    expect(availabilities.length).to eq(10)

    expect(Movie.find_by(id:spy_cat.id)).to eq(spy_cat)
    expect(MovieAvailability.find_by(movie:spy_cat)).not_to eq(spy_cat)
    expect(MovieAvailability.where(movie:spy_cat).length).to eq(1)
  end
end
