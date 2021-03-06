Rails.application.routes.draw do
  resources :atms do
    collection do
      get 'datecard'

      get 'kursna'
      get 'kursna_result'
      
      get 'clientinfo'
      get 'clientinfo_result'

      
      get 'international_frm'
      post 'interform'
      get 'extpayresult'
      get 'reservewithfee_frm'
      post 'reservewithfee'
      get 'internalpayment_frm'
      post 'interpay'

      get 'accounts_frm'
      get 'accounts'
      get 'templates'
      get 'reversal_frm'
      post 'reversal'
      get 'template'
      post 'set_accountout'
      post 'set_accountin'

      get 'wadl'
    end
  end
    
    get 'atms/template/:tid/:ID' , to: 'atms#template'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'atms#index'

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
