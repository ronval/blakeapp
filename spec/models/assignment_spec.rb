require "rails_helper"

RSpec.describe Assignment do 
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:lesson) }
    it { should belong_to(:subject) }
    it { should have_many(:assignment_chapters) }
  end


  describe "#open_next_section" do 
    it "sets the next assignment_chapter that is not completed to accessible if the one prior was completed" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = AssignmentChapter.create(completed:true, content:"2+2", assignment_id:assignment.id, answer:"4", accessible:true)
      assignment_chapter_two = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      assignment.open_next_section
      assignment_chapter_two.reload
      expect(assignment_chapter_two.accessible).to eq(true)
    end

    it "doesnt set the next assignment_chapter to accessible if the one prior was not completed" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = AssignmentChapter.create(completed:false, content:"2+2", assignment_id:assignment.id, answer:"4", accessible:true)
      assignment_chapter_two = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      assignment.open_next_section
      assignment_chapter_two.reload
      expect(assignment_chapter_two.accessible).to eq(false)
    end 
  end


  describe "#completed?" do 
    it "returns false when an assignment has sections that were not completed" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      #assignment_chapter = AssignmentChapter.create(completed:true, content:"2+2", assignment_id:assignment.id, answer:"4", accessible:true)
      assignment_chapter = Fabricate(:assignment_chapter,assignment_id:assignment.id)
      expect(assignment.completed?).to eq(false)
    end

    it "returns true when an assignment has sections that were all completed" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_chapter = AssignmentChapter.create(completed:true, content:"2+2", assignment_id:assignment.id, answer:"4", accessible:true)
      assignment_chapter_two = AssignmentChapter.create(completed:true, content:"2+2", assignment_id:assignment.id, answer:"4", accessible:true)
      expect(assignment.completed?).to eq(true)
    end  
  end  


  describe ".open_next_assignment" do 
    it "makes the next assignment accessible for a student in a certain subject if one before is completed" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment_one = Assignment.create(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id, completed:true, accessible:true)
      assignment_one_chapter = AssignmentChapter.create(completed:true, content:"2+2", assignment_id:assignment_one.id, answer:"4", accessible:true)
      
      assignment_two = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_two_chapter = AssignmentChapter.create(completed:false, content:"2+2", assignment_id:assignment_two.id, answer:"4", accessible:false)
      
      Assignment.open_next_assignment(subject.id, student.id)
      assignment_two.reload
      expect(assignment_two.accessible).to eq(true)
    end

    it "makes the next assignments first assignment chapter accessible" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment_one = Assignment.create(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id, completed:true, accessible:true)
      assignment_one_chapter = AssignmentChapter.create(completed:true, content:"2+2", assignment_id:assignment_one.id, answer:"4", accessible:true)
      
      assignment_two = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_two_chapter = AssignmentChapter.create(completed:false, content:"2+2", assignment_id:assignment_two.id, answer:"4", accessible:false)
      
      Assignment.open_next_assignment(subject.id, student.id)
      assignment_two.reload
      assignment_two_chapter.reload
      expect(assignment_two_chapter.accessible).to eq(true)
    end  

    it "doesnt make the next assignment accessible for a student in a certain subject if the one before is not completed" do
      student = Fabricate(:student)
      teacher = Fabricate(:teacher)
      subject = Fabricate(:subject,teacher_id:teacher.id)
      lesson = Lesson.new(subject_id:subject.id, name:"math")
      lesson.save(:validate => false)
      section = Fabricate(:section, lesson_id:lesson.id) 
      assignment_one = Assignment.create(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id, completed:false, accessible:true)
      assignment_one_chapter = AssignmentChapter.create(completed:false, content:"2+2", assignment_id:assignment_one.id, answer:"4", accessible:true)
      
      assignment_two = Fabricate(:assignment, student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
      assignment_two_chapter = AssignmentChapter.create(completed:false, content:"2+2", assignment_id:assignment_two.id, answer:"4", accessible:false)
      
      Assignment.open_next_assignment(subject.id, student.id)
      assignment_two.reload
      expect(assignment_two.accessible).to eq(false)
    end

  end 


















end