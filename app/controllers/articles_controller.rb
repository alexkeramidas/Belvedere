class ArticlesController < ApplicationController
    before_action :set_article, only: :show

    # GET /articles
    # GET /articles.json
    def index
        @articles = Article.valid.visible
    end

    # GET /articles/1
    # GET /articles/1.json
    def show

    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
        @article = Article.valid.visible.find(params[:id])
    end
end
