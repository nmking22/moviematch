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
    expect(json[:data][:attributes]).to have_key(:users)
    expect(json[:data][:attributes][:users]).to eq([])
  end

  it 'can delete a group' do
    group = Group.create(
      name: 'Motley J'
    )

    expect(Group.count).to eq(1)

    delete "/api/v1/groups/#{group.id}"

    expect(response).to be_successful
    expect(Group.count).to eq(0)
    expect{Group.find(group.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can show all groups for a user' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )
    fantastic_four = Group.create(
      name: 'Fantastic Four'
    )
    avengers = Group.create(
      name: 'The Avengers'
    )
    x_men = Group.create(
      name: 'X Men'
    )
    UserGroup.create(
      user: nick,
      group: fantastic_four
    )
    UserGroup.create(
      user: nick,
      group: x_men
    )

    get "/api/v1/users/#{nick.id}/groups"

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_an(Array)
    expect(json.length).to eq(2)

    expect(json[0]).to be_a(Hash)
    expect(json[0]).to have_key(:data)
    expect(json[0][:data]).to be_a(Hash)
    expect(json[0][:data]).to have_key(:id)
    expect(json[0][:data][:id]).to eq(fantastic_four.id.to_s)
    expect(json[0][:data]).to have_key(:type)
    expect(json[0][:data][:type]).to eq('group')
    expect(json[0][:data]).to have_key(:attributes)
    expect(json[0][:data][:attributes]).to be_a(Hash)
    expect(json[0][:data][:attributes]).to have_key(:id)
    expect(json[0][:data][:attributes][:id]).to eq(fantastic_four.id)
    expect(json[0][:data][:attributes]).to have_key(:name)
    expect(json[0][:data][:attributes][:name]).to eq(fantastic_four.name)
    expect(json[0][:data][:attributes]).to have_key(:users)
    expect(json[0][:data][:attributes][:users]).to be_an(Array)
    expect(json[0][:data][:attributes][:users].length).to eq(1)
    expect(json[0][:data][:attributes][:users][0]).to be_an(Hash)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:id)
    expect(json[0][:data][:attributes][:users][0][:id]).to eq(nick.id)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:email)
    expect(json[0][:data][:attributes][:users][0][:email]).to eq(nick.email)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:first_name)
    expect(json[0][:data][:attributes][:users][0][:first_name]).to eq(nick.first_name)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:last_name)
    expect(json[0][:data][:attributes][:users][0][:last_name]).to eq(nick.last_name)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:image)
    expect(json[0][:data][:attributes][:users][0][:image]).to eq(nick.image)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:uid)
    expect(json[0][:data][:attributes][:users][0][:uid]).to eq(nick.uid)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:created_at)
    expect(json[0][:data][:attributes][:users][0][:created_at]).to be_a(String)
    expect(json[0][:data][:attributes][:users][0]).to have_key(:updated_at)
    expect(json[0][:data][:attributes][:users][0][:updated_at]).to be_a(String)

    expect(json[1]).to be_a(Hash)
    expect(json[1]).to have_key(:data)
    expect(json[1][:data]).to be_a(Hash)
    expect(json[1][:data]).to have_key(:id)
    expect(json[1][:data][:id]).to eq(x_men.id.to_s)
    expect(json[1][:data]).to have_key(:type)
    expect(json[1][:data][:type]).to eq('group')
    expect(json[1][:data]).to have_key(:attributes)
    expect(json[1][:data][:attributes]).to be_a(Hash)
    expect(json[1][:data][:attributes]).to have_key(:id)
    expect(json[1][:data][:attributes][:id]).to eq(x_men.id)
    expect(json[1][:data][:attributes]).to have_key(:name)
    expect(json[1][:data][:attributes][:name]).to eq(x_men.name)
    expect(json[1][:data][:attributes]).to have_key(:users)
    expect(json[1][:data][:attributes][:users]).to be_an(Array)
    expect(json[1][:data][:attributes][:users].length).to eq(1)
    expect(json[1][:data][:attributes][:users][0]).to be_an(Hash)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:id)
    expect(json[1][:data][:attributes][:users][0][:id]).to eq(nick.id)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:email)
    expect(json[1][:data][:attributes][:users][0][:email]).to eq(nick.email)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:first_name)
    expect(json[1][:data][:attributes][:users][0][:first_name]).to eq(nick.first_name)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:last_name)
    expect(json[1][:data][:attributes][:users][0][:last_name]).to eq(nick.last_name)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:image)
    expect(json[1][:data][:attributes][:users][0][:image]).to eq(nick.image)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:uid)
    expect(json[1][:data][:attributes][:users][0][:uid]).to eq(nick.uid)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:created_at)
    expect(json[1][:data][:attributes][:users][0][:created_at]).to be_a(String)
    expect(json[1][:data][:attributes][:users][0]).to have_key(:updated_at)
    expect(json[1][:data][:attributes][:users][0][:updated_at]).to be_a(String)
  end
end
