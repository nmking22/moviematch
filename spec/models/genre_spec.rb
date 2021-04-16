require 'rails_helper'

describe Genre, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it do
      should have_many :movie_genres
      should have_many(:movies).through(:movie_genres)
    end
  end
end
