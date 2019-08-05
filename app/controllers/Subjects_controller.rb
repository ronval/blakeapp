class SubjectsController < ApplicationController 


  def new
    @subject = Subject.new
    @teachers = Teacher.all
  end

  def create
    @subject = Subject.new(subject_params)
    @teachers = Teacher.all
    if @subject.save
      flash[:success] = "You created a new subject."
      redirect_to new_subject_path
    else
      render :new
    end 
  end

  def index
    @subjects = Subject.all
  end

  private

  def subject_params
    params.require(:subject).permit(:name,:teacher_id, :school_year)
  end

end 