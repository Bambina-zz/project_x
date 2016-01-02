require 'rails_helper'

feature 'Errand management', js: true do
  given!(:user)   { create(:user) }
  given!(:errand) { create(:errand, owner_id: user.id)}

  background { login_with user.email, user.password }

  scenario 'user is able to create an errand' do
    fill_in '名前', with: 'Errand 1'
    expect {
      click_button '作成する'
      sleep 0.5
    }.to change { Errand.count }.by(1)
  end

  scenario "user is able to edit errand's name" do
    within "#errand_#{errand.id}" do
      click_link '編集'
      fill_in 'errand_name', with: 'new_name'
      click_button '変更する'
      expect(page).to have_selector '.link_to_errand', text: 'new_name'
    end
  end

  scenario 'user is able to delete an errand' do
    expect {
      click_link '削除'
      sleep 0.5
    }.to change { Errand.count }.by(-1)
  end
end
