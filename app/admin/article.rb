ActiveAdmin.register Article, :as => 'News' do
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

    form do |f|
        f.inputs do
            f.input :title
            f.input :description, :as => :rich, :config => { :width => '76%', :height => '400px' }
            f.input :visible
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit news: [:title, :description, :visible, :article_type => 1]
        end
        def scoped_collection
            Article.valid
        end
    end
end
