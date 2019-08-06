require "rails_helper"


RSpec.describe AssignmentChaptersController do 
  describe "GET #show" do 
    it "should assign an instance variable an instance of assignment_chapter" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      params = {id:assignment_chapter.id}
      get :show, params: params
      expect(assigns(:assignment_chapter)).to be_an_instance_of(AssignmentChapter)


    end 
    it "should render the show template" do 
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      params = {id:assignment_chapter.id}
      get :show, params: params
      expect(response).to render_template :show
    end 
  end 

  describe "PUT #update" do 
    context "when valid" do
      it "should update the assignment record with the answer content being filled out" do
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section = Fabricate(:section, lesson_id:lesson.id) 
        assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        params = {id:1,"assignment_chapter"=>{"answer"=>"the answer is 2", "completed"=>"true"}}
        patch :update, params: params, format: :json
        assignment = AssignmentChapter.first
        answer = assignment.answer
        completed = assignment.completed 
        expect(answer).to eq("the answer is 2")
        expect(completed).to eq(true)
      end
      it "should open the next section" do 
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section_one = Fabricate(:section, lesson_id:lesson.id) 
        section_two = Fabricate(:section, lesson_id:lesson.id) 
        assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        assignment_chapter_one = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        assignment_chapter_two = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        params = {id:1,"assignment_chapter"=>{"answer"=>"the answer is 2", "completed"=>"true"}}
        patch :update, params: params, format: :json
        chapter = AssignmentChapter.find_by(id:assignment_chapter_two.id)
        expect(chapter.accessible).to eq(true)

      end 
      # it "should open the next assignment if all current assignment sections are completed" do 
      #   student = Fabricate(:student)
      #   teacher = Fabricate(:teacher)
      #   subject = Fabricate(:subject,teacher_id:teacher.id)
      #   lesson = Lesson.new(subject_id:subject.id, name:"math")
      #   lesson.save(:validate => false)
      #   section_one = Fabricate(:section, lesson_id:lesson.id) 
      #   section_two = Fabricate(:section, lesson_id:lesson.id) 
        
      #   assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      #   assignment_chapter_one = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      #   assignment_two = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      #   assignment_two_chapter_one = Fabricate(:assignment_chapter,assignment_id:assignment_two.id)
        
      #   params = {id:1,"assignment_chapter"=>{"answer"=>"the answer is 2", "completed"=>"true"}}
      #   patch :update, params: params, format: :json
      #   processed_assignment = Assignment.find_by(id:assignment_two.id)
      #   expect(assignment_two.accessible).to eq(true)
      # end 
      it "should render the student as json with all the students current progress" do 
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
        lesson = Lesson.new(subject_id:subject.id, name:"math")
        lesson.save(:validate => false)
        section_one = Fabricate(:section, lesson_id:lesson.id) 
        section_two = Fabricate(:section, lesson_id:lesson.id) 
        assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        assignment_chapter_one = Fabricate(:assignment_chapter,assignment_id:assignment.id)
        params = {id:1,"assignment_chapter"=>{"answer"=>"the answer is 2", "completed"=>"true"}}
        patch :update, params: params, format: :json
        full_student_info = Student.where(id:student.id).includes(assignments:[:assignment_chapters]).as_json(:include=>{:assignments=>{:include=>{:assignment_chapters=>{}}}})
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['student'][0]["full_name"]).to eq(full_student_info[0]["full_name"])
        
      end 

    end
  end 


end 



