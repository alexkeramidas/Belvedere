ActiveAdmin.register Service, :as => 'Services' do
    menu :priority => 2, :parent => "Website"

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
        f.inputs "Service" do
            f.input :title
            f.input :description
            f.input :visible
        end
        f.has_many :photos do |p|
            unless p.object.new_record?
                p.input :_destroy, :as => :boolean, :label => "Delete Image?", :required => false
            end
            p.input :description, :label => "Image Title"
            p.input :image, :as => :file, :hint => p.object.new_record? ? "" : p.template.image_tag(p.object.decorate.photo_path(:thumb)), :label => p.object.image_file_name
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit services: [:title, :description, :visible, :article_type => 4,  photos_attributes: [:id, :article_id, :description, :image, :_destroy]]
        end

        def scoped_collection
            Service.valid
        end
    end
end