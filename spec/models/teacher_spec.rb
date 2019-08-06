require "rails_helper"

RSpec.describe Teacher do 
  describe "associations" do 
    it { should have_many(:subjects) }
    it { should have_many(:students) }
  end 
end 