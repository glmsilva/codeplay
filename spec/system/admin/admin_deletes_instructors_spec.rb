require 'rails_helper'

describe 'Admin deletes instructor' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                       bio: 'Um professor de Ruby',
                       email: 'fulano@codeplay.com.br',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor_image.png')))
    user = User.create!(email: 'jane@test.com.br', password: '123456', status: 1, is_admin: true)

    login_as user, scope: :user
    visit admin_instructor_path(instructor)
    expect { click_on 'Apagar' }.to change { Instructor.count }.by(-1)

    expect(page).to have_text('Professor apagado com sucesso')
    expect(current_path).to eq(admin_instructors_path)
  end
end