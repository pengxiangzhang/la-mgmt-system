Rails.application.routes.draw do
  get 'home/index'
  get 'student/index'
  get 'la/index'
  get 'admin/index'
  get 'admin/showall'
  get 'admin/showall(.:format)'
  root 'home#index'
  resources :admin

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
