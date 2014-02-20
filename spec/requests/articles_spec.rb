require 'spec_helper'

describe 'Articles' do
    describe 'GET /articles' do
        I18n.available_locales.each do |locale|
            it 'display some articles' do
                visit articles_path(locale)
                page.should have_content 'Belvedere Hotel'
            end
        end
    end
end
