require "rails_helper"

RSpec.describe Lesson do 
  describe 'associations' do
    it { should belong_to(:subject) }
    it { should have_many(:sections) }
    it { should have_one(:assignment) }
    
  end

end