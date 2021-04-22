require 'rails_helper'

describe "Movies API" do
  it "can retrieve all movies" do
    create_list(:movie, 3)

    get '/api/v1/movies'

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_an(Array)
    expect(json[:data].length).to eq(3)
    json[:data].each do |movie_data|
      expect(movie_data).to have_key(:id)
      expect(movie_data[:id]).to be_a(String)
      expect(movie_data).to have_key(:type)
      expect(movie_data[:type]).to be_a(String)
      expect(movie_data).to have_key(:attributes)
      expect(movie_data[:attributes]).to be_a(Hash)
      expect(movie_data[:attributes]).to have_key(:title)
      expect(movie_data[:attributes][:title]).to be_a(String)
      expect(movie_data[:attributes]).to have_key(:tmdb_id)
      expect(movie_data[:attributes][:tmdb_id]).to be_an(Integer)
      expect(movie_data[:attributes]).to have_key(:poster_path)
      expect(movie_data[:attributes][:poster_path]).to be_a(String)
      expect(movie_data[:attributes]).to have_key(:description)
      expect(movie_data[:attributes][:description]).to be_a(String)
      expect(movie_data[:attributes]).to have_key(:vote_average)
      expect(movie_data[:attributes][:vote_average]).to be_a(Float)
      expect(movie_data[:attributes]).to have_key(:vote_count)
      expect(movie_data[:attributes][:vote_count]).to be_an(Integer)
      expect(movie_data[:attributes]).to have_key(:year)
      expect(movie_data[:attributes][:year]).to be_a(String)
    end
  end

  it 'can retrieve a movie by id' do
    austin_powers = Movie.create(
      title: 'Austin Powers: International Man of Mystery',
      tmdb_id: 816
    )
    create_list(:movie, 3)

    get "/api/v1/movies/#{austin_powers.id}"

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(austin_powers.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:title)
    expect(json[:data][:attributes][:title]).to be_a(String)
    expect(json[:data][:attributes][:title]).to eq(austin_powers.title)
    expect(json[:data][:attributes]).to have_key(:tmdb_id)
    expect(json[:data][:attributes][:tmdb_id]).to be_an(Integer)
    expect(json[:data][:attributes][:tmdb_id]).to eq(austin_powers.tmdb_id)
    expect(json[:data][:attributes]).to have_key(:poster_path)
    expect(json[:data][:attributes][:poster_path]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:description)
    expect(json[:data][:attributes][:description]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:vote_average)
    expect(json[:data][:attributes][:vote_average]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:vote_count)
    expect(json[:data][:attributes][:vote_count]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:year)
    expect(json[:data][:attributes][:year]).to eq(nil)
  end

  it 'can create a movie' do
    movie_params = ({
      title: 'Austin Powers: International Man of Mystery',
      tmdb_id: 816
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/movies", headers: headers, params: JSON.generate(movie_params)
    austin_powers = Movie.last

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(austin_powers.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:title)
    expect(json[:data][:attributes][:title]).to be_a(String)
    expect(json[:data][:attributes][:title]).to eq(austin_powers.title)
    expect(json[:data][:attributes]).to have_key(:tmdb_id)
    expect(json[:data][:attributes][:tmdb_id]).to be_an(Integer)
    expect(json[:data][:attributes][:tmdb_id]).to eq(austin_powers.tmdb_id)
    expect(json[:data][:attributes]).to have_key(:poster_path)
    expect(json[:data][:attributes][:poster_path]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:description)
    expect(json[:data][:attributes][:description]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:vote_average)
    expect(json[:data][:attributes][:vote_average]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:vote_count)
    expect(json[:data][:attributes][:vote_count]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:year)
    expect(json[:data][:attributes][:year]).to eq(nil)
  end

  it 'can update an existing movie' do
    austin_powers = Movie.create(
      title: 'Austin Powers: International Man of Mystery',
      tmdb_id: 816
    )

    movie_params = ({
      poster_path: '/1PkGnyFwRyapmbuILIOXXxiSh7Y.jpg',
      description: "As a swingin' fashion photographer by day and a groovy British superagent by night, Austin Powers is the '60s' most shagadelic spy, baby! But can he stop megalomaniac Dr. Evil after the bald villain freezes himself and unthaws in the '90s? With the help of sexy sidekick Vanessa Kensington, he just might.",
      vote_average: 6.5,
      vote_count: 2349,
      year: '1997'
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/movies/#{austin_powers.id}", headers: headers, params: JSON.generate(movie_params)

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(austin_powers.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:title)
    expect(json[:data][:attributes][:title]).to be_a(String)
    expect(json[:data][:attributes][:title]).to eq(austin_powers.title)
    expect(json[:data][:attributes]).to have_key(:tmdb_id)
    expect(json[:data][:attributes][:tmdb_id]).to be_an(Integer)
    expect(json[:data][:attributes][:tmdb_id]).to eq(austin_powers.tmdb_id)
    expect(json[:data][:attributes]).to have_key(:poster_path)
    expect(json[:data][:attributes][:poster_path]).to eq(movie_params[:poster_path])
    expect(json[:data][:attributes]).to have_key(:description)
    expect(json[:data][:attributes][:description]).to eq(movie_params[:description])
    expect(json[:data][:attributes]).to have_key(:vote_average)
    expect(json[:data][:attributes][:vote_average]).to eq(movie_params[:vote_average])
    expect(json[:data][:attributes]).to have_key(:vote_count)
    expect(json[:data][:attributes][:vote_count]).to eq(movie_params[:vote_count])
    expect(json[:data][:attributes]).to have_key(:year)
    expect(json[:data][:attributes][:year]).to eq(movie_params[:year])
  end

  it 'can delete a movie' do
    austin_powers = Movie.create(
      title: 'Austin Powers: International Man of Mystery',
      tmdb_id: 816
    )

    expect(Movie.count).to eq(1)

    delete "/api/v1/movies/#{austin_powers.id}"

    expect(response).to be_successful
    expect(Movie.count).to eq(0)
    expect{Movie.find(austin_powers.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can populate details for incomplete movies', :vcr do
    Movie.create(
      title: 'Austin Powers: International Man of Mystery',
      tmdb_id: 816
    )
    Movie.create(
      title: 'Nightcrawler',
      tmdb_id: 242582
    )
    Movie.create(
      title: 'The Theory of Everything',
      tmdb_id: 266856
    )

    get '/api/v1/movies/populate_details'

    json = JSON.parse(response.body, symbolize_names:true)

    # tests response is correct
    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:movies_updated)
    expect(json[:movies_updated]).to eq(3)
    expect(json).to have_key(:update_status)
    expect(json[:update_status]).to eq('Complete - incomplete movies have been populated.')

    austin_powers = Movie.find_by(tmdb_id:816)
    nightcrawler = Movie.find_by(tmdb_id:242582)
    theory_of_everything = Movie.find_by(tmdb_id:266856)
    movies = [austin_powers, nightcrawler, theory_of_everything]

    # tests movie objects have been updated
    movies.each do |movie|
      expect(movie.poster_path).to be_a(String)
      expect(movie.description).to be_a(String)
      expect(movie.vote_average).to be_a(Float)
      expect(movie.vote_count).to be_a(Integer)
      expect(movie.year).to be_a(String)
      expect(movie.genres).not_to eq([])
    end
  end

  it 'returns descriptive body when movie details are already populated' do
    Movie.create(
      title: 'Austin Powers: International Man of Mystery',
      tmdb_id: 816,
      poster_path: '/5uD4dxNX8JKFjWKYMHyOsqhi5pN.jpg',
      description: "As a swingin' fashion photographer by day and a groovy British superagent by night, Austin Powers is the '60s' most shagadelic spy, baby! But can he stop megalomaniac Dr. Evil after the bald villain freezes himself and unthaws in the '90s? With the help of sexy sidekick Vanessa Kensington, he just might.",
      vote_average: 6.5,
      vote_count: 2357,
      year: '1997'
    )

    get '/api/v1/movies/populate_details'

    json = JSON.parse(response.body, symbolize_names:true)

    # tests response is correct
    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:movies_updated)
    expect(json[:movies_updated]).to eq(0)
    expect(json).to have_key(:update_status)
    expect(json[:update_status]).to eq('Complete - all movies are populated.')
  end

  it 'returns progress report for lengthy populate_details requests', :vcr do
    30.times do
      Movie.create(
        title: 'Austin Powers: International Man of Mystery',
        tmdb_id: 816
      )
    end

    get '/api/v1/movies/populate_details'

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:movies_updated)
    expect(json[:movies_updated]).to eq(30)
    expect(json).to have_key(:update_status)
    expect(json[:update_status]).to eq("In progress - details for 30 movies are currently being updated. Estimated completion time: 7 second(s).")
  end

  it 'can retrieve random available movie info' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )
    create_list(:movie, 3)
    params = {
      user_id: nick.id
    }

    get '/api/v1/movies/random_available', params: params

    json = JSON.parse(response.body, symbolize_names:true)

    binding.pry
    # return movie info where user.swipes
  end
end
