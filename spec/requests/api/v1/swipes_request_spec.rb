require 'rails_helper'

describe 'Swipes API' do
  it 'can create a swipe' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )
    movie = create(:movie)
    swipe_params = ({
      user_id: nick.id,
      movie_id: movie.id,
      rating: 1
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/swipes", headers: headers, params: JSON.generate(swipe_params)
    swipe = Swipe.last

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(swipe).to be_a(Swipe)
    expect(swipe.user_id).to eq(nick.id)
    expect(swipe.movie_id).to eq(movie.id)
    expect(swipe.rating).to eq(1)
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(swipe.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('swipe')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:movie_id)
    expect(json[:data][:attributes][:movie_id]).to be_an(Integer)
    expect(json[:data][:attributes][:movie_id]).to eq(movie.id)
    expect(json[:data][:attributes]).to have_key(:user_id)
    expect(json[:data][:attributes][:user_id]).to be_an(Integer)
    expect(json[:data][:attributes][:user_id]).to eq(nick.id)
  end
end
