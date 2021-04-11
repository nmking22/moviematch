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
      expect(movie_data[:attributes]).to have_key(:genres)
      expect(movie_data[:attributes][:genres]).to be_a(String)
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
    expect(json[:data][:attributes]).to have_key(:genres)
    expect(json[:data][:attributes][:genres]).to eq(nil)
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

    post "/api/v1/movies/#{austin_powers.id}"

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
    expect(json[:data][:attributes]).to have_key(:genres)
    expect(json[:data][:attributes][:genres]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:vote_average)
    expect(json[:data][:attributes][:vote_average]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:vote_count)
    expect(json[:data][:attributes][:vote_count]).to eq(nil)
    expect(json[:data][:attributes]).to have_key(:year)
    expect(json[:data][:attributes][:year]).to eq(nil)
  end
end
