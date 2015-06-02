require 'rails_helper'

feature 'ゲストは、ユーザを登録できる' do
  given(:user) { build :user }

  scenario '必要な情報を入力しユーザを登録できる' do
    visit root_path
    click_on 'ユーザを新規登録する'

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_on 'アカウント登録'

    expect(current_path).to eq items_path
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  scenario '投稿一覧にアクセスすると、サインイン画面にリダイレクトされる' do
    visit items_path

    expect(current_path).to eq new_user_session_path
  end
end

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

  scenario 'ログイン情報を更新できる', js: true do
    find('.navbar-nav.navbar-right a').click

    within 'ul.dropdown-menu' do
      click_on 'ログイン情報管理'
    end

    expect(current_path).to eq edit_user_registration_path

    new_password = 'foobar123'
    fill_in 'user_password', with: new_password
    fill_in 'user_password_confirmation', with: new_password
    fill_in 'user_current_password', with: user.password

    click_on '更新'

    expect(current_path).to eq items_path
    expect(page).to have_content 'アカウント情報を変更しました。'
  end

  scenario 'ログアウトできる', js: true do
    find('.navbar-nav.navbar-right a').click

    within 'ul.dropdown-menu' do
      click_on 'ログアウト'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'ログアウトしました。'
    expect(page).to_not have_content user.email
  end
end
