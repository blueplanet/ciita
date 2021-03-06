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
  given!(:my_items) { create_list :item, 5, user: user }
  background do
    login_with user

    within '.navbar-nav.navbar-right' do
      click_on user.email
    end
  end

  scenario 'マイページにアクセスできる', js: true do
    within 'ul.dropdown-menu' do
      click_on 'マイページ'
    end

    expect(current_path).to eq user_path(user)
    expect(page).to have_content '最近の投稿'
    my_items.each do |item|
      expect(page).to have_content item.title
    end
  end

  scenario 'ログイン情報を更新できる', js: true do
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
    within 'ul.dropdown-menu' do
      click_on 'ログアウト'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'ログアウトしました。'
    expect(page).to_not have_content user.email
  end
end

feature 'ユーザは、気になる情報を管理したい' do
  given!(:user) { create :user }
  given!(:other_user) { create :user }
  given!(:tag) do
    item = create :item, tag_list: 'tag1'
    item.tags.first
  end

  background do
    login_with user
  end

  scenario '他のユーザをフォローできる' do
    visit user_path(other_user)
    expect(page).to have_content '0 Contribution'

    click_on 'フォローする'
    expect(page).to have_content 'フォローを解除する'
    expect(page).to have_content '1 Contribution'

    click_on 'フォローを解除する'
    expect(page).to have_content 'フォローする'
    expect(page).to have_content '0 Contribution'
  end

  scenario 'タグをフォローできる' do
    visit tag_path(id: tag.name)
    expect(page).to have_content '0フォロワー'

    click_on 'フォローする'
    expect(page).to have_content 'フォローを解除する'
    expect(page).to have_content '1フォロワー'

    click_on 'フォローを解除する'
    expect(page).to have_content 'フォローする'
    expect(page).to have_content '0フォロワー'
  end
end
