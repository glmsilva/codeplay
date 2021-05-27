require 'rails_helper'

describe 'Visitor views courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS',
                            price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))



    visit root_path
    click_on 'Cursos'

    expect(page).to have_text('Ruby on Rails')
    expect(page).to have_text('Um curso de Ruby on Rails')
    expect(page).to have_text('R$ 20,00')
  end

  it 'and view details' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS',
                            price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(current_path).to eq(course_path(course))
  end
end