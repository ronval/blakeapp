class AssignmentChaptersController < ApplicationController

  def show
    @assignment_chapter = AssignmentChapter.find_by(id:params[:id])
    @subject = @assignment_chapter.assignment.subject
  end

  def update
    @assignment_chapter = AssignmentChapter.find_by(id:params[:id])
    assignment = @assignment_chapter.assignment
    subject = assignment.subject
    student = assignment.student

    if @assignment_chapter.update(answer_params)
      
      assignment.open_next_section
      if assignment.completed?
        assignment.update_columns(completed:true)
        assignment.reload
        Assignment.open_next_assignment(subject.id, student.id)
      end
      assignment.reload
      @assignment_chapter
      full_student_info = Student.where(id:student.id).includes(assignments:[:assignment_chapters]).as_json(:include=>{:assignments=>{:include=>{:assignment_chapters=>{}}}})
      
      respond_to do |format|
        format.json {render :json=>{student:full_student_info, message:"You have submitted your answer"}}
        format.html {render :html}
      end 
      
    else  
      render :show
    end 
  end

  def answer_params
    params.require(:assignment_chapter).permit(:id,:answer, :completed)
  end
end



