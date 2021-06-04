require 'rails_helper'

describe 'Student attend lessons' do
  it 'and view link to mark class as completed' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category = Category.create!(name: 'Web')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       category: category,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    lesson = Lesson.create!(name: 'Ruby Fundamentos',
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
  end


  it 'succesfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category = Category.create!(name: 'Web')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       category: category,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    lesson = Lesson.create!(name: 'Ruby Fundamentos',
                   length: 60,
                   content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                   course: avaialable_course)
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)

    login_as user, scope: :user

    visit root_path
    click_on 'Meus cursos'
    click_on 'Ver aulas'
    click_on  'Ruby Fundamentos'
    click_on 'Marcar aula como concluída'

    expect(page).to have_content('Aula concluída')
    expect(page).not_to have_link('Marcar aula como concluída')
  end

  it 'and view other lessons to complete' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category = Category.create!(name: 'Web')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       category: category,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    lesson = Lesson.create!(name: 'Ruby Fundamentos',
                            length: 60,
                            content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                            course: avaialable_course)
    Lesson.create!(name: 'Active Storage',
                   length: 30,
                   content: 'Aprenda sobre Active Storage.',
                   course: avaialable_course)
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)
    AttendLesson.create!(user: user, lesson: lesson)

    login_as user, scope: :user

    visit root_path
    click_on 'Meus cursos'
    click_on 'Ver aulas'

    expect(page).to have_content('Ruby Fundamentos')
    expect(page).to have_content('Aula concluída')
    expect(page).to have_content('Active Storage')
    expect(page).to have_content('Marcar aula como concluída')
  end

end