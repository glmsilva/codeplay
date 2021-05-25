class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :length, :content, presence: true
end
