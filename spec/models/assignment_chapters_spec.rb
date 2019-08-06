require "rails_helper"

RSpec.describe AssignmentChapter do 
  describe 'associations' do
    it { should belong_to(:assignment) }
    
  end

end