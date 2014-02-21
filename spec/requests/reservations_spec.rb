require 'spec_helper'

describe 'Reservations' do
    describe 'GET /reservations' do
        I18n.available_locales.each do |locale|
            it "Adds a new reservation" do
                visit root_path(locale)
                fill_in 'name', :with => "Alex Keramidas"
                fill_in 'email', :with => "alexkeramidas@gmail.com"
                fill_in 'phone', :with => "00306979005888"
                fill_in 'mobile', :with => "00302413013252"
                fill_in 'arrival', :with => "2014-02-25"
                fill_in 'departure', :with => "2014-02-28"
                fill_in 'adults', :with => "4"
                fill_in 'children', :with => "2"
                fill_in 'message', :with => "Room with a view"
                click_button I18n.t('main.reservation.request')

                current_path.should == root_path(locale)
                page.should have_content I18n.t('main.room')
                save_and_open_page
           end
        end
    end
end
