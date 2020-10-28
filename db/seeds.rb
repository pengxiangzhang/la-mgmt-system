# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Formbuilder.create(formname: 'application',formdata: '[{"type":"number","required":true,"label":"NUID","className":"form-control","name":"NUID","access":false,"min":1,"max":99999999},{"type":"text","required":true,"label":"Name:","className":"form-control","name":"Name","access":false,"subtype":"text"},{"type":"text","subtype":"email","required":true,"label":"Email","className":"form-control","name":"Email","access":false},{"type":"checkbox-group","required":true,"label":"Course Applying","toggle":false,"inline":true,"name":"Course-Applying","access":false,"other":false,"values":[{"label":"CSCE155","value":"CSCE155","selected":false},{"label":"CSCE156","value":"CSCE156","selected":false},{"label":"CSCE235","value":"CSCE235","selected":false}]},{"type":"radio-group","required":true,"label":"Grade for CSCE155","inline":true,"name":"Grade-for-CSCE155","access":false,"other":true,"values":[{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false},{"label":"Not Applting for this Class","value":"Z","selected":false}]},{"type":"radio-group","required":true,"label":"Grade for CSCE156","inline":true,"name":"radio-group-1603845619210","access":false,"other":true,"values":[{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false},{"label":"Not Applting for this Class","value":"Z","selected":false}]},{"type":"radio-group","required":true,"label":"Grade for CSCE235","inline":true,"name":"radio-group-1603845624288","access":false,"other":true,"values":[{"label":"A+","value":"A+","selected":false},{"label":"A","value":"A","selected":false},{"label":"A-","value":"A-","selected":false},{"label":"B+","value":"B+","selected":false},{"label":"Not Applting for this Class","value":"Z","selected":false}]},{"type":"number","required":true,"label":"GPA","className":"form-control","name":"GPA","access":false,"max":5,"step":0.1},{"type":"button","subtype":"submit","label":"Submit","className":"btn btn-primary","name":"submit","access":false,"style":"primary"}]').save
