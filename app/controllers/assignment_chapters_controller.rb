class AssignmentChaptersController < ApplicationController

  def show
    @assignment_chapter = AssignmentChapter.find_by(id:params[:id])
  end

  def update
    @assignment_chapter = AssignmentChapter.find_by(id:params[:id])
    assignment = @assignment_chapter.assignment
    subject = assignment.subject
    student = assignment.student
    if @assignment_chapter.update(answer_params)
      flash[:success] = "You answered the question"

      full_student_info = Student.where(id:student.id).includes(assignments:[:assignment_chapters]).as_json(:include=>{:assignments=>{:include=>{:assignment_chapters=>{}}}})
      

      assignment.open_next_section
      if assignment.completed?
        Assignment.open_next_assignment(subject.id, student.id)
      end
      respond_to do |format|
        format.json {render :json=>{student:full_student_info}}
      end 
      
    else  
      render :show
    end 
  end

  def answer_params
    params.require(:assignment_chapter).permit(:answer, :completed)
  end


end



