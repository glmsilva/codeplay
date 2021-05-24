require 'rails_helper'

describe 'Admin view lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033',
                   instructor: instructor,
                   banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    course2 = Course.create!(name: 'Javascript',
                   description: 'Um curso de Javascript',
                   code: 'Javascript', price: 20,
                   enrollment_deadline: '20/12/2033',
                   instructor: instructor,
                   banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')))
    Lesson.create!(name: 'Active Storage',
                   length: 60,
                   course: course )
    Lesson.create!(name: 'CRUD',
                   length: 60,
                   course: course)
    Lesson.create!(name: 'Javascript',
                   length: 40,
                   course: course2)

    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on 'Ver Aulas'

    expect(page).to have_text('Active Storage')
    expect(page).to have_text('60 minutos')
    expect(page).to have_text('CRUD')
    expect(page).not_to have_content('Javascript')
  end
end
