require "rails_helper"


RSpec.describe LessonsController do 
  describe "GET #new" do 
    it "should setup up the lesson instance variable" do 
      get :new
      expect(assigns(:lesson)).to be_an_instance_of(Lesson)
    end   
    it "should render the new template" do 
      get :new
      expect(response).to render_template :new
    end
  end 

  describe "POST create" do 
    context "when valid" do 
      it "should create a lesson in the DB"
      it "should create a corresponding number of sections that were submitted with the lesson"
      it "redirect to new lesson view"
      it "flashes success message"
    end 
    context "when invalid" do 
      it "doesnt create any record in the DB"
      it "sets up the instance variable for lesson instance"
      it "renders the new view"
      
    end 


  end 

end 

