class Photo < ActiveRecord::Base
    belongs_to :suite, :foreign_key => 'article_id'

    has_attached_file :image,
                      :url => "/photos/:style/:filename",
                      :path => ":rails_root/public/photos/:style/:filename",
                      :styles => { :medium => "300x300>", :thumb => "100x100>" },
                      :default_url => "/assets/missing.png"
    
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

    def generate_url(style = :original)
        if file_exists(style)
            image.url(style, timestamp: false)
        else
            missing_url
        end
    end

    def generate_path(style = :original)
        if file_exists(style)
            image.path(style, timestamp: false)
        else
            missing_url
        end
    end
    
    def missing_url
        ActionController::Base.new.view_context.image_path('missing.png')
    end
    
    def file_exists(style = :original)
        if image.exists?
            photo_exists = (image.options[:storage] == :s3) ? AWS::S3::S3Object.exists?(image.url(style), bucket_name) : File.exist?(image.path(style))
        else
            photo_exists = false
        end
    end
end
