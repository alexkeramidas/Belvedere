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
            f.input :title, :input_html => {:name => "article[title]"}
            f.input :description, :input_html => { :class => "tinymce-jquery", :name => "article[description]"}
            f.input :visible, :input_html => {:name => "article[visible]"}
        end
    f.buttons
    end

    controller do
        def permitted_params
            params.permit article: [:title, :description, :visible, :article_type => 1]
        end
        def scoped_collection
            Article.where(:article_type => 1)
        end
    end
end

ActiveAdmin.register Article, :as => 'Room' do

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
            f.input :title, :input_html => {:name => "article[title]"}
            f.input :description, :input_html => { :class => "tinymce-jquery", :name => "article[description]"}
            f.input :visible, :input_html => {:name => "article[visible]"}
        end
    f.buttons
    end

    controller do
        def permitted_params
            params.permit article: [:title, :description, :visible, :article_type => 2]
        end
        def scoped_collection
            Article.where(:article_type => 2)
        end
    end
end
