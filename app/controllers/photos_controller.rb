class PhotosController < InheritedResource::Base
    def photo_params
        params.require(:image).permit(:article, :description, :image_file_name, :image_content_type, :image_file_size, :image_updated_at)
    end
end
