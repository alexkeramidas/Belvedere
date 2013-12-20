class ServicesController < ApplicationController
    def index
        @services = Service.valid.visible
    end
end
