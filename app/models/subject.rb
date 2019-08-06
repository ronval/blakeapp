class Subject < ApplicationRecord
  belongs_to :teacher
  has_many :lessons
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :assignments
  validates_presence_of :name, :school_year
end


