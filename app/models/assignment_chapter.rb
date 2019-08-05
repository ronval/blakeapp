class AssignmentChapter < ApplicationRecord
  belongs_to :assignment

  # def sections_completed?
  #   sections = self.assignment_chapters
  #   array = []
  #   sections.each do |section|
  #     if section.completed == false
  #       array.push(section.id)
  #     end 
  #   end 
  #   return array.empty?
  # end


  
end