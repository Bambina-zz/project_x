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

  scenario 'user is able to delete an errand' do
    expect {
      click_link '削除'
      sleep 0.5
    }.to change { Errand.count }.by(-1)
  end
end
