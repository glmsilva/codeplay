require 'rails_helper'

describe 'Admin deletes lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', price: 20,
                            enrollment_deadline: '20/12/2033',
                            instructor: instructor,
                            banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.png')),
                            slug: 'ruby-fundamentos')
    lesson = Lesson.create!(name: 'Ruby Fundamentos',
                            length: 60,
                            content: 'Aprenda sobre Ruby, uma linguagem de script orientada a objetos que você pode usar sozinha ou como parte do framework web Ruby on Rails.',
                            course: course )
    user = User.create!(email: 'jane@test.com.br', password: '123456', is_admin: true)

    login_as user, scope: :user
    visit admin_course_path(course)
    click_on 'Ruby Fundamentos'

    expect { click_on 'Apagar' }.to change { Lesson.count }.by(-1)

    expect(page).to have_text('Aula apagada com sucesso')
    expect(current_path).to eq(admin_course_path(course))
  end
end