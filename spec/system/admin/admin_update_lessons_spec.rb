require 'rails_helper'

describe 'Admin updates lesson' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    lesson = Lesson.create!(name: 'Ruby Fundamentos',
                   length: 60,
                   content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                   course: course )

    visit admin_course_path(course)
    click_on 'Ruby Fundamentos'

    expect(current_path).to eq(admin_course_lesson_path(course, lesson))
    click_on 'Editar'
    expect(current_path).to eq(edit_admin_course_lesson_path(course,lesson))

    fill_in 'Duração', with: 120

    click_on 'Salvar'

    expect(page).to have_content('120 minutos')

  end

end