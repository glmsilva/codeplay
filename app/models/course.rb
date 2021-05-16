class Course < ApplicationRecord
  validates :name, :description, :price, :enrollment_deadline, presence: {
    message: 'não pode ficar em branco' }
  validates :code, presence: {message: 'não pode ficar em branco'}, uniqueness: { message: 'já está em uso'}

end  
