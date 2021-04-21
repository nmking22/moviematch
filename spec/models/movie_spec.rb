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
      should have_many :swipes
      should have_many(:users).through(:swipes)
    end
  end

  describe 'class methods' do
    it '.needs_details' do
      expect(Movie.needs_details).to eq([])

      create_list(:movie, 3)

      expect(Movie.needs_details).to eq([])

      austin_powers = Movie.create(
        title: 'Austin Powers: International Man of Mystery',
        tmdb_id: 816
      )

      expect(Movie.needs_details).to eq([austin_powers])
    end

    it '.estimated_update_time' do
      expect(Movie.estimated_update_time(44)).to eq('10 second(s)')
      expect(Movie.estimated_update_time(261)).to eq('1 minute(s), 0 second(s)')
      expect(Movie.estimated_update_time(16000)).to eq('1 hour(s), 1 minute(s), 20 second(s)')
    end

    it '.convert_movie_count_to_estimated_seconds' do
      expect(Movie.convert_movie_count_to_estimated_seconds(44)).to eq(10)
      expect(Movie.convert_movie_count_to_estimated_seconds(261)).to eq(60)
      expect(Movie.convert_movie_count_to_estimated_seconds(16000)).to eq(3680)
    end

    it '.hour_plus?' do
      expect(Movie.hour_plus?(400)).to be false
      expect(Movie.hour_plus?(6000)).to be true
    end

    it '.minute_plus?' do
      expect(Movie.minute_plus?(44)).to be false
      expect(Movie.minute_plus?(65)).to be true
    end

    it '.time_in_hours' do
      expect(Movie.time_in_hours(16000)).to eq('4 hour(s), 26 minute(s), 40 second(s)')
    end

    it '.time_in_minutes' do
      expect(Movie.time_in_minutes(261)).to eq('4 minute(s), 21 second(s)')
    end

    it '.time_in_seconds' do
      expect(Movie.time_in_seconds(44)).to eq('44 second(s)')
    end
  end
end
