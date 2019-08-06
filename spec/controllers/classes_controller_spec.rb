require "rails_helper" 


RSpec.describe ClassesController do 
  describe "GET index" do 
    it "assigns the subject to an instance variable" do
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      student = Fabricate(:student)
      Fabricate(:enrollment, student_id:student.id, subject_id:subject.id)
      subjects = student.subjects
      get :index
      expect(assigns(:subjects)).to eq(subjects)
    end 
  end 


  describe "GET show" do 
    it "assigns the assignment to an instance variable" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section_one = Fabricate(:section, lesson_id:lesson.id) 
      section_two = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter_one = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      assignment_two = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter_two = Fabricate(:assignment_chapter,assignment_id:assignment_two.id)
      params = {id:subject.id}
      get :show, params:params
      a = Assignment.where(student_id:student.id, subject_id:params[:id]).order('created_at ASC')
      expect(assigns(:assignments)).to eq(a)
    end 

    it "orders the assignement in ascending manner" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section_one = Fabricate(:section, lesson_id:lesson.id) 
      section_two = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter_one = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      assignment_two = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter_two = Fabricate(:assignment_chapter,assignment_id:assignment_two.id)
      params = {id:subject.id}
      get :show, params:params
      expect(assigns(:assignments)).to eq([assignment,assignment_two])
    end 
  end 


end 