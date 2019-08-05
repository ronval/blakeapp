class ClassesController < ApplicationController
  before_action :set_student
  def index
    @subjects = @student.subjects
    
  end

  def show
    @assignments = Assignment.where(student_id:@student.id, subject_id:params[:id]).order('created_at ASC')
  end

  private

  def set_student
    @student = Student.last
  end

end 