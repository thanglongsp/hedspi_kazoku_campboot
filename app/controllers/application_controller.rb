class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_locale
   
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  
  def default_url_options
    { locale: I18n.locale }
  end
  before_action :set_search
  
  def set_search
    @q = Company.search(params[:q])
  end
end
