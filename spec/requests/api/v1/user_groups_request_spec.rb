require 'rails_helper'

describe 'user groups API' do
  it 'can create a user group' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )
    scrantonicity = Group.create(
      name: 'Scrantonicity'
    )

    user_group_params = {
      user_id: nick.id,
      group_id: scrantonicity.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/user_groups", headers: headers, params: JSON.generate(user_group_params)
    user_group = UserGroup.last

    json = JSON.parse(response.body, symbolize_names:true)

    expect(response).to be_successful
    expect(user_group).to be_a(UserGroup)
    expect(user_group.user_id).to eq(nick.id)
    expect(user_group.group_id).to eq(scrantonicity.id)
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(user_group.id.to_s)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('user_group')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes][:id]).to eq(user_group.id)
    expect(json[:data][:attributes]).to have_key(:user_id)
    expect(json[:data][:attributes][:user_id]).to eq(nick.id)
    expect(json[:data][:attributes]).to have_key(:group_id)
    expect(json[:data][:attributes][:group_id]).to eq(scrantonicity.id)
  end

  it 'can delete a user group' do
    nick = User.create(
      uid: '12345678910',
      email: 'nickmaxking@gmail.com',
      first_name: 'Nick',
      last_name: 'King',
      image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
    )
    scrantonicity = Group.create(
      name: 'Scrantonicity'
    )
    user_group = UserGroup.create(
      user: nick,
      group: scrantonicity
    )
    expect(UserGroup.count).to eq(1)

    delete "/api/v1/user_groups/#{user_group.id}"

    expect(response).to be_successful
    expect(UserGroup.count).to eq(0)
    expect{UserGroup.find(user_group.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
