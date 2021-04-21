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
end
