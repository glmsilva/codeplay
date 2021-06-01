require 'rails_helper'

describe 'Student view lessons' do
  it 'from my courses page' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    Lesson.create!(name: 'Ruby Fundamentos',
                   length: 60,
                   content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                   course: avaialable_course)

    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus cursos'
    click_on 'Ver aulas'

    expect(page).to have_content('Ruby Fundamentos')
    expect(page).to have_content('Aprenda sobre Ruby')
  end

  it 'view from courses page' do

    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    Lesson.create!(name: 'Ruby Fundamentos',
                   length: 60,
                   content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                   course: avaialable_course)
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on 'Ver aulas'


    expect(current_path).to eq(course_lessons_path(avaialable_course))
    expect(page).to have_content('Ruby Fundamentos')
    expect(page).to have_content('Aprenda sobre Ruby')
  end

  it 'and view details' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    Lesson.create!(name: 'Ruby Fundamentos',
                   length: 60,
                   content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                   course: avaialable_course)
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)

    login_as user, scope: :user
    visit course_lessons_path(avaialable_course)
    click_on 'Ruby Fundamentos'

    expect(page).to have_content('Ruby Fundamentos')
    expect(page).to have_content('60 minutos')
    expect(page).to have_content('Aprenda sobre Ruby')
  end
end