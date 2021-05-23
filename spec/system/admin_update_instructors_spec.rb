require 'rails_helper'

describe "Admin update instructors" do
  it 'successfully' do
    instructor = Instructor.create!(name: 'John Doe', bio: 'Um professor de Ruby',
                       email: 'johndoe@codeplay.com.br',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor_image.png')))

    visit instructor_path(instructor)
    click_on 'Editar'
    fill_in 'Nome', with: 'João das Neves'
    fill_in 'Bio', with: 'Um professor gelado'
    fill_in 'Email', with: 'johnsnow@codeplay.com.br'
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/instructor_image2.png')
    click_on 'Salvar'

    expect(page).to have_content('João das Neves')
    expect(page).to have_content('Um professor gelado')
    expect(page).to have_content('johnsnow@codeplay.com.br')
    expect(page).to have_css('img[src*="instructor_image2.png"]')
    expect(page).to have_text('Professor atualizado com sucesso')
  end
end