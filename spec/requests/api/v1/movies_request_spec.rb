require 'rails_helper'

describe "Movies API" do
  it "sends a list of movies" do
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
      expect(movie_data[:attributes]).to have_key(:tmdbid)
      expect(movie_data[:attributes][:tmdbid]).to be_an(Integer)
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
end
