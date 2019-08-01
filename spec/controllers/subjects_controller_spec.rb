require "rails_helper"


RSpec.describe SubjectsController do 
  describe "GET #new" do 
    it "renders the new class template" do
      get :new
      expect(response).to render_template :new
    end 
    it "assigns an instance of the class to an instance variable" do
      get :new
      expect(assigns(:class)).to be_an_instance_of(Subject)
    end
  end 

  describe "POST #create" do 
    it "create a record in the subject table when valid" do 
      params = {subject:{name:"Chemisty", teacher_id:"1", school_year:"2018/2019"}}
      post :create, params: params
      expect(Subject.count).to eq(1)
    end 
    it "should create association between one class and one teacher" do 
      teacher = Fabricate(:teacher,id:1)
      params = {subject:{name:"Chemisty", teacher_id:teacher.id, school_year:"2018/2019"}}
      post :create, params: params
      class_teacher = Class.first.teacher.id 
      expect(teacher).to eq(class_teacher)
    end 



    it "should not create a record if the information is invalid"
    it "should redirect to the create new class page"
    it "should show a flash message when it successful"

  end 
end 
  



