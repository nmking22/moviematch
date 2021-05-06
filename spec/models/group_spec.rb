require 'rails_helper'

describe Group, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it do
      should have_many :user_groups
      should have_many(:users).through(:user_groups)
    end
  end
end
