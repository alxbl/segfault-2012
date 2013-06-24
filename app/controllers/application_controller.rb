class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    # On the first visit, look at Accept-language and select the preferred language
    if !cookies[:lang_autodetected]
      I18n.locale = extract_locale_from_header
      if I18n.locale != I18n.default_locale && Language.find_by_code(I18n.locale)
        cookies[:lang_autodetected] = true
        redirect_to "/#{I18n.locale}#{request.fullpath}" # Redirect to the same page, different locale.
      end
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end

  def default_url_options(options={})
    { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale } # Don't put a locale for English
  end

  private
  def extract_locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
