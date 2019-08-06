require "rails_helper"


RSpec.describe ClassRoomsController do 
  describe "GET #index" do 
    it "assigns the teacher to an instance variable" do
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      get :index
      expect(assigns(:teacher)).to eq(teacher)
    end 

    it "assigns the teachers subjects to an instance variable" do
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      get :index
      subjects = teacher.subjects
      expect(assigns(:subjects)).to eq(subjects)
    end 



  end 
  describe "GET #show" do 
    it "assigns the subject to an instance variable" do
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      params = {id:subject.id}
      get :show, params:params
      expect(assigns(:subject)).to eq(subject)
    end

    it "assigns the students to an instance variable" do
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      student = Fabricate(:student)
      Fabricate(:enrollment, student_id:student.id, subject_id:subject.id)
      params = {id:subject.id}
      get :show, params:params
      students = subject.students
      expect(assigns(:students)).to eq(students)
    end 


  end 


end 