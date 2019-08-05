class Lesson < ApplicationRecord
  has_many :sections, inverse_of: :lesson
  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
  validates_associated :sections
  validates_presence_of :name
  validate :presence_of_sections
  belongs_to :subject
  has_one :assignment


  def presence_of_sections
    if sections.size < 1
      errors.add(:base, "You must add at least one section to a lesson.")
    end
  end


 

  
end 