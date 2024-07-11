# frozen_string_literal: true

module ReportsHelper
  def format_auto_link(content)
    Rinku.auto_link(format_content(content), :urls, 'target="_blank" rel="noopener noreferrer"', nil, Rinku::AUTOLINK_SHORT_DOMAINS)
  end

  # 現在の時刻と日報の作成日の差分を求め経過時間を表示
  def display_time_difference_between_now_and_created_at(created_at)
    time_difference = Time.zone.now - created_at

    if time_difference < 60 # 秒
      "#{time_difference.floor} seconds ago"
    elsif time_difference > 60 && time_difference < 3600 # 分
      "#{(time_difference / 60).floor} minutes ago"
    elsif time_difference > 3600 && time_difference < 86_400 # 時
      "#{(time_difference / 3600).floor} hour ago"
    elsif time_difference > 86_400 && time_difference < 2_592_000 # 日
      "#{(time_difference / 86_400).floor} day ago"
    elsif time_difference > 2_592_000 && time_difference < 31_536_000 # 月
      "#{(time_difference / 2_592_000).floor} month ago"
    elsif time_difference > 31_536_000 # 月
      "#{(time_difference / 31_536_000).floor} year ago"
    end
  end
end
