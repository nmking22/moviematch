require 'rails_helper'

describe 'users API' do
  it 'can create a user' do
    user_params = {
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
    nick = User.last

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(nick).to be_a(User)
    expect(nick.uid).to eq(user_params[:uid])
    expect(nick.first_name).to eq(user_params[:first_name])
    expect(nick.last_name).to eq(user_params[:last_name])
    expect(nick.image).to eq(user_params[:image])
    expect(nick.email).to eq(user_params[:email])
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nick.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('user')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:first_name)
    expect(json[:data][:attributes][:first_name]).to eq(nick.first_name)
    expect(json[:data][:attributes]).to have_key(:last_name)
    expect(json[:data][:attributes][:last_name]).to eq(nick.last_name)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(nick.email)
    expect(json[:data][:attributes]).to have_key(:image)
    expect(json[:data][:attributes][:image]).to eq(nick.image)
    expect(json[:data][:attributes]).to have_key(:uid)
    expect(json[:data][:attributes][:uid]).to eq(nick.uid)
  end

  it 'can find an existing user with create action' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )

    user_params = {
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

    json = JSON.parse(response.body, symbolize_names:true)

    expect(User.last).to eq(nick)
    expect(response).to be_successful
    expect(nick).to be_a(User)
    expect(nick.uid).to eq(user_params[:uid])
    expect(nick.first_name).to eq(user_params[:first_name])
    expect(nick.last_name).to eq(user_params[:last_name])
    expect(nick.image).to eq(user_params[:image])
    expect(nick.email).to eq(user_params[:email])
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nick.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('user')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:first_name)
    expect(json[:data][:attributes][:first_name]).to eq(nick.first_name)
    expect(json[:data][:attributes]).to have_key(:last_name)
    expect(json[:data][:attributes][:last_name]).to eq(nick.last_name)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(nick.email)
    expect(json[:data][:attributes]).to have_key(:image)
    expect(json[:data][:attributes][:image]).to eq(nick.image)
    expect(json[:data][:attributes]).to have_key(:uid)
    expect(json[:data][:attributes][:uid]).to eq(nick.uid)
  end

  it 'can find an existing user with show action' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )

    get "/api/v1/users/#{nick.uid}"

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nick.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('user')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:first_name)
    expect(json[:data][:attributes][:first_name]).to eq(nick.first_name)
    expect(json[:data][:attributes]).to have_key(:last_name)
    expect(json[:data][:attributes][:last_name]).to eq(nick.last_name)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(nick.email)
    expect(json[:data][:attributes]).to have_key(:image)
    expect(json[:data][:attributes][:image]).to eq(nick.image)
    expect(json[:data][:attributes]).to have_key(:uid)
    expect(json[:data][:attributes][:uid]).to eq(nick.uid)
  end

  it 'returns descriptive error for invalid show requests' do
    get "/api/v1/users/12345678910"

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq('User does not exist in database.')
  end

  it 'can update a user' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )

    user_params = {
      email: 'nickmaxking@example.com',
      first_name: 'Trick',
      last_name: 'Thing',
      image: 'https://image.shutterstock.com/shutterstock/photos/1036253818/display_1500/stock-photo-image-of-excited-screaming-young-woman-standing-isolated-over-yellow-background-looking-camera-1036253818.jpg'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/users/#{nick.uid}", headers: headers, params: JSON.generate(user_params)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nick.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('user')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:first_name)
    expect(json[:data][:attributes][:first_name]).to eq(user_params[:first_name])
    expect(json[:data][:attributes]).to have_key(:last_name)
    expect(json[:data][:attributes][:last_name]).to eq(user_params[:last_name])
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(user_params[:email])
    expect(json[:data][:attributes]).to have_key(:image)
    expect(json[:data][:attributes][:image]).to eq(user_params[:image])
    expect(json[:data][:attributes]).to have_key(:uid)
    expect(json[:data][:attributes][:uid]).to eq(nick.uid)
  end

  it 'can show all friends of a user' do
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
    tom = User.create(
      uid: '12345678910',
      email: 'tom@example.com',
      first_name: 'Tom',
      last_name: 'Haverford',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )
    leslie = User.create(
      uid: '12345678910',
      email: 'leslie@example.com',
      first_name: 'Leslie',
      last_name: 'Knope',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )

    nick.friendships.create(friend: ron)
    nick.friendships.create(friend: tom)
    nick.friendships.create(friend: leslie)

    get "/api/v1/users/#{nick.id}/friends"

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nick.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('friendlist')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes][:id]).to eq(nick.id)
    expect(json[:data][:attributes]).to have_key(:friends)
    expect(json[:data][:attributes][:friends]).to be_an(Array)

    expect(json[:data][:attributes][:friends][0]).to be_a(Hash)
    expect(json[:data][:attributes][:friends][0]).to have_key(:id)
    expect(json[:data][:attributes][:friends][0][:id]).to eq(ron.id)
    expect(json[:data][:attributes][:friends][0]).to have_key(:email)
    expect(json[:data][:attributes][:friends][0][:email]).to eq(ron.email)
    expect(json[:data][:attributes][:friends][0]).to have_key(:first_name)
    expect(json[:data][:attributes][:friends][0][:first_name]).to eq(ron.first_name)
    expect(json[:data][:attributes][:friends][0]).to have_key(:last_name)
    expect(json[:data][:attributes][:friends][0][:last_name]).to eq(ron.last_name)
    expect(json[:data][:attributes][:friends][0]).to have_key(:image)
    expect(json[:data][:attributes][:friends][0][:image]).to eq(ron.image)
    expect(json[:data][:attributes][:friends][0]).to have_key(:uid)
    expect(json[:data][:attributes][:friends][0][:uid]).to eq(ron.uid)
    expect(json[:data][:attributes][:friends][0]).to have_key(:created_at)
    expect(json[:data][:attributes][:friends][0][:created_at]).to be_a(String)
    expect(json[:data][:attributes][:friends][0]).to have_key(:updated_at)
    expect(json[:data][:attributes][:friends][0][:updated_at]).to be_a(String)

    expect(json[:data][:attributes][:friends][1]).to be_a(Hash)
    expect(json[:data][:attributes][:friends][1]).to have_key(:id)
    expect(json[:data][:attributes][:friends][1][:id]).to eq(tom.id)
    expect(json[:data][:attributes][:friends][1]).to have_key(:email)
    expect(json[:data][:attributes][:friends][1][:email]).to eq(tom.email)
    expect(json[:data][:attributes][:friends][1]).to have_key(:first_name)
    expect(json[:data][:attributes][:friends][1][:first_name]).to eq(tom.first_name)
    expect(json[:data][:attributes][:friends][1]).to have_key(:last_name)
    expect(json[:data][:attributes][:friends][1][:last_name]).to eq(tom.last_name)
    expect(json[:data][:attributes][:friends][1]).to have_key(:image)
    expect(json[:data][:attributes][:friends][1][:image]).to eq(tom.image)
    expect(json[:data][:attributes][:friends][1]).to have_key(:uid)
    expect(json[:data][:attributes][:friends][1][:uid]).to eq(tom.uid)
    expect(json[:data][:attributes][:friends][1]).to have_key(:created_at)
    expect(json[:data][:attributes][:friends][1][:created_at]).to be_a(String)
    expect(json[:data][:attributes][:friends][1]).to have_key(:updated_at)
    expect(json[:data][:attributes][:friends][1][:updated_at]).to be_a(String)

    expect(json[:data][:attributes][:friends][2]).to be_a(Hash)
    expect(json[:data][:attributes][:friends][2]).to have_key(:id)
    expect(json[:data][:attributes][:friends][2][:id]).to eq(leslie.id)
    expect(json[:data][:attributes][:friends][2]).to have_key(:email)
    expect(json[:data][:attributes][:friends][2][:email]).to eq(leslie.email)
    expect(json[:data][:attributes][:friends][2]).to have_key(:first_name)
    expect(json[:data][:attributes][:friends][2][:first_name]).to eq(leslie.first_name)
    expect(json[:data][:attributes][:friends][2]).to have_key(:last_name)
    expect(json[:data][:attributes][:friends][2][:last_name]).to eq(leslie.last_name)
    expect(json[:data][:attributes][:friends][2]).to have_key(:image)
    expect(json[:data][:attributes][:friends][2][:image]).to eq(leslie.image)
    expect(json[:data][:attributes][:friends][2]).to have_key(:uid)
    expect(json[:data][:attributes][:friends][2][:uid]).to eq(leslie.uid)
    expect(json[:data][:attributes][:friends][2]).to have_key(:created_at)
    expect(json[:data][:attributes][:friends][2][:created_at]).to be_a(String)
    expect(json[:data][:attributes][:friends][2]).to have_key(:updated_at)
    expect(json[:data][:attributes][:friends][2][:updated_at]).to be_a(String)
  end
end
