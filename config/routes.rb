Rails.application.routes.draw do
  get 'home/index'
  get 'student/index'
  get 'student/request'
  get 'la/index'
  get 'la/settings'
  get 'la/request'
  get 'admin/index'
  get 'admin/courses'
  get 'admin/evaluations'
  get 'admin/hiring'
  get 'admin/management'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
