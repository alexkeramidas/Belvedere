ActiveAdmin.register Article do
    form do |f|
        f.inputs do
            f.input :title
            f.input :description, :input_html => { :class => "tinymce-jquery"}
            f.input :visible
            f.input :article_type
        end
    f.buttons
    end

    controller do
        def permitted_params
            params.permit article: [:title, :description, :visible, :article_type]
        end
    end
end
