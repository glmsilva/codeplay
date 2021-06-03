require 'rails_helper'

describe 'students views courses' do
  it 'with enrollment still available' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    unavaiable_course = Course.create!(name: 'Laravel',
                                       description: 'Um curso de Laravel',
                                       code: 'LARAVEL',
                                       price: 20,
                                       enrollment_deadline: 1.day.ago,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))



    visit root_path
    click_on 'Cursos'

    expect(page).to have_text('Ruby on Rails')
    expect(page).to have_text('Um curso de Ruby on Rails')
    expect(page).to have_text('R$ 20,00')
    expect(page).not_to have_text('Laravel')
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

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(current_path).to eq(course_path(avaialable_course))
  end

  it 'and view enrollment link' do

    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on avaialable_course.name

    expect(page).to have_link('Comprar')
  end

  it 'must be signed in to enroll' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    visit root_path
    click_on 'Cursos'
    click_on avaialable_course.name

    expect(page).to have_link('Comprar', href: new_user_session_path)
  end

  it 'and buy a course' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    other_course = Course.create!(name: 'Elixir',
                                       description: 'Um curso de Elixir',
                                       code: 'ELIXIRBASIC',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'
    click_on 'Comprar'

    expect(page).to have_content('Curso comprado com sucesso')
    expect(current_path).to eq my_courses_courses_path
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
    expect(page).not_to have_content('Elixir')
    expect(page).not_to have_content(other_course.price)
  end

  it 'and cannot buy a course twice' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)
    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on avaialable_course.name

    expect(page).not_to have_link('Comprar')
    expect(page).to have_link('Ver aulas')

  end

  it 'and view lessons link from courses page' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       status: 0,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'

    expect(page).not_to have_link('Comprar')
    expect(page).to have_link('Ver aulas')

  end

  it 'and view lessons link from my courses page' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    avaialable_course = Course.create!(name: 'Ruby on Rails',
                                       description: 'Um curso de Ruby on Rails',
                                       code: 'RUBYONRAILS',
                                       price: 20,
                                       enrollment_deadline: 1.month.from_now,
                                       instructor: instructor,
                                       banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    Enrollment.create!(user: user, course: avaialable_course, price: avaialable_course.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus cursos'
    expect(page).to have_link('Ver aulas')
  end
end