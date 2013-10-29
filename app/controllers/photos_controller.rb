class PhotosController < InheritedResources::Base
    def photo_params
        params.require(:image).permit(:suite, :description, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :_destroy)
    end
end
