class ArticlesController < ApplicationController
    before_action :set_article, only: :show

    def index
        @articles = Article.valid.visible
    end

    def show

    end

    private

    def set_article
        @article = Article.valid.visible.find(params[:id])
    end
end
