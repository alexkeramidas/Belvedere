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
    end

    def about

    end

    def location

    end

    def contact

    end
    
    def send_mail
        ContactMailer.contact_email(params[:name], params[:email], params[:comment]).deliver
        redirect_to contact_url(:status => :success) and return
    end

    def photo_gallery
        @gallery = PhotoGallery.latest

        if !@gallery.blank?
            @bg_list = Array.new

            if @gallery.photos.length > 0
                @gallery.photos.each_with_index do |photo, i|
                    i == 0 ? def_flag = true : false
                    @bg_list << { filename: photo.decorate.photo_path(:original), default: def_flag }
                end
            end
        end
    end
end
