class Student < ApplicationRecord
  attr_accessor :subject_id
  has_many :enrollments
  has_many :subjects, through: :enrollments
  has_many :assignments
  

end 