class Photo < ActiveRecord::Base
    belongs_to :suite, :foreign_key => 'article_id'

    has_attached_file :image,
                      :url => "/photos/:style/:filename",
                      :path => ":rails_root/public/photos/:style/:filename",
                      :styles => { :medium => "300x300>", :thumb => "100x100>" },
                      :default_url => "/images/:style/missing.png"
    
    validates_attachment_presence :image

    def photo_geometry(style = :original)
        @geometry ||= {}
        photo_path = (image.options[:storage] == :s3) ? image.url(style) : image.path(style)
        @geometry[style] ||= Paperclip::Geometry.from_file(photo_path)
    end

    def width
        photo_geometry.width.to_i
    end

    def height
        photo_geometry.height.to_i
    end

end
