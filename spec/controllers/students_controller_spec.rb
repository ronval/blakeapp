require "rails_helper"


RSpec.describe StudentsController do 
  describe "GET #new" do 
    it "assigns instance variable a student instance" do 
      get :new
      expect(assigns(:student)).to be_an_instance_of(Student)
    end 
    it "assigns instance variable all subjects" do

      teacher = Fabricate(:teacher,id:1)
      subject_one = Fabricate(:subject, name:"English", teacher_id:teacher.id)
      subject_two = Fabricate(:subject, name:"Math", teacher_id:teacher.id)
      get :new
      expect(assigns(:subjects)).to eq([subject_one, subject_two])
    end 
  end

  describe "POST #create" do 
    
      it "assigns instance variable a student instance" do 
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        student = Student.first
        assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        expect(assigns(:student)).to be_an_instance_of(Student)
      end 
      

      it "assigns instance variable all subjects" do
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        student = Student.first
        assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        expect(assigns(:subjects)).to eq([subject])
      end 

      it "creates a student record in DB" do 
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        student = Student.first
        assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        expect(Student.count).to eq(1)
      end 

      it "creates a student enrollment record in DB" do 
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        student = Student.first
        assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        expect(Enrollment.count).to eq(1)
      end

      it "creates one assignment for each lesson of a subject" do
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        student = Student.first
        lesson_count = Lesson.count
        assignment_count = Assignment.where(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id).count
        expect(lesson_count).to eq(assignment_count)
      end

      it "should create one assignment chapter for each section in a lesson" do 
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        student = Student.first
        lesson = Lesson.first
        sections_count = lesson.sections.count
        assignment = Assignment.where(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id).first
        assignment_chapter_count = assignment.assignment_chapters.count
        expect(sections_count).to eq(assignment_chapter_count)
      end 

      it "should make the first assignment/lesson accessible to the student" do 
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        student = Student.first
        lesson = Lesson.first
        sections_count = lesson.sections.count
        assignment = Assignment.where(student_id:student.id, subject_id:subject.id).first
        assignment_chapter_count = assignment.assignment_chapters.count
        expect(assignment.accessible).to eq(true)
      end 
      it "should set flash message" do 
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        expect(flash[:success]).to eq("You added a new student")
      end

      it "should redirect to new student" do 
        teacher = Fabricate(:teacher,id:1)
        subject = Fabricate(:subject, name:"English", teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        params = {student:{full_name:"martin", email:"martin@email.com", subject_id:subject.id}}
        post :create, params: params
        expect(response).to redirect_to new_student_path
      end  
     
     
  end 

end 