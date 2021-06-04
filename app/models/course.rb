class Course < ApplicationRecord
  belongs_to :instructor
  belongs_to :category
  has_many :lessons
  has_many :enrollments


  validates :name, :price, :code, presence: true
  validates :code, uniqueness: true

  enum status: { published: 0, draft: 1 }
  enum category: { beginner: 0, web: 1, mobile: 2 }
  has_one_attached :banner
  extend FriendlyId
  friendly_id :name, use: :slugged
end
