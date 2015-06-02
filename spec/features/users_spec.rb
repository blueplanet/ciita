require 'rails_helper'

feature 'ゲストは、ユーザを登録できる'

feature 'ユーザは、自分の情報を管理できる' do
  given!(:user) { create :user }
  background { login_with user }

  scenario 'マイページにアクセスできる', js: true do
    find('.navbar-nav.navbar-right a').click

    within 'ul.dropdown-menu' do
      click_on 'マイページ'
    end

    expect(current_path).to eq user_path(user)
  end

  scenario 'ログイン情報を管理できる'
  scenario 'ログアウトできる'
end
