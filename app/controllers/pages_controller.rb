class PagesController < ApplicationController
    layout 'map', only: :location
    
    def home
        @bg_list = [
            { filename: "bg1.jpg", default: true },
            { filename: "bg2.jpg", default: false },
            { filename: "bg3.jpg", default: false },
            { filename: "bg4.jpg", default: false },
            { filename: "bg5.jpg", default: false }
        ]
        
        @res = session[:res]
        session.delete(:res)
    end

    def make_reservation
        days = ((Date.parse(params[:departure]) - Date.parse(params[:arrival])).to_i / 60 / (24 * 60)) + 1
        
        errors = Array.new
        
        res = Reservation.new(name: params[:name], email: params[:email], phone: params[:phone], mobile: params[:mobile], arrival: params[:arrival], departure: params[:departure], days: days, adults: params[:adults], youngsters: params[:children])
        
        begin
            res.save!
        rescue
            errors = res.errors.keys
        end
        
        if !(params[:message].blank? || params[:message].match(/\A#{ApplicationHelper.form_field_attr('message', 6, 300)[:regex]}\Z/i))
            errors << :message
        end
        
        if errors.blank?
            ReservationMailer.request_email(params[:name], params[:email], params[:phone], params[:mobile], DateTime.parse(params[:arrival]), DateTime.parse(params[:departure]), params[:adults], params[:children], params[:message]).deliver
        end
        
        session[:res] = {name: params[:name], email: params[:email], phone: params[:phone], mobile: params[:mobile], arrival: params[:arrival], departure: params[:departure], adults: params[:adults], children: params[:children], message: params[:message], errors: errors}
        redirect_to root_url(anchor: 'reservation') and return
    end
    
    def about

    end

    def location

    end

    def contact
        @contact = session[:contact]
        session.delete(:contact)
    end
    
    def send_mail
        errors = Array.new
        
        if !params[:name].match(/\A#{ApplicationHelper.form_field_attr('name', 2, 100)[:regex]}\Z/i)
            errors << :name
        end
        
        if !params[:email].match(/\A#{ApplicationHelper.form_field_attr('email')[:regex]}\Z/i)
            errors << :email
        end
        
        if !params[:comment].match(/\A#{ApplicationHelper.form_field_attr('contact', 6, 300)[:regex]}\Z/i)
            errors << :comment
        end
        
        if errors.blank?
            ContactMailer.contact_email(params[:name], params[:email], params[:comment]).deliver
        end
        
        session[:contact] = {name: params[:name], email: params[:email], comment: params[:comment],errors: errors}
        redirect_to contact_url and return
    end

    def photo_gallery
        @gallery = PhotoGallery.latest

        if !@gallery.blank?
            @bg_list = Array.new

            if @gallery.photos.length > 0
                @gallery.photos.each_with_index do |photo, i|
                    i == 0 ? def_flag = true : false
                    @bg_list << { filename: photo.decorate.photo_path(:original), title: photo.description, default: def_flag }
                end
            end
        end
    end
end
