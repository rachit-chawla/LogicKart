Rails.application.routes.draw do

  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

   get 'errors/unauthorized'

  # resources :categories do
  #   resources :products
  # end

  get '/login', to: 'user#login'
  post '/user/user_login', to: 'user#user_login'

  get '/forgot_password', to: 'user#forgot_password'
  post '/user/user_forgot_password'

  get '/show', to: 'user#show'

  get '/ashow', to: 'admin#ashow'

  get '/usershow', to: 'admin#user_show'

  get '/userslist', to: 'admin#users_list'

  post '/user/user_show', to: 'admin#user_show'

  get '/admin/index', to: 'admin#index'

  get '/user/index', to: 'user#index'
  
  post '/user_sign_up', to: 'user#user_sign_up'
  
  get '/sign_up', to: 'user#sign_up'

  post '/user_new_user', to: 'admin#user_new_user'
  
  get '/new_user', to: 'admin#new_user'

  get '/edit', to: 'user#edit'

  get '/aedit', to: 'admin#aedit'

  get '/useredit', to: 'admin#user_edit'

  post '/update', to: 'user#update'

  post '/aupdate', to: 'admin#aupdate'

  post '/delete', to: 'admin#delete'

  post '/userupdate', to: 'admin#adupdate'

  get '/logout', to: 'user#log_out'

  get '/change_password', to: 'user#change_password'

  post '/user/user_change_password', to: 'user#user_change_password'

  get '/achange_password', to: 'admin#change_password'

  post '/admin/admin_change_password', to: 'admin#admin_change_password'
  # post '/user/user_sign_up'  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
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
