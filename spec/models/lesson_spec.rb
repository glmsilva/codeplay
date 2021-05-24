require 'rails_helper'

describe Lesson do
  context 'Validation' do
    it 'Attributes cannot be blank' do
      lesson = Lesson.new

      lesson.valid?

      expect(lesson.errors[:name]).to include('não pode ficar em branco')
      expect(lesson.errors[:length]).to include('não pode ficar em branco')
    end
  end
end
