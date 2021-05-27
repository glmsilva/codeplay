require 'rails_helper'

describe 'account management' do
  context 'registration' do
    it 'view registration page' do
      visit root_path
      expect(page).to have_link('Registrar-se')
      click_on 'Registrar-se'

      expect(current_path).to eq(new_user_registration_path)
    end

    it 'with email and password' do
      visit root_path
      click_on 'Registrar-se'
      fill_in 'Email', with: 'jane@doe.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@doe.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar-se')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      visit root_path
      click_on 'Registrar-se'
      click_on 'Criar conta'

      expect(page).to have_content('não pode ficar em branco', count: 2)
    end

    it 'password not match confirmation' do
      visit root_path
      click_on 'Registrar-se'
      fill_in 'Email', with: 'jane@test.com.br'
      fill_in 'Senha', with: 'abcdefg'
      fill_in 'Confirmação de Senha', with: 'abcdex'
      click_on 'Criar conta'

      expect(page).to have_content('Confirmação de Senha não é igual a Senha')
    end

    it 'with email not unique' do
      User.create!(email: 'jane@test.com.br', password: '123456', is_admin: false)
      visit root_path
      click_on 'Registrar-se'
      fill_in 'Email', with: 'jane@test.com.br'
      fill_in 'Senha', with: 'abcdefg'
      fill_in 'Confirmação de Senha', with: 'abcdefg'
      click_on 'Criar conta'

      expect(page).to have_content('Email já está em uso')
    end
  end

  context 'sign in' do
    it 'with email and password' do
      User.create!(email: 'jane@test.com.br', password: '123456', is_admin: false)

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'jane@test.com.br'
      fill_in 'Senha', with: '123456'
      within 'div#login' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@test.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar-se')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      User.create!(email: 'jane@test.com.br', password: '123456', is_admin: false)

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'jane@test.com.br'
      fill_in 'Senha', with: 'abcdefg'
      within 'div#login' do
        click_on 'Entrar'
      end
      expect(page).to have_content('Email ou senha inválida')
    end
  end

  context 'logout' do
    it 'successfully' do
      user = User.create!(email: 'jane@test.com.br', password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('jane@test.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Registrar-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end
