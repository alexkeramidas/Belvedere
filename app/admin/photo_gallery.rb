include ActiveAdmin::ViewsHelper

ActiveAdmin.register PhotoGallery, :as => 'Galleries' do
    menu :priority => 2, :parent => "Website"

    languages = language_list

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
        column :description do |p|
            sanitize(p.description, :tags => []).html_safe.truncate(500)
        end
        column :visible
        column :created_at
        column :updated_at
        actions
    end

    show do |ad|
        attributes_table do
            row :created_at
            row :translations do
                ul do
                    ad.translations.each do |article|
                        li do
                            l = languages.detect { |lang| lang[1] == article.locale.to_s }[0]
                            t = article.title
                            d = sanitize(article.description, :tags => []).html_safe.truncate(1000)
                            "<b>#{l}:</b> #{t}<br><br>#{d}".html_safe
                        end
                    end
                end
            end
            row :images do
                ul :style => 'list-style:none;' do
                    ad.photos.each do |img|
                        li :style => 'float:left; margin-right:10px;' do
                            image_tag(img.decorate.photo_path(:thumb))
                        end
                    end
                end
            end
            row :visible
        end
    end

    form :html => { :multipart => true} do |f|
        f.inputs "Gallery" do
            # f.input :title
            # f.input :description
            f.input :visible
        end
        f.has_many :article_translations,   heading: 'Photo Gallery Translations' do |t|
            unless t.object.new_record?
                t.input :_destroy, :as => :boolean, :label => "Remove Translation?", :required => false
            end
            t.input :locale, :label => 'Language', :collection => languages, :as => :select, :include_blank => false
            t.input :title
            t.input :description
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
             params.permit photo_gallery: [:title, :description, :visible, :article_type => 3,  :photos_attributes => [:id, :article_id, :description, :image, :_destroy], :article_translations_attributes => [:id, :locale, :title, :description, :_destroy]]
        end

        def scoped_collection
            PhotoGallery.valid
        end
    end
end
