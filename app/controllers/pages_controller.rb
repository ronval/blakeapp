class PagesController < ApplicationController
  layout :resolve_layout
  
  def home

  end

  private

  def resolve_layout
    case action_name
    when "home"
      "ui_pages"
    else
      "application"
    end
  end

end 