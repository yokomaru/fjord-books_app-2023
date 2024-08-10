# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    user = User.new(email: 'foo@example.com', name: 'Foo')
    report = user.reports.new(title: 'title', content: 'content')
    assert report.editable?(user)

    other_user = User.new(email: 'bar@example.com', name: 'Bar')
    assert_not report.editable?(other_user)
  end

  test '#created_on' do
    user = User.create!(email: 'foo@example.com', name: 'Foo', password: 'password')
    report = user.reports.create!(title: 'title', content: 'content')
    assert_equal Time.zone.now.to_date, report.created_on
  end
end
