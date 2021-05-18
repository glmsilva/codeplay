require 'rails_helper'

describe 'admin view instructors' do
  it 'successfully' do
    instructor = Instructor.create(name: 'Guilherme', email: 'guilherme@email.com', bio: 'Um professor de ruby')
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'support', 'imagem_professor.png')),
                                      filename: 'imagem_professor.png')
    instructor2 = Instructor.create(name: 'John', email: 'john@email.com', bio: 'Um professor de rails')
    instructor2.profile_picture.attach(io: File.open(Rails.root.join('spec', 'support', 'imagem_professor.png')),
                                       filename: 'imagem_professor.png')

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Guilherme')
    expect(page).to have_css('img[src*="imagem_professor.png"]')
    expect(page).to have_content('John')
    expect(page).to have_css('img[src*="imagem_professor.png"]')
  end

  it 'and view details' do
    instructor = Instructor.create(name: 'John', email: 'john@email.com', bio: 'Um professor de rails')
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'support', 'imagem_professor.png')),
                                      filename: 'imagem_professor.png')

    visit instructors_path
    click_on 'John'

    expect(page).to have_content('John')
    expect(page).to have_content('john@email.com')
    expect(page).to have_content('Um professor de rail')
    expect(page).to have_css('img[src*="imagem_professor.png"]')

  end

  it 'and no instructors avaiable' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor disponível')
  end

  it 'and return to homepage' do
    instructor = Instructor.create(name: 'John', email: 'john@email.com', bio: 'Um professor de rails')
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'support', 'imagem_professor.png')),
                                      filename: 'imagem_professor.png')

    visit instructors_path
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to instructors page' do
    instructor = Instructor.create(name: 'John', email: 'john@email.com', bio: 'Um professor de rails')
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'support', 'imagem_professor.png')),
                                      filename: 'imagem_professor.png')

    visit instructors_path
    click_on 'John'
    click_on 'Voltar'
    expect(current_path).to eq instructors_path
  end
end



