require 'rails_helper'

describe 'Admin deletes courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category =  Category.create!(name: 'Mobile')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            category: category,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    visit admin_course_path(course)
    expect { click_on 'Apagar' }.to change { Course.count }.by(-1)

    expect(page).to have_text('Curso apagado com sucesso')
    expect(current_path).to eq(admin_courses_path)
  end
end