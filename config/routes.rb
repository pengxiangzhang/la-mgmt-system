Rails.application.routes.draw do
  get 'home/index'
  get 'student/index'
  get 'la/index'
  get 'admin/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
