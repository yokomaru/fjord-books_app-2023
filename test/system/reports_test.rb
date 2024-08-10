# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @normal_report = reports(:normal_report)
    @mentioned_report = reports(:mentioned_report)
    @mentioning_report = reports(:mentioning_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン', exact: true
  end

  test 'visiting the index' do
    assert_text 'ログインしました。'

    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create Report' do
    assert_text 'ログインしました。'

    visit reports_url
    assert_selector 'h1', text: '日報の一覧'

    click_on '日報の新規作成', exact: true
    assert_selector 'h1', text: '日報の新規作成'
    fill_in 'タイトル', with: '日報を作成'
    fill_in '内容', with: '日報を作成しました。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '日報を作成'
    assert_text '日報を作成しました。'
    assert_text 'Alice'
    assert_text Time.zone.now.strftime('%Y/%m/%d')
    assert_text '（この日報に言及している日報はまだありません）'
    click_on '日報の一覧に戻る'
  end

  test 'should create Report with Mentions' do
    assert_text 'ログインしました。'

    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
    click_on '日報の新規作成', exact: true
    assert_selector 'h1', text: '日報の新規作成'

    fill_in 'タイトル', with: 'メンション付きの日報を作成'
    fill_in '内容', with: "メンション付きの日報を作成しました。http://localhost:3000/reports/#{@mentioned_report.id}"

    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'メンション付きの日報を作成'
    assert_text "メンション付きの日報を作成しました。http://localhost:3000/reports/#{@mentioned_report.id}"
    assert_text 'Alice'
    assert_text Time.zone.now.strftime('%Y/%m/%d')

    visit report_url(@mentioned_report.id)
    assert_text 'メンション付きの日報を作成'
    assert_text "(Alice - #{Time.zone.now.strftime('%Y/%m/%d')})"
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    assert_text 'ログインしました。'

    visit report_url(@normal_report)
    assert_selector 'h1', text: '日報の詳細'
    click_on 'この日報を編集', exact: true

    fill_in 'タイトル', with: '日報を更新'
    fill_in '内容', with: '日報を更新しました。'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報を更新'
    assert_text '日報を更新しました。'
    assert_text 'Alice'
    assert_text Time.zone.now.strftime('%Y/%m/%d')
    assert_text '（この日報に言及している日報はまだありません）'
    click_on '日報の一覧に戻る'
  end

  test 'should update Report with Mention' do
    assert_text 'ログインしました。'

    visit report_url(@mentioning_report)
    assert_selector 'h1', text: '日報の詳細'
    click_on 'この日報を編集', exact: true

    fill_in 'タイトル', with: '日報をメンションありで更新'
    fill_in '内容', with: "メンション付きの日報を作成しました。http://localhost:3000/reports/#{@mentioned_report.id}"
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報をメンションありで更新'
    assert_text "メンション付きの日報を作成しました。http://localhost:3000/reports/#{@mentioned_report.id}"
    assert_text 'Alice'
    assert_text Time.zone.now.strftime('%Y/%m/%d')

    visit report_url(@mentioned_report.id)
    assert_text '日報をメンションありで更新'
    assert_text "(Alice - #{Time.zone.now.strftime('%Y/%m/%d')})"
    click_on '日報の一覧に戻る'

    visit report_url(@mentioning_report)
    assert_selector 'h1', text: '日報の詳細'
    click_on 'この日報を編集', exact: true

    fill_in 'タイトル', with: '日報をメンションなしで更新'
    fill_in '内容', with: 'メンション部分を削除して更新しました。'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報をメンションなしで更新'
    assert_text 'メンション部分を削除して更新しました。'
    assert_text 'Alice'
    assert_text Time.zone.now.strftime('%Y/%m/%d')

    visit report_url(@mentioned_report.id)
    assert_text '（この日報に言及している日報はまだありません）'
    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    assert_text 'ログインしました。'

    visit report_url(@normal_report)
    click_on 'この日報を削除', exact: true

    assert_text '日報が削除されました。'
  end

  test 'should destroy Report with Mentions' do
    assert_text 'ログインしました。'

    visit report_url(@mentioning_report)
    assert_selector 'h1', text: '日報の詳細'
    click_on 'この日報を編集', exact: true

    fill_in 'タイトル', with: '日報をメンションありで更新'
    fill_in '内容', with: "メンション付きの日報を作成しました。http://localhost:3000/reports/#{@mentioned_report.id}"
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報をメンションありで更新'
    assert_text "メンション付きの日報を作成しました。http://localhost:3000/reports/#{@mentioned_report.id}"
    assert_text 'Alice'
    assert_text Time.zone.now.strftime('%Y/%m/%d')

    visit report_url(@mentioned_report.id)
    assert_text '日報をメンションありで更新'
    assert_text "(Alice - #{Time.zone.now.strftime('%Y/%m/%d')})"
    click_on '日報の一覧に戻る'

    visit report_url(@mentioning_report)
    click_on 'この日報を削除', exact: true
    assert_text '日報が削除されました。'

    visit report_url(@mentioned_report.id)
    assert_text '（この日報に言及している日報はまだありません）'
    click_on '日報の一覧に戻る'
  end
end
