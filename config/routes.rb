Rails.application.routes.draw do

  # student
  get 'home/index'
  get 'student/index'
  get 'student/appointment'
  get 'student/application'
  get 'student/form'
  get 'student/show'

  post "/applicant/submit_apply", to: "applicant/submit_apply#create"
  post "/applicant/withdraw", to: "applicant/withdraw#create"
  post "/applicant/schedule_interview", to: "applicant/schedule_interview#create"
  post "/applicant/accept_offer", to: "applicant/accept_offer#create"
  post "/appointment/student_request", to: "appointment/student_request#create"
  post "/appointment/cancel_request", to: "appointment/cancel_request#create"
  post "/appointment/report_issue", to: "appointment/report_issue#create"

  # la
  get 'la/index'
  get 'la/settings'
  get 'la/request'

  post "/officehour/set_office_hour", to: "officehour/set_office_hour#create"
  post "/officehour/set_announcement", to: "officehour/set_announcement#create"
  post "/officehour/set_lication", to: "officehour/set_location#create"
  post "/appointment/la_accept", to: "appointment/la_accept#create"
  post "/appointment/la_cancel", to: "appointment/la_cancel_request#create"
  post "/appointment/start_appt", to: "appointment/start_appt#create"
  post "/appointment/end_appt", to: "appointment/end_appt#create"

  # admin
  get 'admin/index'
  get 'admin/courses'
  get 'admin/evaluations'
  get 'admin/hiring'
  get 'admin/management'
  get 'admin/edit_application'
  get 'admin/edit_interview'
  get 'admin/decision'

  post "/management/role_form", to: "management/role_form#create"
  post "/management/system_url", to: "management/system_url#create"
  post "/management/remove_course", to: "management/remove_course#destroy"
  post "/management/add_course", to: "management/add_course#create"
  post "/management/manage_la_course", to: "management/manage_la_course#create"
  post "/management/change_office_hour", to: "management/change_office_hour#create"
  post "/management/allow_office_hour", to: "management/change_office_hour#update"
  post "/management/set_announcement", to: "management/set_announcement#create"
  post "/management/admin_email", to: "management/admin_email#create"

  post "/hiring/see_pdf", to: "hiring/see_pdf#create"
  post "/hiring/change_status", to: "hiring/change_status#create"
  post "/hiring/delete_all", to: "hiring/delete_all#create"
  post "/hiring/application_note", to: "hiring/application_note#create"
  post "/hiring/open_apply", to: "hiring/open_apply#create"
  post "/hiring/hiring_calendar", to: "hiring/hiring_calendar#create"
  post "/hiring/lastday_interview", to: "hiring/lastday_interview#create"
  post "/hiring/interview_location", to: "hiring/interview_location#create"
  post "/hiring/edit_application_form", to: "hiring/edit_application_form#create"
  post "/hiring/edit_interview_form", to: "hiring/edit_interview_form#create"
  post "/hiring/get_template", to: "hiring/get_template#create"

  # system
  root 'home#index'
end
