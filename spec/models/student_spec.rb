require "rails_helper"

RSpec.describe Student do 
  describe "associations" do 
    it { should have_many(:subjects) }
    it { should have_many(:enrollments) }
    it { should have_many(:assignments) }
  end 
end 