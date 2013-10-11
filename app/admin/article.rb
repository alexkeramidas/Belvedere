ActiveAdmin.register Article do
    controller do
        def permitted_params
            params.permit article: [:title, :description, :visible, :article_type]
        end
    end
end
