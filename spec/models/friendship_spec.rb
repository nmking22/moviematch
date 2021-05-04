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
end
