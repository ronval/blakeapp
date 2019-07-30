class UiPagesController < ApplicationController
  layout :resolve_layout
  
  def index
    
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