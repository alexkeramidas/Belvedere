class PhotoDecorator < Draper::Decorator
    delegate_all
    
    def photo_data(style = :original)
        res = {}
        
        begin
            res[:path] = object.generate_url(style)
            res[:geometry] = object.photo_geometry(style)
        rescue
            res[:path] = Photo.missing_url
            res[:geometry] = Paperclip::Geometry.from_file("#{Rails.root.join('app','assets','images')}/#{Photo.missing_url.sub!('/assets/','')}")
        end
        
        res
    end
    
    def photo_path(style = :original)
        data = photo_data(style)
        data[:path]
    end
    
    def photo_geometry(style = :original)
        data = photo_data(style)
        data[:geometry]
    end
end