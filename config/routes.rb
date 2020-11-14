Rails.application.routes.draw do
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
  root 'home#index'
  resources :applicant, :student, :applicant_process

  # admin
  get 'admin/index'
  get 'admin/courses'
  get 'admin/evaluations'
  get 'admin/hiring'
  get 'admin/management'
  get 'admin/edit'

  post "/management/role_username", to: "management/role_username#create"
  post "/management/role_form/:username", to: "management/role_form#create"
  post "/management/system_url", to: "management/system_url#create"
  post "/hiring/see_pdf/:username", to: "hiring/see_pdf#create"
  post "/hiring/change_status/:id", to: "hiring/change_status#create"
  post "/hiring/delete_all", to: "hiring/delete_all#create"
  post "/hiring/application_note", to: "hiring/application_note#create"
  post "/hiring/open_apply", to: "hiring/open_apply#create"
  post "/hiring/application_email", to: "hiring/application_email#create"
  post "/hiring/hiring_calendar", to: "hiring/hiring_calendar#create"
  post "/hiring/lastday_interview", to: "hiring/lastday_interview#create"
  post "/hiring/interview_location", to: "hiring/interview_location#create"
  post '/hiring/edit_form', to: "hiring/edit_form#create"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
