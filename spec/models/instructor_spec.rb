require 'rails_helper'

describe Instructor do
  context 'validation' do 
    it 'attributes cannot be blank' do
      instructor = Instructor.new

      instructor.valid?

      expect(instructor.errors[:name]).to include('não pode ficar em branco')
      expect(instructor.errors[:email]).to include('não pode ficar em branco')
    end
  end
end
