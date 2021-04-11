require 'rails_helper'

describe Movie, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :tmdb_id}
  end
end
