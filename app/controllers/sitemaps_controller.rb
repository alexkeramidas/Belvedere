class SitemapsController < ApplicationController
    caches_page :index
    
    def index
        @static_paths = [about_path, location_path, photo_gallery_path, accommodation_path, contact_path]
        @articles = Article.valid.visible
        
        respond_to do |format|
            format.xml
        end
    end
end
