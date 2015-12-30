require 'rails_helper'

describe "the signin form" do
  let!(:users_count) { User.count }
  it "allows user registration" do
    visit '/register'
    within '#new_user' do
      fill_in '名前', with: 'ひろのまゆこ'
      fill_in 'メールアドレス', with: 'xxx@example.com'
      fill_in 'パスワード', with: '123456'
      fill_in 'パスワード(確認)', with: '123456'
      click_button('登録する')
    end

    expect(page).to have_content 'ログアウト'
    expect(User.count).to eq users_count + 1
  end
end
