ActiveAdmin.register Reservation do
    menu :priority => 3, :label => 'Manage Reservations'

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
        f.inputs :style => 'display:inline-block;' do
            f.input :email, :wrapper_html => { :style => 'display:table-cell;' }, :input_html => {required: true, pattern: '([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})'}, :hint => 'Every reservation needs an email!'
            f.input :name, :wrapper_html => { :style => 'display:table-cell;' }
            f.input :arrival, :as => :datepicker, :hint => 'Every reservation needs an arrival date!', :input_html => {required: true }
            f.input :departure, :as => :datepicker, :hint => 'Every reservation needs a departure date!', :input_html => {required: true }
            f.input :days, :readonly => true, :as => :string, :wrapper_html => { :style => 'display:table-cell; width: 40px;' }, :label => "Duration", :input_html => { :readonly => true }
            f.input :adults, :wrapper_html => { :style => 'display:table-cell;' }, :input_html => {required: true, pattern: '(0*(?:[1-2][0-9]?|2))', min: '0', max: '19'}, :hint => 'Every reservation needs someone to pay!'
            f.input :youngsters,  :wrapper_html => { :style => 'display:table-cell;' }, :input_html => { pattern: '(0*(?:[1-2][0-9]?|2))', min: '0', max: '19'}
            f.input :phone, :wrapper_html => { :style => 'display:table-cell;' }
            f.input :mobile, :wrapper_html => { :style => 'display:table-cell;' }
        end
        f.actions
    end

    controller do
        def permitted_params
            params.permit reservation: [:email, :name, :arrival, :departure, :adults, :youngsters, :phone, :mobile, :days]
        end
    end
end
