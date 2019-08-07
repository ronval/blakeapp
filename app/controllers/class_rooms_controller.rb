class ClassRoomsController < ApplicationController

  def index
    @teacher = Teacher.last
    @subjects = @teacher.subjects
  end

  def show
    @subject = Subject.find_by(id:params[:id])
    @students = @subject.students
  end

end 

