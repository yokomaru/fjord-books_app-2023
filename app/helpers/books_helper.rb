# frozen_string_literal: true

module BooksHelper
  def switch_language
    if I18n.locale.to_s == 'en'
      link_to(t('views.common.japanese'), locale: 'ja')
    else
      link_to(t('views.common.english'), locale: 'en')
    end
  end
end
