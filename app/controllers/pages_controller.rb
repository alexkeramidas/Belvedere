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
        
        @arrival_regex = date_to_regex
        @departure_regex = date_to_regex(1.day.from_now)
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
                    @bg_list << { filename: photo.decorate.photo_path(:original), title: photo.description, default: def_flag }
                end
            end
        end
    end
    
    def date_to_regex(t = Time.new)
        y = t.year.to_s
        m = t.strftime('%m')
        d = t.strftime('%d')
        
        y_later_regex = "(#{"[#{y[0].to_i + 1}-9][0-9][0-9][0-9]|" if y[0].to_i < 9}#{"#{y[0]}[#{y[1].to_i + 1}-9][0-9][0-9]|" if y[1].to_i < 9}#{"#{y[0]}#{y[1]}[#{y[2].to_i + 1}-9][0-9]|" if y[2].to_i < 9}#{"#{y[0]}#{y[1]}#{y[2]}[#{y[3].to_i + 1}-9]" if y[3].to_i < 9})"
        m_later_regex = "(#{"#{m[0].to_i + 1}[0-2]|#{m[0]}[#{m[1].to_i + 1}-9]" if m[0].to_i == 0}#{"#{m[0]}[#{m[1].to_i + 1}-2]" if m[0].to_i == 1 && m[1].to_i < 2})"
        d_later_regex = "(#{"#{d[0].to_i + 3}[0-1]|[#{d[0].to_i + 1}-#{d[0].to_i + 2}][0-9]|#{d[0].to_i}[#{d[1]}-9]" if d[0].to_i == 0}#{"#{d[0].to_i + 2}[0-1]|#{d[0].to_i + 1}[0-9]|#{d[0]}[#{d[1]}-9]" if d[0].to_i == 1}#{"#{d[0].to_i + 1}[0-1]|#{d[0]}[#{d[1]}-9]" if d[0].to_i == 2}#{"#{d[0]}[#{d[1]}-1]" if d[0].to_i == 3})"
        
        m_general_regex = "(0[1-9]|1[0-2])"
        d_general_regex = "(0[1-9]|[1-2][0-9]|3[0-1])"
        
        regex = "^(#{y_later_regex}-#{m_general_regex}-#{d_general_regex}|#{y}-#{m_later_regex}-#{d_general_regex}|#{y}-#{m}-#{d_later_regex})$"
    end
end
