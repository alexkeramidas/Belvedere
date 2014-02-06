xml.instruct!
xml.sitemapindex(xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:xhtml' => 'http://www.w3.org/1999/xhtml') do
    @locales.each do |loc|
        xml.sitemap do
            xml.loc sitemap_url(locale: nil).sub('.xml', "-#{loc}.xml")
        end
    end
end
