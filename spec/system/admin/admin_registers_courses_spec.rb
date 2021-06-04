require 'rails_helper'

describe 'Admin registers courses' do
  it 'from index page' do

    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'

    expect(page).to have_link('Registrar um Curso',
                              href: new_admin_course_path)
  end

  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)
    Category.create!(name: 'Web')
    Category.create!(name: 'Mobile')

    login_as user, scope: :user

    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '22/12/2033'
    select 'Web', from: 'Categoria'
    select "#{instructor.name} - #{instructor.email}", from: 'Instrutor(a)'
    attach_file 'Banner do Curso', Rails.root.join('spec/fixtures/course.png')
    click_on 'Criar curso'

    expect(current_path).to eq(admin_course_path(Course.last))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_css('img[src*="course.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    click_on 'Criar curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('Instrutor(a) é obrigatório(a)')
  end

  it 'and code must be unique' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category =  Category.create!(name: 'Mobile') 
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   status: 0,
                   category: category,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user

    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Criar curso'

    expect(page).to have_content('já está em uso')
  end

  it 'and course are a draft' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    Category.create!(name: 'Web')      
    Category.create!(name: 'Mobile') 
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user

    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '22/12/2033'
    select "#{instructor.name} - #{instructor.email}", from: 'Instrutor(a)'
    check 'status'
    attach_file 'Banner do Curso', Rails.root.join('spec/fixtures/course.png')
    click_on 'Criar curso'

    expect(current_path).to eq(admin_course_path(Course.last))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_css('img[src*="course.png"]')
    expect(page).to have_content('Rascunho')
    expect(page).to have_link('Publicar')
    expect(page).to have_link('Voltar')
  end

  it 'and publish a draft course' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    
    category = Category.create!(name: 'Web')      
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   status: 1,
                   category: category,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user

    visit admin_courses_path
    click_on 'Ver rascunhos'
    click_on 'Publicar'

    expect(page).to have_content('Publicado')
    expect(page).to have_content('Atualizado com sucesso')

  end
end
