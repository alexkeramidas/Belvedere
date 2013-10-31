class Photo < ActiveRecord::Base
    MISSING_URL = '/assets/missing.png'
    
    belongs_to :suite, :foreign_key => 'article_id'

    has_attached_file :image,
                      :url => "/photos/:style/:filename",
                      :path => ":rails_root/public/photos/:style/:filename",
                      :styles => { :medium => "300x300>", :thumb => "100x100>" },
                      :default_url => Photo::MISSING_URL
    
    validates_attachment_presence :image

    # ATTENTION!! photo_geometry is not to be used directly from within views and controllers,
    # since it will generate an error if the image in question does not exist.
    # Use the decorator's photo_data, photo_path and photo_geometry instead.
    def photo_geometry(style = :original)
        @geometry ||= {}
        photo_path = (image.options[:storage] == :s3) ? image.url(style) : image.path(style)
        @geometry[style] ||= Paperclip::Geometry.from_file(photo_path)
    end

    def generate_url(style = :original)
        image.url(style, timestamp: false)
    end

    def generate_path(style = :original)
        image.path(style, timestamp: false)
    end
    
    # Class methods
    
    def self.missing_url
        Photo::MISSING_URL
    end
end
