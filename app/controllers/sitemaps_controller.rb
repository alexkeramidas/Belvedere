class SitemapsController < ApplicationController
    caches_page :index, :sitemap_en, :sitemap_el, :sitemap_de, :sitemap_es, :sitemap_fr, :sitemap_it, :sitemap_ru
    
    before_action :load_locales
    before_action :set_paths, only: [:sitemap_en, :sitemap_el, :sitemap_de, :sitemap_es, :sitemap_fr, :sitemap_it, :sitemap_ru]
    
    def index
        respond_to do |format|
            format.xml
        end
    end
    
    def sitemap_en
        respond_to do |format|
            format.xml
        end
    end
    
    def sitemap_el
        respond_to do |format|
            format.xml
        end
    end
    
    def sitemap_de
        respond_to do |format|
            format.xml
        end
    end
    
    def sitemap_es
        respond_to do |format|
            format.xml
        end
    end
    
    def sitemap_fr
        respond_to do |format|
            format.xml
        end
    end
    
    def sitemap_it
        respond_to do |format|
            format.xml
        end
    end
    
    def sitemap_ru
        respond_to do |format|
            format.xml
        end
    end
    
    private
    
    def load_locales
        @locales = I18n.available_locales
    end
    
    def set_paths
        @static_paths = [about_path(locale: nil), accommodation_path(locale: nil), services_path(locale: nil), location_path(locale: nil), contact_path(locale: nil), photo_gallery_path(locale: nil), articles_path(locale: nil)]
        @articles = Article.valid.visible.order(:id)
    end
end
