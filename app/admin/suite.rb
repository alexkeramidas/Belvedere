ActiveAdmin.register Suite, :as => 'Rooms' do
    config.per_page = 10

    index do
        column :title
        column :description
        column :visible
        column :created_at
        column :updated_at
        default_actions
    end

    form :html => { :multipart => true} do |f|
        f.inputs "Room" do
            f.input :title
            f.input :description
            f.input :visible
        end
        f.inputs "Photos" do
            f.has_many :photos do |p|
                p.input :description
                p.input :image, :as => :file
            end
        end
        f.buttons
    end

    controller do
        def permitted_params
            params.permit rooms: [:title, :description, :visible, :article_type => 2,  photos_attributes: [:suite_id, :description, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at]]
        end
        def scoped_collection
            Suite.valid
        end
    end
end
