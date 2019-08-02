require "rails_helper"

RSpec.describe TeachersController do 

  describe "GET #new" do 
    it "should have assign an instance of the teacher class to an instance variable" do 
      get :new
      expect(assigns(:teacher)).to be_an_instance_of(Teacher)
    end 
    it "should render the new teacher template" do 
      get :new
      expect(response).to render_template :new
    end 
  end

  describe "POST #create" do 
    context "when valid" do 
      it "should create a record in the teachers DB table" do 
        params = {teacher:{full_name:"Mr Smith", phone:"1234567890", email:"mr.smith@email.com"}}
        post :create, params:params
        expect(Teacher.count).to eq(1)
    end 
      
      it "should redirect to the new teacher page" do 
        params = {teacher:{full_name:"Mr Smith", phone:"1234567890", email:"mr.smith@email.com"}}
        post :create, params:params
        expect(response).to redirect_to new_teacher_path
      end 
      it "should flash a message that is was successfull" do 
        params = {teacher:{full_name:"Mr Smith", phone:"1234567890", email:"mr.smith@email.com"}}
        post :create, params:params
        expect(flash[:success]).to eq("You created a teacher")
      end 
    end 
    context "when invalid"  do 
      it "should not create a record in the DB" do 
        params = {teacher:{phone:"1234567890", email:"mr.smith@email.com"}}
        post :create, params:params
        expect(Teacher.count).to eq(0)
      end 
      it "should setup an instance variable for rendering the view" do 
        params = {teacher:{phone:"1234567890", email:"mr.smith@email.com"}}
        post :create, params:params
        expect(assigns(:teacher)).to be_an_instance_of(Teacher)
      end 
      it "it should render the new teacher view" do 
        params = {teacher:{phone:"1234567890", email:"mr.smith@email.com"}}
        post :create, params:params
        expect(response).to render_template :new
      end 
    end 


  end 




end