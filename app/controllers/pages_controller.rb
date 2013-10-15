class PagesController < ApplicationController
    layout 'map', only: :location
    
    def home
        @bg_list = [
            { filename: "bg1.jpg", default: true }, 
            { filename: "bg2.jpg", default: false }, 
            { filename: "bg3.jpg", default: false }, 
            { filename: "bg4.jpg", default: false }, 
            { filename: "bg5.jpg", default: false }
        ]
    end

    def about

    end
    
    def location
        
    end
end
