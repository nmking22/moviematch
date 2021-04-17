require 'rails_helper'

describe Movie, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :tmdb_id}
  end

  describe 'relationships' do
    it do
      should have_many :movie_availabilities
      should have_many(:services).through(:movie_availabilities)
      should have_many :movie_genres
      should have_many(:genres).through(:movie_genres)
    end
  end
end
