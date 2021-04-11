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
end
