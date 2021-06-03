class Instructor < ApplicationRecord
  has_many :courses
  has_one_attached :profile_picture

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  enum status: { active: 0, inactive: 1 }

  def display_name
    "#{name} - #{email}"
  end
end