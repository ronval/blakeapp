class Teacher < ApplicationRecord
  has_many :subjects
  has_many :students, through: :subjects
  validates_presence_of :full_name, :phone, :email
end 