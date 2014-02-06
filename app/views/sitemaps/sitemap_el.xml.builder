xml.instruct!
xml.urlset(xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:xhtml' => 'http://www.w3.org/1999/xhtml') do
    xml.url do
        xml.loc root_url(locale: :el)
        
        @locales.each do |loc|
            xml.xhtml :link, rel: 'alternate', hreflang: loc, href: root_url(locale: loc)
        end
    end

    @static_paths.each do |path|
        xml.url do
            xml.loc "#{root_url(locale: :el)}#{path}"
            
            @locales.each do |loc|
                xml.xhtml :link, rel: 'alternate', hreflang: loc, href: "#{root_url(locale: loc)}#{path}"
            end
        end
    end
    
    @articles.each do |article|
        xml.url do
            xml.loc "#{root_url(locale: :el)}#{article_path(id: article.id, locale: nil)}"
            
            @locales.each do |loc|
                xml.xhtml :link, rel: 'alternate', hreflang: loc, href: "#{root_url(locale: loc)}#{article_path(id: article.id, locale: nil)}"
            end
            
            xml.lastmod article.updated_at.strftime('%F')
        end
    end
end
