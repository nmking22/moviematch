require 'rails_helper'

describe 'services API' do
  it 'can retrieve all services' do
    create_list(:service, 3)

    get '/api/v1/services'

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful

    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_an(Array)
    expect(json[:data].length).to eq(3)
    json[:data].each do |service_data|
      expect(service_data).to have_key(:id)
      expect(service_data[:id]).to be_a(String)
      expect(service_data).to have_key(:type)
      expect(service_data[:type]).to be_a(String)
      expect(service_data).to have_key(:attributes)
      expect(service_data[:attributes]).to be_a(Hash)
      expect(service_data[:attributes]).to have_key(:name)
      expect(service_data[:attributes][:name]).to be_a(String)
      expect(service_data[:attributes]).to have_key(:watchmode_id)
      expect(service_data[:attributes][:watchmode_id]).to be_an(Integer)
      expect(service_data[:attributes]).to have_key(:logo)
      expect(service_data[:attributes][:logo]).to be_a(String)
    end
  end

  it 'can retrieve service by id' do
    netflix = Service.create(
      name: 'Netflix',
      watchmode_id: 1234,
      logo: 'netflix.jpeg'
    )

    get "/api/v1/services/#{netflix.id}"

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(netflix.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data][:type]).to eq('service')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to be_a(String)
    expect(json[:data][:attributes][:name]).to eq(netflix.name)
    expect(json[:data][:attributes]).to have_key(:watchmode_id)
    expect(json[:data][:attributes][:watchmode_id]).to be_an(Integer)
    expect(json[:data][:attributes][:watchmode_id]).to eq(netflix.watchmode_id)
    expect(json[:data][:attributes]).to have_key(:logo)
    expect(json[:data][:attributes][:logo]).to be_a(String)
    expect(json[:data][:attributes][:logo]).to eq(netflix.logo)
  end

  it 'can create a service' do
    service_params = {
      name: 'Netflix',
      watchmode_id: 1234,
      logo: 'netflix.jpeg'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/services", headers: headers, params: JSON.generate(service_params)
    netflix = Service.last

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(netflix.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data][:type]).to eq('service')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to be_a(String)
    expect(json[:data][:attributes][:name]).to eq(service_params[:name])
    expect(json[:data][:attributes]).to have_key(:watchmode_id)
    expect(json[:data][:attributes][:watchmode_id]).to be_an(Integer)
    expect(json[:data][:attributes][:watchmode_id]).to eq(service_params[:watchmode_id])
    expect(json[:data][:attributes]).to have_key(:logo)
    expect(json[:data][:attributes][:logo]).to be_a(String)
    expect(json[:data][:attributes][:logo]).to eq(service_params[:logo])
  end

  it 'can update a service' do
    netflix = Service.create(
      name: 'Netflix',
      watchmode_id: 1234,
      logo: 'netflix.jpeg'
    )

    service_params = {
      name: 'Netflix 2',
      watchmode_id: 12345,
      logo: 'netflix_2.jpeg'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/services/#{netflix.id}", headers: headers, params: JSON.generate(service_params)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(netflix.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data][:type]).to eq('service')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to be_a(String)
    expect(json[:data][:attributes][:name]).to eq(service_params[:name])
    expect(json[:data][:attributes]).to have_key(:watchmode_id)
    expect(json[:data][:attributes][:watchmode_id]).to be_an(Integer)
    expect(json[:data][:attributes][:watchmode_id]).to eq(service_params[:watchmode_id])
    expect(json[:data][:attributes]).to have_key(:logo)
    expect(json[:data][:attributes][:logo]).to be_a(String)
    expect(json[:data][:attributes][:logo]).to eq(service_params[:logo])
  end

  it 'can delete a service' do
    netflix = Service.create(
      name: 'Netflix',
      watchmode_id: 1234,
      logo: 'netflix.jpeg'
    )

    expect(Service.count).to eq(1)

    delete "/api/v1/services/#{netflix.id}"

    expect(response).to be_successful
    expect(Service.count).to eq(0)
    expect{Service.find(netflix.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can update availability', :vcr do
    hulu = Service.create(
      name: 'Hulu',
      watchmode_id: 157,
      logo: 'hulu_logo.png'
    )
    movie_1 = create(:movie)
    movie_2 = create(:movie)
    movie_3 = create(:movie)
    hulu.movie_availabilities.create(movie: movie_1)
    hulu.movie_availabilities.create(movie: movie_2)
    hulu.movie_availabilities.create(movie: movie_3)

    params = {
      service: 'hulu'
    }

    get "/api/v1/services/update_availability", params: params

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('service_refresh')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to eq('Hulu')
    expect(json[:data][:attributes]).to have_key(:movie_count)
    expect(json[:data][:attributes][:movie_count]).to be_an(Integer)
  end

  it 'can update all availabilities', :vcr do
    netflix = Service.create(
      name: 'Netflix',
      watchmode_id: 203,
      logo: 'netflix_logo.png'
    )

    amazon_prime = Service.create(
      name: 'Amazon Prime Video',
      watchmode_id: 157,
      logo: 'prime_video_logo.jpeg'
    )

    hulu = Service.create(
      name: 'Hulu',
      watchmode_id: 26,
      logo: 'hulu_logo.jpeg'
    )

    get "/api/v1/services/update_all_availabilities"

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('full_refresh')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:total_movie_count)
    expect(json[:data][:attributes][:total_movie_count]).to be_an(Integer)
    expect(json[:data][:attributes]).to have_key(:service_refreshes)
    expect(json[:data][:attributes][:service_refreshes]).to be_an(Array)
    json[:data][:attributes][:service_refreshes].each do |service_refresh|
      expect(service_refresh).to be_a(Hash)
      expect(service_refresh).to have_key(:id)
      expect(service_refresh[:id]).to eq(nil)
      expect(service_refresh).to have_key(:name)
      expect(service_refresh[:name]).to be_a(String)
      expect(service_refresh).to have_key(:movie_count)
      expect(service_refresh[:movie_count]).to be_an(Integer)
    end
  end
end
