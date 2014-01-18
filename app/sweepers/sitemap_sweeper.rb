class SitemapSweeper < ActionController::Caching::Sweeper
    observe :article
 
    def sweep(article)
        expire_page(sitemap_path)
    end
 
    alias_method :after_create, :sweep
    alias_method :after_destroy, :sweep
end
