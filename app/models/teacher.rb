class Teacher < ApplicationRecord
  has_many :subjects
  validates_presence_of :full_name, :phone, :email
  has_many :students, through: :subjects
  
end 