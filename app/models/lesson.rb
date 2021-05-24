class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :length, presence: true
end
