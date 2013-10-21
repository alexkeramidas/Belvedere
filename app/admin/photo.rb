ActiveAdmin.register Photo do

    index do
        column :article_id
        column :description
        column :created_at
        column :updated_at
        column :image_file_name
        column :image_content_type
        column :image_file_size
        column :image_updated_at
        default_actions
    end

    form do |f|
        f.inputs do
            f.input :article_id
            f.input :description
            f.input :image
        end
        f.buttons
    end

    controller do
        def permitted_params
            params.permit photo: [:article_id, :description, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at]
        end
    end
end
