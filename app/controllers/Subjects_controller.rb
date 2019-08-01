class SubjectsController < ApplicationController 


  def new
    @class = Subject.new
  end

  def create
    Subject.create(subject_params)
  end

  private

  def subject_params
    params.require(:subject).permit(:name,:teacher_id, :school_year)
  end

end 