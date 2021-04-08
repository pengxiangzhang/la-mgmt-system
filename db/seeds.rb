# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FormBuilder.create(formname: 'application', formdata: '[{"type":"number","required":true,"label":"NUID","className":"form-control","name":"NUID","min":1,"max":99999999,"step":1},{"type":"text","required":true,"label":"Name:","className":"form-control","name":"Name","subtype":"text"},{"type":"text","subtype":"email","required":true,"label":"Email","className":"form-control","name":"Email"},{"type":"checkbox-group","required":true,"label":"Course Applying","toggle":false,"inline":true,"name":"Course","other":false,"values":[{"label":"CSCE155","value":"CSCE155","selected":false},{"label":"CSCE156","value":"CSCE156","selected":false},{"label":"CSCE235","value":"CSCE235","selected":false}]},{"type":"radio-group","required":true,"label":"CSCE155","inline":true,"name":"CSCE155","other":true,"values":[{"label":"Not applying for this class","value":"Z","selected":true},{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false}]},{"type":"radio-group","required":true,"label":"CSCE156","inline":true,"name":"CSCE156","other":true,"values":[{"label":"Not applying for this class","value":"Z","selected":true},{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false}]},{"type":"radio-group","required":true,"label":"CSCE235","inline":true,"name":"CSCE235","other":true,"values":[{"label":"Not applying for this class","value":"Z","selected":true},{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false}]},{"type":"number","required":true,"label":"GPA","className":"form-control","name":"GPA","max":4,"step":0.1},{"type":"file","required":false,"label":"File Upload","description":"Note: It can only upload PDF file, Can only have one file uploader through out the form.","className":"form-control","name":"File","subtype":"file","multiple":true}]')
FormBuilder.create(formname: 'interview', formdata: '[{"type":"text","required":true,"label":"Applicant Username","description":"MyUNL Username(Canvas)","className":"form-control","name":"username","subtype":"text","maxlength":99},{"type":"number","required":true,"label":"Score","description":"It will add to the total score","className":"form-control","name":"Score","step":1},{"type":"radio-group","required":true,"label":"Recommend to hire?","inline":true,"name":"Recommand-to-hire","other":true,"values":[{"label":"Yes","value":"yes","selected":false},{"label":"No","value":"no","selected":false}]},{"type":"file","required":false,"label":"Attachment","description":"Note: It can only upload PDF file, Can only have one file uploader through out the form.","className":"form-control","name":"file","subtype":"file","multiple":true}]')
FormBuilder.create(formname: 'contact', formdata: '[{"type":"header","subtype":"h1","label":"Learning Assistant Contact Form"},{"type":"text","required":false,"label":"Name","className":"form-control","name":"Name","subtype":"text"},{"type":"text","subtype":"email","required":true,"label":"Email","className":"form-control","name":"Email"},{"type":"textarea","required":true,"label":"Common","className":"form-control","name":"Comment","subtype":"textarea"}]')
SystemValue.create(name: 'admin_email', value: 'pzhang13@outlook.com')
SystemValue.create(name: 'survey_url', value: 'https://cse.unl.edu/~pzhang/LA-Feedback')
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
