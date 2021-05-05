require 'rails_helper'

describe 'Friendship API' do
  it 'can create a friendship' do
    nick = User.create(
      uid: '12345678910',
      email: 'nick@example.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )
    ron = User.create(
      uid: '12345678910',
      email: 'ron@example.com',
      first_name: 'Ron',
      last_name: 'Swanson',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )

    friendship_params = ({
      friend_id: ron.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users/#{nick.id}/friendships", headers: headers, params: JSON.generate(friendship_params)


    friendship = Friendship.last

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(friendship.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data][:type]).to eq('friendship')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes][:id]).to eq(friendship.id)
    expect(json[:data][:attributes]).to have_key(:user_id)
    expect(json[:data][:attributes][:user_id]).to eq(nick.id)
    expect(json[:data][:attributes]).to have_key(:friend_id)
    expect(json[:data][:attributes][:friend_id]).to eq(ron.id)
  end
end
