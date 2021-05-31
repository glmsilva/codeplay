class Course < ApplicationRecord
  belongs_to :instructor
  has_many :lessons

  validates :name, :price, :code, presence: true
  validates :code, uniqueness: true

  has_one_attached :banner
  extend FriendlyId
  friendly_id :name, use: :slugged
end