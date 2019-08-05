class Student < ApplicationRecord
  attr_accessor :subject_id
  has_many :enrollments
  has_many :subjects, through: :enrollments
  has_many :assignments
  # validates :subject_id, uniqueness: {
  #   message: "This student is already registered to this class. Please pick another subject." }

end 