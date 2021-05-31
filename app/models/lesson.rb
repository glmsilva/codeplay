class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :length, :content, presence: true
  extend FriendlyId
  friendly_id :name, use: :slugged
end
