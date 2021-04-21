require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email}
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
    it { should validate_presence_of :image}
    it { should validate_presence_of :uid}
  end

  describe 'relationships' do
    it do
      should have_many :swipes
      should have_many(:movies).through(:swipes)
    end
  end
end
