class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    # On the first visit, look at Accept-language and select the preferred language
    if !session[:locale]
      I18n.locale = extract_locale_from_header
      if I18n.locale != I18n.default_locale && Language.find_by_code(I18n.locale)
        session[:locale] = I18n.locale
        logger.debug "Locale set to #{I18n.locale}"
        redirect_to url_for locale: I18n.locale # Redirect to the same page, different locale.
      end
    end
    # Update the locale if it changed between requests.
    I18n.locale = session[:locale] = params[:locale] || I18n.default_locale if session[:locale] != params[:locale]
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale } # Don't put a locale for English
  end

  private
  def extract_locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
