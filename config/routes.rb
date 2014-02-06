BelvedereGit::Application.routes.draw do
    mount Rich::Engine => '/rich', :as => 'rich'
    devise_for :admin_users, ActiveAdmin::Devise.config
    
    ActiveAdmin.routes(self)
    
    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # handles /
    root to: redirect("/#{I18n.locale}", status: 301), as: :redirected_root
    
    post 'send_mail' => 'pages#send_mail', :trailing_slash => false
    post 'make_reservation' => 'pages#make_reservation', :trailing_slash => false
    
    get 'sitemap.xml' => 'sitemaps#index', as: 'sitemap', defaults: { format: 'xml' }
    get 'sitemap-en.xml' => 'sitemaps#sitemap_en', as: 'sitemap_en', defaults: {format: 'xml'}
    get 'sitemap-el.xml' => 'sitemaps#sitemap_el', as: 'sitemap_el', defaults: {format: 'xml'}
    get 'sitemap-de.xml' => 'sitemaps#sitemap_de', as: 'sitemap_de', defaults: {format: 'xml'}
    get 'sitemap-es.xml' => 'sitemaps#sitemap_es', as: 'sitemap_es', defaults: {format: 'xml'}
    get 'sitemap-fr.xml' => 'sitemaps#sitemap_fr', as: 'sitemap_fr', defaults: {format: 'xml'}
    get 'sitemap-it.xml' => 'sitemaps#sitemap_it', as: 'sitemap_it', defaults: {format: 'xml'}
    get 'sitemap-ru.xml' => 'sitemaps#sitemap_ru', as: 'sitemap_ru', defaults: {format: 'xml'}
    
    # handles /valid-path
    get '/*path', to: redirect(status: 301) { |params, request| "/#{I18n.locale}/#{params[:path]}" }, constraints: { path: /(about|location|photo_gallery|contact|articles|accommodation|services).*/ }, format: false
    
    # handles /invalid-locale/any-path
    scope ':locale', locale: /(?!(#{I18n.available_locales.join("|")})\/).*/ do
        # handles /invalid-locale/valid-path
        get '/*path', to: redirect(status: 301) { |params, request| "/#{I18n.locale}/#{params[:path]}" }, constraints: { path: /(about|location|photo_gallery|contact|articles|accommodation|services).*/ }, format: false
        
        #handles /invalid-locale/invalid-path
        get '/*path', to: redirect(status: 301) { |params, request| "/#{params[:path]}" }, constraints: lambda { |request| true }, format: false
    end
    
    # handles /invalid-path
    get '/*path', to: redirect(status: 301) { |params, request| "/#{I18n.locale}/#{params[:path]}" }, constraints: { path: /(?!(#{I18n.available_locales.join("|")})).+/ }, format: false
    
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
