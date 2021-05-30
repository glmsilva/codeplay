require 'rails_helper'

describe 'Admin view instructors' do
  it 'succesfully' do
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user

    Instructor.create!(name: 'Fulano Sicrano',
                       email: 'fulano@codeplay.com.br',
                       bio: 'Um professor da codeplay',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor_image.png')))

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_css('img[src*="instructor_image.png"]')
  end

  it 'and view details' do
    Instructor.create!(name: 'Fulano Sicrano',
                       email: 'fulano@codeplay.com.br',
                       bio: 'Um professor da codeplay',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor_image.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user
    visit admin_instructors_path
    click_on 'Fulano Sicrano'

    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_css('img[src*="instructor_image.png"]')
    expect(page).to have_content('fulano@codeplay.com.br')
    expect(page).to have_content('Um professor da codeplay')

  end

  it 'and return to home page' do
    Instructor.create!(name: 'Fulano Sicrano',
                       email: 'fulano@codeplay.com.br',
                       bio: 'Um professor da codeplay',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor_image.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user
    visit admin_instructors_path
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to instructors page' do
    Instructor.create!(name: 'Fulano Sicrano',
                       email: 'fulano@codeplay.com.br',
                       bio: 'Um professor da codeplay',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor_image.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user
    visit admin_instructors_path
    click_on 'Fulano Sicrano'
    click_on 'Voltar'

    expect(current_path).to eq admin_instructors_path
  end

end