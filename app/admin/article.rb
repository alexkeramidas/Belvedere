include ActiveAdmin::ViewsHelper

ActiveAdmin.register Article, :as => 'News' do
    languages = language_list

    menu :priority => 3

    config.per_page = 10

    index do
        selectable_column
        column :title
        column :description do |a|
            sanitize(a.description, :tags => []).html_safe.truncate(500)
        end
        column :visible
        column :created_at
        column :updated_at
        actions
    end

    show do |v|
        attributes_table do
            row :created_at
            row :translations do
                ul do
                    v.translations.each do |article|
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

    form do |f|
        f.inputs "News Details" do
            f.input :visible
        end
        f.has_many :article_translations do |p|
            unless p.object.new_record?
                p.input :_destroy, :as => :boolean, :label => "Remove Translation?", :required => false
            end
            p.input :locale, :label => 'Language', :collection => languages, :as => :select, :include_blank => false
            p.input :title
            p.input :description, :as => :rich, :config => { :width => '76%', :height => '100px' }
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit article: [:title, :description, :visible, :article_type => 1, :article_translations_attributes => [:id, :locale, :title, :description, :_destroy]]
        end
        def scoped_collection
            Article.valid
        end
    end
end
