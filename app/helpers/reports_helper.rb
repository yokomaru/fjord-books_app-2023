# frozen_string_literal: true

module ReportsHelper
  def format_auto_link(content)
    Rinku.auto_link(format_content(content), :urls, 'target="_blank" rel="noopener noreferrer"', nil, Rinku::AUTOLINK_SHORT_DOMAINS)
  end
end
