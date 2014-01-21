ActiveAdmin.register Article, :as => 'News' do

    languages = [['English - EN','en'],['Deutsch - DE','de'],['Greek - EL','el'],['Espanol - ES','es'],['Francais - FR','fr'],['Italiano - IT','it'],['Russian - RU','ru']]

    menu :priority => 3

    config.per_page = 10

    index do
        selectable_column
        column :title
        column :description
        column :visible
        column :created_at
        column :updated_at
        default_actions
    end

    show do |v|
        attributes_table do
            row :title
            row :description
            row :translations do
                ul do
                    v.translations.each do |article|
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

    form do |f|
        f.inputs "News Details" do
            f.input :title
            f.input :description, :as => :rich, :config => { :width => '76%', :height => '200px' }
            f.input :visible
        end
        f.has_many :article_translations do |p|
            unless p.object.new_record?
                p.input :_destroy, :as => :boolean, :label => "Remove Translation?", :required => false
            end
            p.input :locale, :label => 'Language', :collection => languages, :as => :select
            p.input :title
            p.input :description, :as => :rich, :config => { :width => '76%', :height => '100px' }
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit news: [:title, :description, :visible, :article_type => 1, :article_translations_attributes => [:id, :locale, :title, :description, :_destroy]]
        end
        def scoped_collection
            Article.valid
        end
    end
end
