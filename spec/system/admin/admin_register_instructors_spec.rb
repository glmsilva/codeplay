require 'rails_helper'

describe 'Admin register instructors' do
  it 'from index page' do
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Registrar um Professor',
                              href: new_admin_instructor_path)
  end

  it 'successfully' do
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome', with: 'Jane Doe'
    fill_in 'Bio', with: 'Uma professora de Ruby on Rails'
    fill_in 'Email', with: 'janedoe@codeplay.com.br'
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/instructor_image.png')
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(admin_instructor_path(Instructor.last))
    expect(page).to have_content('Jane Doe')
    expect(page).to have_content('Uma professora de Ruby on Rails')
    expect(page).to have_content('janedoe@codeplay.com.br')
    expect(page).to have_css('img[src*="instructor_image.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    visit admin_instructors_path
    click_on 'Registrar um Professor'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    Instructor.create!(name: 'Fulano Sicrano',
                       bio: 'Um professor de Ruby',
                       email: 'fulano@codeplay.com.br',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor_image.png')))

    visit admin_instructors_path
    click_on 'Registrar um Professor'
    fill_in 'Email', with: 'fulano@codeplay.com.br'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('já está em uso')
  end
end