ActiveAdmin.register PhotoGallery, :as => 'Galleries' do
    menu :priority => 3, :parent => "Website"

    languages = [['English - EN','en'],['Deutsch - DE','de'],['Greek - EL','el'],['Espanol - ES','es'],['Francais - FR','fr'],['Italiano - IT','it'],['Russian - RU','ru']]

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
            row :translations do
                ul do
                    ad.translations.each do |article|
                        ul do
                            li do article.locale end
                            ul do article.title end
                            ul do article.description end
                        end
                    end
                end
            end
        end
    end

    form :html => { :multipart => true} do |f|
        f.inputs "Gallery" do
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
        f.has_many :article_translations,   heading: 'Photo Gallery Translations' do |t|
            unless t.object.new_record?
                t.input :_destroy, :as => :boolean, :label => "Remove Translation?", :required => false
            end
            t.input :locale, :label => 'Language', :collection => languages, :as => :select
            t.input :title
            t.input :description
        end
        f.actions
    end

    controller do
        def permitted_params
             params.permit galleries: [:title, :description, :visible, :article_type => 3,  :photos_attributes => [:id, :article_id, :description, :image, :_destroy], :article_translations_attributes => [:id, :locale, :title, :description, :_destroy]]
        end

        def scoped_collection
            PhotoGallery.valid
        end
    end
end
