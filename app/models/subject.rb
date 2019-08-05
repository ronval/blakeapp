class Subject < ApplicationRecord
  belongs_to :teacher
  validates_presence_of :name, :school_year
  has_many :lessons
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :assignments
end


