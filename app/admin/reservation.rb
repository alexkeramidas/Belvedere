ActiveAdmin.register Reservation do
    menu :priority => 3, :label => "Manage Reservations"

    config.per_page = 20

    filter :arrival
    filter :departure
    filter :days
    filter :adults
    filter :youngsters
    filter :created_at
    filter :updated_at

    index do
        selectable_column
        column :email
        column :name
        column :arrival
        column :departure
        column :days
        column :adults
        column :youngsters
        column :phone
        column :mobile
        column :created_at
        column :updated_at
        default_actions
    end

    form do |f|
        f.inputs do
            f.input :email, :wrapper_html => { :style => "width:250px;" }, :required => true, :pattern => '([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})'
            f.input :name, :wrapper_html => { :style => "width:250px;" }
            f.input :arrival, :wrapper_html => { :style => "width:350px;" }
            f.input :departure,  :wrapper_html => { :style => "width:350px;" }
            f.input :days,  :wrapper_html => { :style => "width:40px;" }
            f.input :adults, :wrapper_html => { :style => "width:40px;" }
            f.input :youngsters,  :wrapper_html => { :style => "width:40px;" }
            f.input :phone, :wrapper_html => { :style => "width:120px;" }
            f.input :mobile, :wrapper_html => { :style => "width:120px;" }
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit reservation: [:email, :name, :arrival, :departure, :days, :adults, :youngsters, :phone, :mobile]
        end
    end
end
