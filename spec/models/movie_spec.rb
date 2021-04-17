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

  describe 'class methods' do
    it '.estimated_update_time' do
      expect(Movie.estimated_update_time(44)).to eq('10 second(s)')
      expect(Movie.estimated_update_time(261)).to eq('1 minute(s), 0 second(s)')
      expect(Movie.estimated_update_time(16000)).to eq('1 hour(s), 1 minute(s), 20 second(s')
    end
  end
end
