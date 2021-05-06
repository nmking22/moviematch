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
      friend_email: ron.email
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users/#{nick.id}/friendships", headers: headers, params: JSON.generate(friendship_params)

    friendship = Friendship.last

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(friendship).to be_a(Friendship)
    expect(friendship.user).to eq(nick)
    expect(friendship.friend).to eq(ron)
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(ron.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('user')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:first_name)
    expect(json[:data][:attributes][:first_name]).to eq(ron.first_name)
    expect(json[:data][:attributes]).to have_key(:last_name)
    expect(json[:data][:attributes][:last_name]).to eq(ron.last_name)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(ron.email)
    expect(json[:data][:attributes]).to have_key(:image)
    expect(json[:data][:attributes][:image]).to eq(ron.image)
    expect(json[:data][:attributes]).to have_key(:uid)
    expect(json[:data][:attributes][:uid]).to eq(ron.uid)
  end

  it 'friend create with invalid email returns a descriptive error message' do
    nick = User.create(
      uid: '12345678910',
      email: 'nick@example.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )

    friendship_params = ({
      friend_email: 'april@example.com'
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users/#{nick.id}/friendships", headers: headers, params: JSON.generate(friendship_params)

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).not_to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq('Invalid email. Friend not added.')
  end

  it 'friend create when friendship already exists returns descriptive error message' do
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
    Friendship.create(
      user: nick,
      friend: ron
    )

    friendship_params = ({
      friend_email: ron.email
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users/#{nick.id}/friendships", headers: headers, params: JSON.generate(friendship_params)

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).not_to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq('You are already friends with Ron Swanson.')
  end
end
