ActiveAdmin.register Suite, :as => 'Rooms' do
    config.per_page = 10

    filter :photos, collection: proc {Photo.all.map { |photo| [photo.image_file_name, photo.id] }}
    filter :title
    filter :description
    filter :visible
    filter :created_at
    filter :article_type
    filter :updated_at

    index do
        selectable_column
        column :title
        column :description
        column :visible
        column :created_at
        column :updated_at
        default_actions
    end

    show do |ad|
      attributes_table do
        row :title
        row :description
        row :images do
          ul do
            ad.photos.each do |img|
              ul do
                image_tag(img.decorate.photo_path(:medium))
              end
            end
           end
        end
      end
    end

    form :html => { :multipart => true} do |f|
        f.inputs "Room" do
            f.input :title
            f.input :description
            f.input :visible
        end
        f.inputs "Photos" do
            f.has_many :photos do |p|
                unless p.object.new_record?
                    p.input :_destroy, :as=>:boolean, :label => "Delete Image?"
                end
                p.input :description
                p.input :image, :as => :file, :hint => p.object.new_record? ? "" : p.template.image_tag(p.object.decorate.photo_path(:thumb))
            end
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit rooms: [:title, :description, :visible, :article_type => 2,  photos_attributes: [:id, :article_id, :description, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :_destroy]]
        end

        def scoped_collection
            Suite.valid
        end
    end
end
