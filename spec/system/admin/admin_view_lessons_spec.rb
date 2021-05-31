require 'rails_helper'

describe 'Admin view lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033',
                   instructor: instructor,
                   banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    course2 = Course.create!(name: 'Javascript',
                   description: 'Um curso de Javascript',
                   code: 'Javascript', price: 20,
                   enrollment_deadline: '20/12/2033',
                   instructor: instructor,
                   banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    Lesson.create!(name: 'Ruby Fundamentos',
                   length: 60,
                   content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                   course: course,
                   slug: 'ruby-fundamentos')
    Lesson.create!(name: 'Javascript',
                   length: 40,
                   content: 'Um curso qualquer',
                   course: course2)

    visit root_path
    click_on 'Cursos'
    click_on course.name
    #click_on 'Ver Aulas'

    expect(page).to have_text('Ruby Fundamentos')
    expect(page).to have_text('60 minutos')
    expect(page).not_to have_content('Javascript')
  end

  it 'and no lessons is available' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    visit admin_course_path(course)

    expect(page).to have_content('Nenhuma aula disponível')

  end

  it 'and view details' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    Lesson.create!(name: 'Ruby Fundamentos',
                   length: 60,
                   content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                   course: course)
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    visit admin_course_path(course)
    click_on 'Ruby Fundamentos'
    expect(page).to have_content('Ruby Fundamentos')
    expect(page).to have_content('60 minutos')
    expect(page).to have_content('Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.')
  end
end
