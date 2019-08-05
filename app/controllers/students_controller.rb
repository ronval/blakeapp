class StudentsController < ApplicationController

  def new
    @student = Student.new
    @subjects = Subject.all
  end

  def create
    @student = Student.new(student_params)
    @subjects = Subject.all
    
    if @student.save
      Enrollment.create(student_id:@student.id, subject_id:params[:student][:subject_id])
      lessons = Lesson.where(subject_id:params[:student][:subject_id])
      lessons.each do |lesson|
        assignment = Assignment.create(student_id:@student.id, lesson_id:lesson.id, subject_id:params[:student][:subject_id])
        lesson.sections.each do |section|
          AssignmentChapter.create(assignment_id:assignment.id, content:section.content)
        end
      end
        
      Assignment.where(student_id:@student.id, subject_id:params[:student][:subject_id]).first.update_columns(accessible:true)
      
      flash[:success] = "You added a new student"
      redirect_to new_student_path
    else
      render :new
    end 
  end

  private

    def student_params
      params.require(:student).permit(:full_name, :email, :subject_id)
    end

end

