# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'

    click_button 'ログイン', exact: true
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit users_url
    assert_selector 'h1', text: 'ユーザの一覧'
  end

  test 'visiting the show' do
    visit users_url
    assert_selector 'h1', text: 'ユーザの一覧'
    click_link 'このユーザを表示', match: :first, exact: true
    assert_selector 'h1', text: 'ユーザの詳細'
    assert_text 'Bob'
    assert_text 'bob@example.com'
  end
end
