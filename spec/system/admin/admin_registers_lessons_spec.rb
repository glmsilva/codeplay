require 'rails_helper'

describe 'Admin register lessons' do
  it 'from index page' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            status: 0,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'
    click_on 'Cadastrar Aula'

    expect(current_path).to eq(new_admin_course_lesson_path(course))
  end

  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            status: 0,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'
    click_on 'Cadastrar Aula'

    fill_in 'Nome', with: 'Ruby Fundamentos'
    fill_in 'Conteúdo', with: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.'
    fill_in 'Duração', with: '60'
    click_on 'Salvar'

    expect(current_path).to eq(admin_course_path(course))
    expect(page).to have_content('Ruby Fundamentos')
    expect(page).to have_content('60 minutos')
  end

  it 'and attributes cannot be blank' do
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
    click_on 'Cadastrar Aula'
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end