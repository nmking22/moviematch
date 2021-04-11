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

  end

  it 'can delete a service' do

  end
end
