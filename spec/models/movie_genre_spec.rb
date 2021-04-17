require 'rails_helper'

describe MovieGenre, type: :model do
  describe 'relationships' do
    it do
      should belong_to :movie
      should belong_to :genre
    end
  end
end
