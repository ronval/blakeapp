class UiPagesController < ApplicationController
  layout :resolve_layout
  
  def index
  end

  def add_class
    
  end

  def add_teacher
    
  end

  def new_lesson
    
  end

  def edit_lesson
    
  end

  def add_student
    
  end

  def student_list
    
  end

  def grade_lesson
    
  end


  

  private

  def resolve_layout
    case action_name
    when "home"
      "main"
    else
      "application"
    end
  end

end 