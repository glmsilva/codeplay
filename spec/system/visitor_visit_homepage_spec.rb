require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Codeplay')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestão de '\
                                         'cursos e aulas')
  end

  it 'and view search field' do
    visit root_path

    expect(page).to have_content('Pesquisar')
  end

  it 'and search for a course' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category = Category.create!(name: 'Web')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS',
                            price: 20,
                            enrollment_deadline: 1.month.from_now,
                            category: category,
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    visit root_path
    fill_in 'Pesquisar', with: 'Ruby'
    click_on 'Buscar cursos'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Comprar')
  end

  it 'and no courses is available' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category = Category.create!(name: 'Web')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS',
                            price: 20,
                            enrollment_deadline: 1.day.ago,
                            category: category,
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    visit root_path
    fill_in 'Pesquisar', with: 'Ruby'
    click_on 'Buscar cursos'

    expect(page).to have_content('Nada foi encontrado')
  end
end