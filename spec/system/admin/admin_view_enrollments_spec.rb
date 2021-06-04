require 'rails_helper'

describe 'Admin view enrollments' do 
  it 'view link to see enrollments' do 
    admin = User.create!(email: 'admin@teste.com.br', password: '123456',status: 1, is_admin: true) 
    login_as admin, scope: :user

    visit root_path
    expect(page).to have_content('Compras')
  end

  it 'and view enrollments' do 
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    category =  Category.create!(name: 'Mobile')
    course1 = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   category: category,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    course2 = Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   category: category,
                   enrollment_deadline: '20/12/2033', instructor: instructor)
    

    user = User.create!(name: 'Jane Doe', email: 'jane@test.com.br', password: '123456', status: 1, is_admin: false)
    admin = User.create!(email: 'john@codeplay.com.br', password: '123456', status: 1, is_admin: true)

    enrollment1 = Enrollment.create!(user: user, course: course1) 
    enrollment2 = Enrollment.create!(user: user, course: course2)
    login_as admin, scope: :user

    visit root_path 
    click_on 'Compras'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content( 'R$ 20,00')
    expect(page).to have_content(enrollment1.created_at)
    expect(page).to have_content('Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content(enrollment2.created_at)
    expect(page).to have_content('Jane Doe')



  end
end
