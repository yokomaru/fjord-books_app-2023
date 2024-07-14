# frozen_string_literal: true

module ReportsHelper
  ONE_MINUTE_SECONDS = 60
  ONE_HOUR_SECONDS = 3600
  ONE_DAY_SECONDS = 86_400
  ONE_MONTH_SECONDS = 2_592_000
  ONE_YEAR_SECONDS = 31_536_000

  def format_auto_link(content)
    Rinku.auto_link(format_content(content), :urls, 'target="_blank" rel="noopener noreferrer"', nil, Rinku::AUTOLINK_SHORT_DOMAINS)
  end

  # 現在の時刻と日報の作成日の差分を求め経過時間を表示
  def display_passed_time(created_at)
    passed_seconds = Time.zone.now - created_at

    if passed_seconds < ONE_MINUTE_SECONDS
      passed_time_pluralize(passed_seconds.floor, 'second').to_s
    elsif seconds_between_min_and_max_time_units?(passed_seconds, ONE_MINUTE_SECONDS, ONE_HOUR_SECONDS)
      passed_time_pluralize(calculate_seconds_to_time_unit(passed_seconds, ONE_MINUTE_SECONDS), 'minute').to_s
    elsif seconds_between_min_and_max_time_units?(passed_seconds, ONE_HOUR_SECONDS, ONE_DAY_SECONDS)
      passed_time_pluralize(calculate_seconds_to_time_unit(passed_seconds, ONE_HOUR_SECONDS), 'hour').to_s
    elsif seconds_between_min_and_max_time_units?(passed_seconds, ONE_DAY_SECONDS, ONE_MONTH_SECONDS)
      passed_time_pluralize(calculate_seconds_to_time_unit(passed_seconds, ONE_DAY_SECONDS), 'day').to_s
    elsif seconds_between_min_and_max_time_units?(passed_seconds, ONE_MONTH_SECONDS, ONE_YEAR_SECONDS)
      passed_time_pluralize(calculate_seconds_to_time_unit(passed_seconds, ONE_MONTH_SECONDS), 'month').to_s
    elsif passed_seconds > ONE_YEAR_SECONDS
      passed_time_pluralize(calculate_seconds_to_time_unit(passed_seconds, ONE_YEAR_SECONDS), 'year').to_s
    end
  end

  private

  def seconds_between_min_and_max_time_units?(passed_seconds, min_time_unit_seconds, max_time_unit_seconds)
    (min_time_unit_seconds..max_time_unit_seconds).cover?(passed_seconds)
  end

  def calculate_seconds_to_time_unit(passed_seconds, unit_seconds)
    (passed_seconds / unit_seconds).floor
  end

  def passed_time_pluralize(time, time_unit)
    "#{time} #{time_unit.pluralize(time)} ago"
  end
end
