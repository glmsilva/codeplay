class Course < ApplicationRecord
  belongs_to :instructor
  has_many :lessons
  has_many :enrollments

  validates :name, :price, :code, presence: true
  validates :code, uniqueness: true

  enum status: { published: 0, draft: 1 }

  has_one_attached :banner
  extend FriendlyId
  friendly_id :name, use: :slugged
end