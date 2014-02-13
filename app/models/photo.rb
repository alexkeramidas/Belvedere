class Photo < ActiveRecord::Base
    MISSING_URL = '/assets/missing.png'
    
    belongs_to :article, :foreign_key => 'article_id'

    has_attached_file :image,
                      :url => "/photos/:parent_name/:style/:basename_:token.:extension",
                      :path => ":rails_root/public/photos/:parent_name/:style/:basename_:token.:extension",
                      :styles => { :medium => "640x480>", :thumb => "100x100>" },
                      :default_url => Photo::MISSING_URL
    
    validates_attachment_presence :image
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

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
    
    # Object methods
    
    def get_token
        Digest::SHA1.hexdigest(created_at.to_i.to_s)
    end
    
    # Class methods
    
    def self.missing_url
        Photo::MISSING_URL
    end
end
