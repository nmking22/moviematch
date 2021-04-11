require 'rails_helper'

describe Service, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :watchmode_id}
    it { should validate_presence_of :logo}
  end

  describe 'relationships' do
    it do
      should have_many :movie_availabilities
    end
  end
end
