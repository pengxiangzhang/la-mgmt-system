Rails.application.routes.draw do
  get 'apply/applicant'
  get 'apply/reviewer'
  get 'home/index'
  get 'student/index'
  get 'student/request'
  get 'student/appointment'
  get 'student/application'
  get 'la/index'
  get 'la/settings'
  get 'la/request'
  get 'admin/index'
  get 'admin/courses'
  get 'admin/evaluations'
  get 'admin/hiring'
  get 'admin/management'
  get 'applicant/form'
  get 'interviewer/edit'
  root 'home#index'
  resources :admin, :interviewer, :applicant, :student, :applicant_process

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
