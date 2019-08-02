require "rails_helper"
require "pry"

RSpec.describe SubjectsController do 
  describe "GET #new" do 
    it "renders the new class template" do
      get :new
      expect(response).to render_template :new
    end 
    it "assigns an instance of the class to an instance variable" do
      get :new
      expect(assigns(:subject)).to be_an_instance_of(Subject)
    end
  end 

  describe "POST #create" do 
    context "when valid" do 
      it "create a record in the subject table when valid" do 
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{name:"Chemisty", teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        expect(Subject.count).to eq(1)
      end 
      it "should create association between one class and one teacher" do 
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{name:"Chemisty", teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        class_teacher = Subject.first.teacher
        expect(teacher).to eq(class_teacher)
      end
      it "should redirect to the create new class page" do
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{name:"Chemisty", teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        class_teacher = Subject.first.teacher
        expect(response).to redirect_to new_subject_path
      end 
      it "should show a flash message when it successful" do 
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{name:"Chemisty", teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        class_teacher = Subject.first.teacher
        expect(flash[:success]).to eq("You created a new subject.")
      end  
    end 

    context "when invalid" do
      it "should not create a record if the information is invalid" do
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        expect(Subject.count).to eq(0)
      end
      it "should render the new template" do 
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        expect(response).to render_template :new
      end
      it "should setup an instance of the subject class" do
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        expect(assigns(:subject)).to be_an_instance_of(Subject)
      end 

      it "should setup an instance variable with the collection of teachers" do
        teacher = Fabricate(:teacher,id:1)
        params = {subject:{teacher_id:teacher.id, school_year:"2018/2019"}}
        post :create, params: params
        expect(assigns(:subject)).to be_an_instance_of(Subject)
      end 
    end 
    
    

  end 
end 
  



