class ArticlesController < ApplicationController
    before_action :set_articles, only: [:index, :show]
    before_action :set_article, only: :show
    
    def index
        if params.has_key?(:page) && (params[:page] == '1' || params[:page] == '')
            redirect_to articles_path, :status => :moved_permanently
        else
            if (params[:page].to_i > 1 && @articles.blank?) || (params.has_key?(:page) && params[:page].to_s != params[:page].to_i.to_s)
                render 'public/404', layout: false, :status => 404
            end
        end
    end

    def show

    end

    private
    
    def set_articles
        @per_page = 5
        @articles = Article.paginated(params[:page], @per_page).valid.visible
    end

    def set_article
        @article = Article.valid.visible.find(params[:id])
    end
end
