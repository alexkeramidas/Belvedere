class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    before_filter :assign_variables
    
    private
    
    def assign_variables
        @bg_list = [ { filename: 'bg1.jpg', default: true } ]
    end
end
