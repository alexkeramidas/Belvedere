class SitemapSweeper < ActionController::Caching::Sweeper
    observe :article
 
    def sweep(article)
        expire_page(sitemap_en_path)
        expire_page(sitemap_el_path)
        expire_page(sitemap_de_path)
        expire_page(sitemap_es_path)
        expire_page(sitemap_fr_path)
        expire_page(sitemap_it_path)
        expire_page(sitemap_ru_path)
    end
 
    alias_method :after_create, :sweep
    alias_method :after_destroy, :sweep
end
