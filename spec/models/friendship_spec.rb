require 'rails_helper'

describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user_id}
    it { should validate_presence_of :friend_id}
  end

  describe 'relationships' do
    it do
      should belong_to :user
      should belong_to :friend
    end
  end

  describe 'class methods' do
    it '.exists?' do
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

      expect(Friendship.exists?(nick.id, ron.id)).to eq(false)

      Friendship.create(
        user: nick,
        friend: ron
      )

      expect(Friendship.exists?(nick.id, ron.id)).to eq(true)
    end
  end
end
