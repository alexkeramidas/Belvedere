class ArticlesController < ApplicationController
    before_action :set_article, only: :show

    def index
        #@articles = Article.valid.visible
        @articles = Article.order("updated_at").page(params[:page]).per(5).valid.visible
    end

    def show

    end

    private

    def set_article
        @article = Article.valid.visible.find(params[:id])
    end
end
