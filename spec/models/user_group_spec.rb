require 'rails_helper'

describe UserGroup, type: :model do
  describe 'relationships' do
    it do
      should belong_to :user
      should belong_to :group
    end
  end
end
