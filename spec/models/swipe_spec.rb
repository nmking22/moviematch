require 'rails_helper'

describe Swipe, type: :model do
  describe 'validations' do
    it { should validate_presence_of :rating}
  end

  describe 'relationships' do
    it do
      should belong_to :movie
      should belong_to :user
    end
  end
end
