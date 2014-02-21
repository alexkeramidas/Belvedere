require 'spec_helper'

describe 'Articles' do
    describe 'GET /articles' do
        I18n.available_locales.each do |locale|
            it 'display some articles' do
                visit articles_path(locale)
                page.should have_content 'Belvedere Hotel'
            end
            # it 'displays an article' do
                # visit article_path(locale)
            # end
            it 'displays a service' do
                visit services_path(locale)
            end
            it 'displays a photo gallery' do
                visit photo_gallery_path(locale)
            end
            it 'displays a room' do
                visit accommodation_path(locale)
            end
            it 'displays root' do
                visit root_path(locale)
            end
            it 'displays about' do
                visit about_path(locale)
            end
            it 'displays location' do
                visit location_path(locale)
            end
            it 'displays contact' do
                visit contact_path(locale)
            end
        end
    end
end
