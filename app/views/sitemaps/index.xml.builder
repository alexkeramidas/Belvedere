xml.instruct!
xml.urlset(xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:xhtml' => 'http://www.w3.org/1999/xhtml') do
    xml.url do
        xml.loc root_url.chop
    end

    @static_paths.each do |path|
        xml.url do
            xml.loc "#{root_url.chop}#{path}"
        end
    end
    
    @articles.each do |article|
        xml.url do
            xml.loc "#{root_url.chop}#{url_for(article)}"
            xml.lastmod article.updated_at.strftime('%F')
        end
    end
end
