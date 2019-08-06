require "rails_helper"

RSpec.describe Subject do 
  describe "associations" do 
    it { should belong_to(:teacher) }
    it { should have_many(:lessons) }
    it { should have_many(:enrollments) }
    it { should have_many(:students) }
    it { should have_many(:assignments) }
  end 
end 