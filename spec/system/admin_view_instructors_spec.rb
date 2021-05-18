require 'rails_helper'

describe 'admin view instructors' do 
  it 'successfully' do 
    Instructor.create!(name: 'Guilherme', email: 'guilherme@email.com', bio: 'Um professor de ruby')

    visit instructors_path

    expect(page).to have_content('Guilherme')
    expect(page).to have_content('guilherme@email.com')
    expect(page).to have_content('Um professor de ruby')

  end
end



