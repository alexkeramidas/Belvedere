class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    before_filter :set_locale, :assign_variables

    def default_url_options(options = {})
        { locale: I18n.locale }
    end

    private

    #Set locale as query parameter to be used in before filter
    def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
    end

    def assign_variables
        @bg_list = [ { filename: 'bg1.jpg', default: true } ]
    end
end
