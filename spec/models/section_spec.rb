require "rails_helper"

RSpec.describe Section do 
  describe 'associations' do
    it { should belong_to(:lesson) }
  end

end