require 'rails_helper'

describe 'Groups API' do
  it 'can create a group' do
    group_params = ({
      name: 'Motley J'
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/groups", headers: headers, params: JSON.generate(group_params)

    json = JSON.parse(response.body, symbolize_names:true)

    group = Group.last

    expect(response).to be_successful
    expect(group).to be_a(Group)
    expect(group.name).to eq('Motley J')
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(group.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('group')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to eq(group.name)
    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes][:id]).to eq(group.id)
  end
end
