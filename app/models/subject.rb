class Subject < ApplicationRecord
  belongs_to :teacher

  validates_presence_of :name, :school_year
  
end