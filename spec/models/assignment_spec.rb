require "rails_helper"

RSpec.describe Assignment do 
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:lesson) }
    it { should belong_to(:subject) }
    it { should have_many(:assignment_chapters) }
  end

end