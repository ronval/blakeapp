class ClassRoomsController < ApplicationController

  def index
    @teacher = Teacher.first
    @subjects = @teacher.subjects
  end

  def show
    @subject = Subject.find_by(id:params[:id])
    @students = @subject.students
  end

end 

