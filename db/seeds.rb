# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Formbuilder.create(formname: 'application',formdata: '[{"type":"number","required":true,"label":"Age","description":"Input your age here","className":"form-control","name":"Age","access":false,"min":0,"max":120,"step":1},{"type":"button","subtype":"submit","label":"Submit","className":"btn-primary btn","name":"Submit","access":false,"style":"primary"}]').save
