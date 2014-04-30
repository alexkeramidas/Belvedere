class PoisController < ApplicationController
    def index
        @pois = Poi.valid.visible
        render json: @pois
    end
    def validpois
        @pois = Poi.valid.visible
        render json: @pois
    end
end
