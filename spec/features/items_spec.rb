require 'rails_helper'

feature 'ユーザは、投稿を管理したい' do
  given!(:user) { create :user }
  background { login_with user }

  context '他のユーザの投稿の場合' do
    given!(:items) { create_list :item, 10 }

    scenario '他のユーザの投稿を閲覧できる' do
      visit items_path

      items.each do |item|
        expect(page).to have_content item.title
      end
    end

    scenario '他のユーザの投稿にコメントできる' do
      visit item_path(items.last)

      within '#new_comment' do
        click_on '投稿する'
      end

      expect(page).to have_content 'コメントを投稿できませんでした。再度お試しください。'

      within '#new_comment' do
        fill_in 'comment_body', with: '新しいコメント内容'

        click_on '投稿する'
      end

      expect(page).to have_content '新しいコメント内容'
    end

    scenario '他のユーザの投稿を編集できない' do
      visit item_path(items.last)

      expect(page).to_not have_link '投稿を編集する'
    end
  end

  scenario '新しく投稿できる' do
    new_item = build :item

    visit items_path
    click_on 'ノウハウ・Tipsを投稿する'

    click_on 'Ciita に投稿'
    expect(page).to have_content 'タイトルを入力してください。'

    fill_in 'item_title', with: new_item.title
    fill_in 'item_tag_list', with: new_item.tag_list.join(',')
    fill_in 'item_body', with: new_item.body
    click_on 'Ciita に投稿'

    expect(page).to have_content '投稿しました。'
    expect(page).to have_link '投稿を編集する'

    within '.tags' do
      new_item.tag_list.each do |tag|
        expect(page).to have_link tag
      end
    end

    expect(page).to have_content new_item.title
    expect(page).to have_content new_item.body
  end

  scenario '自分の投稿を編集できる' do
    item = create :item, user: user
    update_item = build :item

    visit item_path(item)
    click_on '投稿を編集する'

    fill_in 'item_title', with: ''
    click_on '更新'

    expect(page).to have_content 'タイトルを入力してください。'

    fill_in 'item_title', with: update_item.title
    fill_in 'item_tag_list', with: update_item.tag_list.join(',')
    fill_in 'item_body', with: update_item.body
    click_on '更新'

    within '.tags' do
      update_item.tag_list.each do |tag|
        expect(page).to have_link tag
      end
    end
    expect(page).to have_content update_item.title
    expect(page).to have_content update_item.body
  end

  scenario '投稿をストックできる' do
    item = create :item

    visit item_path(item)
    click_on 'ストック'
    expect(page).to have_content 'ストック解除'

    click_on 'ストック解除'
    expect(page).to have_content 'ストック'
  end
end
