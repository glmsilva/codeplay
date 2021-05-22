class Instructor < ApplicationRecord
  has_many :courses
  has_one_attached :profile_picture

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def display_name
    "#{name} - #{email}"
  end
end