class TeachersController < ApplicationController
  def new
    @teacher = Teacher.new
  end


  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      flash[:success] = "You created a teacher"
      redirect_to new_teacher_path
    else
      render :new
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:full_name, :phone, :email)
  end
end