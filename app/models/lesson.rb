class Lesson < ApplicationRecord
  belongs_to :course
  has_many :attend_lesson

  validates :name, :length, :content, presence: true
  extend FriendlyId
  friendly_id :name, use: :slugged
end
