require "rails_helper"


RSpec.describe LessonsController do 

  describe "GET #new" do 
    it "should setup up the lesson instance variable" do 
      get :new
      expect(assigns(:lesson)).to be_an_instance_of(Lesson)
    end   
    it "should render the new template" do 
      
    end 
  end 

end 