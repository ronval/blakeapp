class Assignment < ApplicationRecord
  belongs_to :student
  has_many :assignment_chapters
  belongs_to :lesson
  belongs_to :subject

   def open_next_section
    sections = self.assignment_chapters
    array = []
    sections.each do |section|
      if section.completed == false
        array.push(section.id)
      end 
    end 
    if sections.where(id:array[0]).first
      sections.where(id:array[0]).first.update_columns(accessible:true)
    end 
  end



  def completed?
    sections = self.assignment_chapters
    array = []
    sections.each do |section|
      if section.completed == false
        array.push(section.id)
      end 
    end 
    return array.empty?
  end


  def self.open_next_assignment(subject_id, student_id)
    assignments = Assignment.where(subject_id:subject_id, student_id:student_id)
    array = []
    assignments.each do |assignment|
      if assignment.completed == false
        array.push(assignment.id)
      end 
    end 
    
     # assignments.where(id:array[0]).first.update_columns(accessible:true)
     a =  assignments.where(id:array[0]).first
     a.update_columns(accessible:true)
     chapter = a.assignment_chapters.first.update_columns(accessible:true)
  end







end




