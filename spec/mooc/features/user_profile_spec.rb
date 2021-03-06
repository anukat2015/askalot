require 'spec_helper'

describe 'User Profile', type: :feature do
  let(:user) { create :user }

  context 'with edX user who has no password' do
    it 'disallows editing of password', js: true do
      login_as user

      user.update(encrypted_password: nil)

      visit shared.edit_user_registration_path

      click_link 'Účet'

      expect(page).not_to have_field('user_password', disabled: true)
      expect(page).not_to have_field('user_password_confirmation', disabled: true)

      click_button 'Uložiť'

      expect(page).to have_content('Úspešne ste aktualizovali Váš účet.')
      expect(page.current_path).to eql(shared.edit_user_registration_path)

      expect(Mooc::User.find_by(login: user.login).encrypted_password).to be_blank
    end
  end
end
