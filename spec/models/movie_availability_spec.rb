require 'rails_helper'

describe MovieAvailability, type: :model do
  describe 'relationships' do
    it do
      should belong_to :movie
      should belong_to :service
    end
  end
end
