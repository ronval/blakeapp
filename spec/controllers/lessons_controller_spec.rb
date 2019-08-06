require "rails_helper"


RSpec.describe LessonsController do 
  describe "GET #new" do 
    it "should setup up the lesson instance variable" do 
      get :new
      expect(assigns(:lesson)).to be_an_instance_of(Lesson)
    end
    it "should setup up the subjects instance variable" do 
      teacher = Fabricate(:teacher,id:1)
      subject_one = Fabricate(:subject,name:"English", teacher_id:teacher.id)
      subject_two = Fabricate(:subject, name:"Math", teacher_id:teacher.id)
      get :new
      expect(assigns(:subjects)).to include(subject_one, subject_two)
    end    
    it "should render the new template" do 
      get :new
      expect(response).to render_template :new
    end
  end 

  describe "POST create" do 
    context "when valid" do 
      it "should create a lesson in the DB" do 
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
        
        params = {lesson:{"subject_id"=>subject.id, "name"=>"Light Sabers", "sections_attributes"=>{"0"=>{"content"=>"sdhgfisudhfgoisdufghi", "_destroy"=>"false"}, "1"=>{"content"=>"sdigufhosdifughodigf", "_destroy"=>"false"}}}}
        post :create, params:params

        expect(Lesson.count).to eq(1)
      end 
      it "should create a corresponding number of sections that were submitted with the lesson" do
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
         
        params = {lesson:{"subject_id"=>subject.id, "name"=>"Light Sabers", "sections_attributes"=>{"0"=>{"content"=>"History of the light saber", "_destroy"=>"false"}, "1"=>{"content"=>"Red light sabers", "_destroy"=>"false"}}}}
        post :create, params:params
        first_section_content = Lesson.first.sections.first.content
        last_section_content = Lesson.first.sections.last.content
        expect(first_section_content).to eq("History of the light saber")
        expect(last_section_content).to eq("Red light sabers")
      end 

      it "should create one assignment for each student in the class" do 
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
        Fabricate(:enrollment, student_id:student.id, subject_id:subject.id)
        params = {lesson:{"subject_id"=>subject.id, "name"=>"Light Sabers", "sections_attributes"=>{"0"=>{"content"=>"History of the light saber", "_destroy"=>"false"}, "1"=>{"content"=>"Red light sabers", "_destroy"=>"false"}}}}
        post :create, params:params
        lesson = Lesson.first
        student_assignment_count = Assignment.where(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id).count
        expect(subject.students.count).to eq(student_assignment_count)
      end

      it "should create one assignment chapter for each section in a lesson" do 
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
        Fabricate(:enrollment, student_id:student.id, subject_id:subject.id)
        params = {lesson:{"subject_id"=>subject.id, "name"=>"Light Sabers", "sections_attributes"=>{"0"=>{"content"=>"History of the light saber", "_destroy"=>"false"}, "1"=>{"content"=>"Red light sabers", "_destroy"=>"false"}}}}
        post :create, params:params
        lesson = Lesson.first
        sections_count = lesson.sections.count
        assignment = Assignment.where(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id).first
        assignment_chapter_count = assignment.assignment_chapters.count
        expect(sections_count).to eq(assignment_chapter_count)
      end  

      it "redirect to new lesson path" do 
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
         
        params = {lesson:{"subject_id"=>subject.id, "name"=>"Light Sabers", "sections_attributes"=>{"0"=>{"content"=>"History of the light saber", "_destroy"=>"false"}, "1"=>{"content"=>"Red light sabers", "_destroy"=>"false"}}}}
        post :create, params:params
        expect(response).to redirect_to new_lesson_path
      end 
      it "flashes success message" do 
        student = Fabricate(:student)
        teacher = Fabricate(:teacher)
        subject = Fabricate(:subject,teacher_id:teacher.id)
         
        params = {lesson:{"subject_id"=>subject.id, "name"=>"Light Sabers", "sections_attributes"=>{"0"=>{"content"=>"History of the light saber", "_destroy"=>"false"}, "1"=>{"content"=>"Red light sabers", "_destroy"=>"false"}}}}
        post :create, params:params
        expect(flash[:success]).to eq("You have created a new lesson.")
      end 
    end





    context "when invalid" do 
      it "doesnt create a lesson record in the DB" do 
        params = {lesson:{"subject_id"=>"1", "sections_attributes"=>{"0"=>{"content"=>"sdhgfisudhfgoisdufghi", "_destroy"=>"false"}, "1"=>{"content"=>"sdigufhosdifughodigf", "_destroy"=>"false"}}}}
        post :create, params:params
        expect(Lesson.count).to eq(0)
      end 
      it "doesnt create a section if empty record in the DB" do 
        params = {lesson:{"subject_id"=>"1", "sections_attributes"=>{"0"=>{"content"=>"", "_destroy"=>"false"}}}}
        post :create, params:params
        expect(Section.count).to eq(0)
      end
      it "doesnt create a lesson if there is no corresponding section" do 
        params = {lesson:{"subject_id"=>"1", "name"=>"Light Sabers"}}
        post :create, params:params
        expect(Lesson.count).to eq(0)
      end 
      it "sets up the instance variable for lesson instance" do 
        params = {lesson:{"subject_id"=>"1", "name"=>"Light Sabers"}}
        post :create, params:params
        expect(assigns(:lesson)).to be_an_instance_of(Lesson)
      end 
      it "sets up the subjects instance variable with collection of all subjects" do 
        teacher = Fabricate(:teacher,id:1)

        subject_one = Fabricate(:subject,name:"English", teacher_id:teacher.id)
        subject_two = Fabricate(:subject, name:"Math", teacher_id:teacher.id)
        params = {lesson:{"subject_id"=>"1", "name"=>"Light Sabers"}}
        post :create, params:params
        expect(assigns(:subjects)).to include(subject_one, subject_two)


      end 
      it "renders the new view" do 
        params = {lesson:{"subject_id"=>"1", "name"=>"Light Sabers"}}
        post :create, params:params
        expect(assigns(:lesson)).to be_an_instance_of(Lesson)
        expect(response).to render_template :new
      end
    end 
  end 

  describe "POST #start_lesson" do
    it "should update the assignment chapter to visible" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      params = {assignment_chapter_id:assignment_chapter.id, subject_id:subject.id}
      post :start_lesson, params:params
      assignment_chapter.reload
      expect(assignment_chapter.accessible).to eq(true)
    end 
    it "should set flash message" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      params = {assignment_chapter_id:assignment_chapter.id, subject_id:subject.id}
      post :start_lesson, params:params
      
      expect(flash[:success]).to eq("You can now start the section")
    end 
    it "should redirect to class" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      params = {assignment_chapter_id:assignment_chapter.id, subject_id:subject.id}
      post :start_lesson, params:params
      
      expect(response).to redirect_to class_path(id:subject.id)

    end 
  end

end 

