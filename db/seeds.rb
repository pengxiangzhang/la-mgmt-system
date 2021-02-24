# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FormBuilder.create(formname: 'application', formdata: '[{"type":"number","required":true,"label":"NUID","className":"form-control","name":"NUID","access":false,"min":1,"max":99999999},{"type":"text","required":true,"label":"Name:","className":"form-control","name":"Name","access":false,"subtype":"text"},{"type":"text","subtype":"email","required":true,"label":"Email","className":"form-control","name":"Email","access":false},{"type":"checkbox-group","required":true,"label":"Course Applying","toggle":false,"inline":true,"name":"Course","access":false,"other":false,"values":[{"label":"CSCE155","value":"CSCE155","selected":false},{"label":"CSCE156","value":"CSCE156","selected":false},{"label":"CSCE235","value":"CSCE235","selected":false}]},{"type":"radio-group","required":true,"label":"CSCE155","inline":true,"name":"CSCE155","access":false,"other":true,"values":[{"label":"Not Applting for this Class","value":"Z","selected":true},{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false}]},{"type":"radio-group","required":true,"label":"CSCE156","inline":true,"name":"CSCE156","access":false,"other":true,"values":[{"label":"Not Applting for this Class","value":"Z","selected":true},{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false}]},{"type":"radio-group","required":true,"label":"CSCE235","inline":true,"name":"CSCE235","access":false,"other":true,"values":[{"label":"Not Applting for this Class","value":"Z","selected":true},{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false}]},{"type":"number","required":true,"label":"GPA","className":"form-control","name":"GPA","access":false,"max":5,"step":0.1},{"type":"file","required":false,"label":"File Upload","description":"It would only have one file uploader. PDF format only","className":"form-control","name":"File","access":false,"subtype":"file","multiple":true},{"type":"button","subtype":"submit","label":"Submit","className":"btn btn-primary","name":"submit","access":false,"style":"primary"}]')
FormBuilder.create(formname: 'interview', formdata: '[{"type":"text","required":true,"label":"Applicant Username","description":"MyUNL Username(Canvas)","className":"form-control","name":"username","access":false,"subtype":"text","maxlength":99},{"type":"number","required":true,"label":"Score","description":"It will add to the total score","className":"form-control","name":"Score","access":false,"step":1},{"type":"file","required":false,"label":"Attachment","description":"It would only have one file uploader. PDF format only","className":"form-control","name":"file","access":false,"subtype":"file","multiple":true},{"type":"button","subtype":"submit","label":"Submit","className":"btn-primary btn","name":"submit","access":false,"style":"primary"}]')
SystemValue.create(name: 'application_email', value: 'pzhang13@outlook.com')
SystemValue.create(name: 'system_url', value: 'https://cselap.unl.edu')
SystemValue.create(name: 'hiring_calendar', value: 'https://outlook.office365.com/owa/calendar/955aa5d6d5cf4e93ae0906d8606fcb2c@huskers.unl.edu/297e82bb4b164fc3b5bdb6e81a875df84013835861119852673/calendar.html')
SystemValue.create(name: 'application_opening', value: 'true')
SystemValue.create(name: 'last_day_interview', value: '2022-11-05')
SystemValue.create(name: 'interview_location', value: 'Avery 112')
SystemValue.create(name: 'global_color_1', value: '#0d6efd')
SystemValue.create(name: 'global_color_2', value: '#FFFFFF')
SystemValue.create(name: 'global_text', value: '')
SystemValue.create(name: 'la_color_1', value: '#0d6efd')
SystemValue.create(name: 'la_color_2', value: '#FFFFFF')
SystemValue.create(name: 'la_text', value: '')
SystemValue.create(name: 'admin_color_1', value: '#0d6efd')
SystemValue.create(name: 'admin_color_2', value: '#FFFFFF')
SystemValue.create(name: 'admin_text', value: '')
