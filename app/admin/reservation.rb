ActiveAdmin.register Reservation do
    menu :priority => 3, :label => 'Reservations'

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
            f.input :email, :wrapper_html => {:class => "inline_field first required"}, :input_html => {required: true, maxlength: 100, pattern: '^[A-Za-z0-9_\-\.]+\@[A-Za-z0-9_\-\.]+\.[A-Za-z]{2,4}$'}
            f.input :name, :wrapper_html => {:class => "inline_field last required"}, :input_html => {required: true, maxlength: 100}
            f.input :arrival, :wrapper_html => {:class => "inline_field first required"}, :as => :date_picker, :input_html => {required: true, :min => Date.today, :max => Date.today + 6.months}
            f.input :departure, :wrapper_html => {:class => "inline_field required"}, :as => :date_picker, :input_html => {required: true, :min => Date.today + 1.day, :max => Date.today + 6.months + 1.day}
            f.input :days, :as => :string, :label => "Duration", :wrapper_html => {:class => "inline_field last"}, :input_html => {:readonly => true}
            f.input :adults, :wrapper_html => {:class => "inline_field first required"}, :input_html => {required: true, pattern: '^(1[0-9]|[1-9])$', min: 0, max: 19, maxlength: 2}
            f.input :youngsters, :wrapper_html => {:class => "inline_field last"}, :input_html => {pattern: '^([0-1][0-9]|[0-9])$', min: 0, max: 19, maxlength: 2}
            f.input :phone, :wrapper_html => {:class => "inline_field first"}, :input_html => {maxlength: 20}
            f.input :mobile, :wrapper_html => {:class => "inline_field last"}, :input_html => {maxlength: 20}
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit reservation: [:email, :name, :arrival, :departure, :adults, :youngsters, :phone, :mobile, :days]
        end
    end
end
