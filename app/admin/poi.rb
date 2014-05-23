include ActiveAdmin::ViewsHelper

ActiveAdmin.register Poi, :as => 'Pois' do
    menu :priority => 5, :parent => "Website"

    languages = language_list

    config.per_page = 10

    filter :title
    filter :description
    filter :visible
    filter :created_at
    filter :article_type
    filter :updated_at

    index do
        selectable_column
        column :title
        column :description do |r|
            sanitize(r.description, :tags => []).html_safe.truncate(500)
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
            row :visible
        end
    end

    form :html => { :multipart => true} do |f|
        f.inputs "Point of Interest" do
            f.input :visible
        end
        f.has_many :article_translations,  heading: 'Point of Interest Translations' do |t|
            unless t.object.new_record?
                t.input :_destroy, :as => :boolean, :label => "Remove Translation?", :required => false
            end
            t.input :locale, :label => 'Language', :collection => languages, :as => :select, :include_blank => false
            t.input :title
            t.input :description
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit poi: [:title, :description, :visible, :article_type => 5, :article_translations_attributes => [:id, :locale, :title, :description, :_destroy]]
        end

        def scoped_collection
            Poi.valid
        end
    end
end
