class SuitesController < ApplicationController
    def index
        @rooms = Suite.valid.visible
    end
end
