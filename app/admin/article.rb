ActiveAdmin.register Article, :as => 'News' do

    config.per_page = 10

    index do
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
            f.input :description, :input_html => { :class => "tinymce-jquery" }
            f.input :visible
        end
    f.buttons
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

    form do |f|
        f.inputs do
            f.input :title
            f.input :description, :input_html => { :class => "tinymce-jquery" }
            f.input :visible
        end
    f.buttons
    end

    controller do
        def permitted_params
            params.permit rooms: [:title, :description, :visible, :article_type => 2]
        end
        def scoped_collection
            Suite.valid
        end
    end
end
