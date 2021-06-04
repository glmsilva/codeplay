require 'rails_helper'

describe 'Admin updates lesson' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category = Category.create!(name: 'Web')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            status: 0,
                            category: category,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    Lesson.create!(name: 'Javascript Fundamentos',
                   length: 50,
                   content: 'Aprenda javascript',
                   course: course)
    lesson = Lesson.create!(name: 'Ruby Fundamentos',
                            length: 60,
                            content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                            course: course)
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'
    click_on 'Ruby Fundamentos'

    expect(current_path).to eq(admin_course_lesson_path(course, lesson))
    click_on 'Editar'
    expect(current_path).to eq(edit_admin_course_lesson_path(course, lesson))

    fill_in 'Duração', with: 120

    click_on 'Salvar'

    expect(page).to have_content('120 minutos')

  end

end