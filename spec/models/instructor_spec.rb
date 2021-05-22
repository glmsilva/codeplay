require 'rails_helper'

describe Instructor do
  context 'validation' do
    it 'attributes cannot be blank' do
      instructor = Instructor.new
      instructor.valid?

      expect(instructor.errors[:name]).to include('não pode ficar em branco')
      expect(instructor.errors[:email]).to include('não pode ficar em branco')
    end

    it 'email must be uniq' do
      Instructor.create!(name: 'John Doe',
                         email: 'johndoe@gmail.com',
                         bio: 'um professor de Ruby')
      instructor = Instructor.new(email: 'johndoe@gmail.com')

      instructor.valid?

      expect(instructor.errors[:email]).to include('já está em uso')
    end
  end
end
