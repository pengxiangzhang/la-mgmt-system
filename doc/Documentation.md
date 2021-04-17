# LA Management System - Documentation

# Table of content

- [LA Management System - Documentation](#la-management-system---documentation)
    * [Email Template](#email-template)
        + [Application Process Email Template](#application-process-email-template)
        + [System Process Email Template](#system-process-email-template)
    * [Assets](#assets)
        + [images](#images)
        + [javascript](#javascript)
        + [stylesheets](#stylesheets)
    * [Timeout](#timeout)
    * [View](#view)
        + [Admin](#admin)
            - [courses.html.erb](#courseshtmlerb)
            - [decision.html.erb?id=](#decisionhtmlerb-id-)
            - [detail.html.erb?id=](#detailhtmlerb-id-)
            - [edit_application.html.erb](#edit-applicationhtmlerb)
            - [edit_contact.html.erb](#edit-contacthtmlerb)
            - [edit_interview.html.erb](#edit-interviewhtmlerb)
            - [email.html.erb](#emailhtmlerb)
            - [export.html.erb?end=YYYY-MM-DD&start=YYYY-MM-DD](#exporthtmlerb-end-yyyy-mm-dd-start-yyyy-mm-dd)
            - [hiring.html.erb](#hiringhtmlerb)
            - [index.html.erb](#indexhtmlerb)
            - [interview_note.html.erb](#interview-notehtmlerb)
            - [management.html.erb](#managementhtmlerb)
        + [Home](#home)
            - [contact.html.erb](#contacthtmlerb)
            - [index.html.erb](#indexhtmlerb-1)
        + [login](#login)
            - [index.html.erb](#indexhtmlerb-2)
        + [la](#la)
            - [index.html.erb](#indexhtmlerb-3)
            - [settings.html.erb](#settingshtmlerb)
            - [show_finish.html.erb?id=](#show-finishhtmlerb-id-)
            - [show_request.html.erb?id=](#show-requesthtmlerb-id-)
        + [student](#student)
            - [application.html.erb](#applicationhtmlerb)
            - [form.html.erb](#formhtmlerb)
            - [index.html.erb](#indexhtmlerb-4)
            - [pdf.html.erb](#pdfhtmlerb)
            - [show.html.erb](#showhtmlerb)
        + [layout](#layout)
            - [\_footer.html.erb](#--footerhtmlerb)
            - [\_head.html.erb](#--headhtmlerb)
            - [\_header.html.erb](#--headerhtmlerb)
            - [\_navbar.html.erb](#--navbarhtmlerb)
            - [\_plugins.html.erb(part of header)](#--pluginshtmlerb-part-of-header-)
            - [application.html.erb](#applicationhtmlerb-1)
            - [mailer.html.erb](#mailerhtmlerb)
            - [mailer.text.erb](#mailertexterb)
            - [pdf.html.erb](#pdfhtmlerb-1)
    * [Controller](#controller)
        + [applicant](#applicant)
            - [accept_offer_controller.rb](#accept-offer-controllerrb)
            - [schedule_interview_controller.rb](#schedule-interview-controllerrb)
            - [submit_apply_controller.rb](#submit-apply-controllerrb)
            - [withdraw_controller.rb](#withdraw-controllerrb)
        + [appointment](#appointment)
            - [cancel_request_controller.rb](#cancel-request-controllerrb)
            - [end_appt_controller.rb](#end-appt-controllerrb)
            - [la_accept_controller.rb](#la-accept-controllerrb)
            - [la_cancel_request_controller.rb](#la-cancel-request-controllerrb)
            - [start_appt_controller.rb](#start-appt-controllerrb)
            - [student_request_controller.rb](#student-request-controllerrb)
            - [report_issue_controller.rb](#report-issue-controllerrb)
        + [hiring](#hiring)
            - [application_note_controller.rb](#application-note-controllerrb)
            - [change_status_controller.rb](#change-status-controllerrb)
            - [delete_all_controller.rb](#delete-all-controllerrb)
            - [edit_application_form_controller.rb](#edit-application-form-controllerrb)
            - [edit_contact_form_controller.rb](#edit-contact-form-controllerrb)
            - [edit_interview_form_controller.rb](#edit-interview-form-controllerrb)
            - [get_template_controller.rb](#get-template-controllerrb)
            - [hiring_calendar_controller.rb](#hiring-calendar-controllerrb)
            - [interview_location_controller.rb](#interview-location-controllerrb)
            - [lastday_interview_controller.rb](#lastday-interview-controllerrb)
            - [open_apply_controller.rb](#open-apply-controllerrb)
            - [see_pdf_controller.rb](#see-pdf-controllerrb)
            - [send_email_controller.rb](#send-email-controllerrb)
        + [management](#management)
            - [add_course_controller.rb](#add-course-controllerrb)
            - [admin_email_controller.rb](#admin-email-controllerrb)
            - [change_office_hour_controller.rb](#change-office-hour-controllerrb)
            - [export_log_controller.rb](#export-log-controllerrb)
            - [manage_la_course_controller.rb](#manage-la-course-controllerrb)
            - [remove_course_controller.rb](#remove-course-controllerrb)
            - [role_form_controller.rb](#role-form-controllerrb)
            - [set_announcement_controller.rb](#set-announcement-controllerrb)
            - [survey_url_controller.rb](#survey-url-controllerrb)
            - [system_url_controller.rb](#system-url-controllerrb)
        + [office hour](#office-hour)
            - [set_announcement_controller.rb](#set-announcement-controllerrb-1)
            - [set_location_controller.rb](#set-location-controllerrb)
            - [set_office_hour_controller.rb](#set-office-hour-controllerrb)
        + [Main](#main)
            - [admin_controller.rb](#admin-controllerrb)
            - [application_controller.rb](#application-controllerrb)
            - [contact_controller.rb](#contact-controllerrb)
            - [home_controller.rb](#home-controllerrb)
            - [la_controller.rb](#la-controllerrb)
            - [login_controller.rb](#login-controllerrb)
            - [student_controller.rb](#student-controllerrb)
    * [helpers](#helpers)
        + [admin_helper.rb](#admin-helperrb)
        + [home_helper.rb](#home-helperrb)
        + [la_helper.rb](#la-helperrb)
        + [login_helper.rb](#login-helperrb)
        + [student_helper.rb](#student-helperrb)
    * [storage](#storage)
        + [application](#application)
        + [send_later](#send-later)

## Email Template

### Application Process Email Template

1. goto `app/views/email_mailer/template`
2. create a file naming as `email_template_name.html.erb`
3. Put the subject of the email at the first line of the file and start the line with `>`
4. Data Injection can be made using [Action View Base](https://api.rubyonrails.org/classes/ActionView/Base.html) with
   anything in the database or any string that could generate by Ruby. 4.1. If would like to get data from that specific
   applicant from the database, data can be get using @application. An example of that is `@application.NUID`. Available
   field
   is: `[id, eduPersonPrincipalName, NUID, Name, Email, Course, GPA, Score, File_Location(), Application_Status, Sub_Status, Interview_Time, created_at, updated_at]`
   4.2 To get any data in database can use this formula `SystemValue.find_by(name: "system_url").value`. Any custom data
   inject by this way by inserting a row of data to the `system_values` table.

### System Process Email Template

Those files are located at `app/views/email_mailer`

- appointment_accepted.html.erb: This will be sent out to the student when the appointment has been accepted by a LA.
- appointment_cancel.html.erb: This will be sent out to the student and LA(if accepted) when the appointment has been
  cancel by either LA or the student.
- appointment_confirm.html.erb: This will be sent out to the student when the appointment has been placed.
- timeout.html.erb: This email will send out to the student when their appointment has timed out and canceled by the
  system.
- contact.html.erb: This email will send to admin_email when someone fills out a contact form.
- new_accept.html.erb: This email will send out to admin_email when someone accepts their job offer.
- new_applicant.html.erb: This email will send out to admin_email when someone completes an application form.
-
    - thank_applying.html.erb: This email will send out to applicants when they complete an application form.
- new_scheduled_applicant.html.erb: This email will send out to admin_email when someone scheduled an interview.
- scheduled_applicant.html.erb: This email will send out to applicants when they scheduled an interview.
- template.html.erb: Application Process Email Template will render to this template. Usually, this file should not be
  changed.

## Assets

### images

- cselap-logo.jpg: logo used on PC Nav Bar.
- favicon.ico and icon.svg: icon used on browser favicon.

### javascript

- application.js: contain the script to control the navbar. Notify outdated browser
- cable.js: This should not be touched.
- quote.js: contain a list that stores quote on the button of the webpage.
- student_index.js: Javascript used on the student index page.

### stylesheets

- application.css: css used throughout the website
- mobile_nav.css: css used on the mobile nav
- pc_nav.css: css used on pc nav

## Timeout

`config/schedule.rb`: After touching this file running `bundle exec whenever --update-crontab` is necessary. Running
code on: `/lib/tasks/timeout.rb`

## View

### Admin

#### courses.html.erb

- Manage Course: include add and remove a course.
- LA Management: include assign courses to LA(a list in course-select\[] field).
- Allow one LA to change their office hour in the user list.
- Allow all LA to change their office hour
- Export Log

#### decision.html.erb?id=

- Manage a certain user's application.
- See certain user's application form.
- Send email to the user.

#### detail.html.erb?id=

- See detail log on one appointment.

#### edit_application.html.erb

- Edit Application form(Only on desktop)

#### edit_contact.html.erb

- Edit contact form(Only on desktop)

#### edit_interview.html.erb

- Edit interview form(Only on desktop)

#### email.html.erb

- PDF template for application email pdf that attach to the application form

#### export.html.erb?end=YYYY-MM-DD&start=YYYY-MM-DD

- Load appointment logs from a certain time period.

#### hiring.html.erb

- Hiring Table: View all hiring tables, access the application forms, link to hiring action.
- Application Note: Editable form that admin could write a note for an applicant.

#### index.html.erb

- Link to other roles' webpage
- Open Appointment, Accepted Appointment, Appointments from last 7 days list.

#### interview_note.html.erb

- PDF template for interview note pdf that attach to the application form

#### management.html.erb

- User List: A list of admin, la, and student(logged in within last 6 months) and manage their role.
- Set announcement base on roles.
- Hiring Settings
- Link to edit form
- System Setting

### Home

#### contact.html.erb

- An editable contact form, each entry will send to the admin's email

#### index.html.erb

- This webpage will not be accessed by any human. This webpage is only visible by bot. So the site can be index by
  search engines.

### login

#### index.html.erb

- Used to redirect the user to the login page and redirect the user to their roles homepage.

### la

#### index.html.erb

- Show countdown to the next appointment (if have one)
- LA's detailed information
- Table that LA can accept the appointment and view more information about the request
- Accepted Appointment List: Can view detailed information about the request and cancel the request
- Appointments from last 7 days: Can view detailed information about the request

#### settings.html.erb

- View LA's Information
- Set office hours (if admin gives permission), change announcement, and meeting location.

#### show_finish.html.erb?id=

- Show detail of the appointment(accepted and closed). Can only view if the appointment is assigned to that LA.

#### show_request.html.erb?id=

- Show some more information. Link on request appointment. Can be view by all LA if provide the id#.

### student

#### application.html.erb

- If no current application: Notes to the student and link to the application form.
- If have the current application: render application status and action page(Thank you page, schedule page, Accept
  Offer? page, thank you accept page).

#### form.html.erb

- If no current application: An editable application form
- If have the current application: Redirect application.html.erb

#### index.html.erb

- Show all office hour
- If no appointment: Schedule form
- If have an appointment: Appointment countdown page
-

#### pdf.html.erb

- PDF template for application form pdf

#### show.html.erb

- Show LA detail form of the office hour page.

### layout

#### \_footer.html.erb

- Copyright
- hidden "saying"

#### \_head.html.erb

- CDN javascript plugin
- Basic HTML tag base on W3C
- Google Tag Manager (tracker)

#### \_header.html.erb

- empty

#### \_navbar.html.erb

- Code for mobile navigator bar
- Code for desktop navigator bar

#### \_plugins.html.erb(part of header)

- flash code
- announcement code

#### application.html.erb

- Base code that merge: `_head.html.erb`, `_header.html.erb`, `_plugins.html.erb`,`_navbar.html.erb`,`_footer.html.erb`
- Basic HTML tag base on W3C

#### mailer.html.erb

- Base code for HTML email

#### mailer.text.erb

- Base code for plain text email

#### pdf.html.erb

- Base code for pdf generator

## Controller

### applicant

#### accept_offer_controller.rb

- Handel request of applicant to accept job offer

#### schedule_interview_controller.rb

- Handel request of the applicant to schedule interview time.

#### submit_apply_controller.rb

- Handel request of the applicant to submit the application

#### withdraw_controller.rb

- Handel request of the applicant to withdraw the application

### appointment

#### cancel_request_controller.rb

- Handel request of student to cancel appointment

#### end_appt_controller.rb

- Handel request of la to end the appointment

#### la_accept_controller.rb

- Handel request of la to accept an open appointment

#### la_cancel_request_controller.rb

- Handel request of la to cancel a accepted appointment

#### start_appt_controller.rb

- Handel request of la to start appointment

#### student_request_controller.rb

- Handel request of student to request an appointment

#### report_issue_controller.rb

- Handel request from the user to report an issue when they have an appointment(direct email to admin) then cancel an
  appointment.

### hiring

#### application_note_controller.rb

- Handel request of admin to write an application note to an applicant

#### change_status_controller.rb

- Handel request of admin to change the status of an application and send an email.

#### delete_all_controller.rb

- Handel request of admin to "delete"(Data still in the database, application form still in the storage folder. Just
  hidden from the list) all current application.

#### edit_application_form_controller.rb

- Handel request of admin to edit application form.

#### edit_contact_form_controller.rb

- Handel request of admin to edit contact form.

#### edit_interview_form_controller.rb

- Handel request of admin to edit interview form.

#### get_template_controller.rb

- Handle AJAX request to get email template when changing status of an application.

#### hiring_calendar_controller.rb

- Handel request of admin to edit interview calendar URL.

#### interview_location_controller.rb

- Handel request of admin to edit interview location.

#### lastday_interview_controller.rb

- Handel request of admin to edit the last day of the interview.

#### open_apply_controller.rb

- Handel request of admin to open or close the application.

#### see_pdf_controller.rb

- Handel request of admin to access applicants' application form.

#### send_email_controller.rb

- Handle request of admin to send/delete queued emails.

### management

#### add_course_controller.rb

- Handle request of admin to add a course or change the slack channel.

#### admin_email_controller.rb

- Handle request of admin to change their system email address.

#### change_office_hour_controller.rb

- Handle request of admin to change allow/disallow a la to change their office hour
- Handle request of admin to change to allow all la to change their office hour

#### export_log_controller.rb

- Handle request of admin to redirect to get access of appointment log in a period of time.

#### manage_la_course_controller.rb

- Handle request of admin to assign course(s) of an la.

#### remove_course_controller.rb

- Handle request of admin to remove a course

#### role_form_controller.rb

- Handle request of admin to change role of a user.

#### set_announcement_controller.rb

- Handle request of admin to change anouncement.

#### survey_url_controller.rb

- Handle request of admin to change survey system url.

#### system_url_controller.rb

- Handle request of admin to change this system's url.

### office hour

#### set_announcement_controller.rb

- Handle request of la to change announcement

#### set_location_controller.rb

- Handle request of la to change meeting location

#### set_office_hour_controller.rb

- Handle request of la to change their office hour

### Main

#### admin_controller.rb

- management: send user list to management list
- hiring: send all application that status is not "delete"
- courses: send all course, send all LAs' information
- index: send all couse, past(7 days)/open/accepted appointment
- decision: send that application detail, send email template list
- queue: send all queued email
- detail: send detail of that appointment
- export: send list of appointment on requested period of time.

#### application_controller.rb

- cas_user: get session's username
- cas_name: get session's full displayName
- cas_email: get session's email address.
- update_user: create the user in the system, update that user has logged in, and session detail.
- user_type: get user type from database
- cas_authentication!: send 401 to unlogined user(redirect to login).
- check_admin: send 403 if the user does not have an `admin` role
- check_la: send 403 if user have `student` or `block` role
- check_block: send 403 if the user has a `block` role
- check_file(data): check file if it is larger than 5242880 byte(5 mb)
- is_human(captcha_response): check hcaptcha response is real
- send_slack(channel, message): send a slack message to a certain channel
- send_interaction(student, la, course, interactionType, recommend): send interaction to survey system.
- find_user_key(username): find user key in servey system

#### contact_controller.rb

- create: Handel contact form input

#### home_controller.rb

- index: render homepage if bot, redirect login page if human
- contact: render contact form

#### la_controller.rb

- settings: send that la's detail, if not find create the row.
- index: send that la's detail, if not find create the row. Send current day of the week, open appointment, user's
  accepted appointment, user's past(7 days) appointment.
- get_la_course(id): get LA's course supported
- show_request: send appointment information.
- show_finish: send appointment information.

#### login_controller.rb

- index: redurect user base on their role.

#### student_controller.rb

- application: send user's application detail
- form: send the application form
- show: send la's detail
- index: send all course, la detail, if have appointment send detail.
- current_student: get user's detail.

## helpers

### admin_helper.rb

- application_form: send application json
- interview_form: send interview json
- contact_form: send contact form json
- admin_email: send admin email address
- system_url: send system url
- get_la_course(id): get course assigned to a la

### home_helper.rb

- contact_form: send contact form json

### la_helper.rb

empty

### login_helper.rb

empty

### student_helper.rb

- hiring_calendar: send hiring calendar URL
- accept_application: send either application is close or open
- application_form: send application json
- admin_email: send admin email address

## storage

### application

- Application form
- file name: ##NUID##-YYYYMMDDHHMMSS

### send_later

- queued email
- filename is autogenerated id