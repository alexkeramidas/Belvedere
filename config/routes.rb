BelvedereGit::Application.routes.draw do
    mount Rich::Engine => '/rich', :as => 'rich'
    devise_for :admin_users, ActiveAdmin::Devise.config
    
    ActiveAdmin.routes(self)
    
    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # handles /
    root to: redirect("/#{I18n.locale}", status: 302), as: :redirected_root
    
    post 'send_mail' => 'pages#send_mail', :trailing_slash => false
    post 'make_reservation' => 'pages#make_reservation', :trailing_slash => false
    
    get 'sitemap.xml' => 'sitemaps#index', as: 'sitemap', defaults: { format: 'xml' }

    # handles /invalid-locale/any-path
    scope ':locale', locale: /(?!(#{I18n.available_locales.join("|")})\/).*/ do
        get '/*path', to: redirect("/#{I18n.locale}/%{path}", status: 302)
    end
    
    # handles /any-path
    get "/*path", to: redirect("/#{I18n.locale}/%{path}", status: 302), constraints: { path: /(?!(#{I18n.available_locales.join("|")})).+/ }, format: false
    
    # handles /valid-locale/any-path
    scope '(:locale)', locale: /(#{I18n.available_locales.join('|')})/  do
        root 'pages#home', :trailing_slash => false
        
        get 'about' => 'pages#about', :trailing_slash => false
        get 'location' => 'pages#location', :trailing_slash => false
        get 'photo_gallery' => 'pages#photo_gallery', :trailing_slash => false
        
        get 'contact' => 'pages#contact', :trailing_slash => false
        
        resources :articles, :only => [:index, :show], :trailing_slash => false
        
        get 'accommodation' => 'suites#index', :trailing_slash => false
        get 'services' => 'services#index', :trailing_slash => false
    end
    
    # Example of regular route:
    #   get 'products/:id' => 'catalog#view'

    # Example of named route that can be invoked with purchase_url(id: product.id)
    #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

    # Example resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Example resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Example resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Example resource route with more complex sub-resources:
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', on: :collection
    #     end
    #   end

    # Example resource route with concerns:
    #   concern :toggleable do
    #     post 'toggle'
    #   end
    #   resources :posts, concerns: :toggleable
    #   resources :photos, concerns: :toggleable

    # Example resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end
end
