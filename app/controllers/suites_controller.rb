class SuitesController < ApplicationController
    before_action :set_room, only: :show
    
    # GET /articles
    # GET /articles.json
    def index
        @rooms = Article.where(:article_type => 2, :visible => true)
    end

    # GET /articles/1
    # GET /articles/1.json
    def show
        
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_room
        @room = Article.find(params[:id])
    end
end
