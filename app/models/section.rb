class Section < ApplicationRecord
  belongs_to :lesson, inverse_of: :sections
  validates_presence_of :content
  # has_one :answer
end 