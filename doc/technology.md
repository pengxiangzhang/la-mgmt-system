# LA Management System - Technology Overview

# Table of contents

- [LA Management System - Technology Overview](#la-management-system---technology-overview)
    - [Ruby(Located On `.ruby-version`)](#rubylocated-on-ruby-version)
    - [Gem(Located On `Gemfile`)](#gemlocated-on-gemfile)
    - [Javascript Library (Using CDN Located on `app/view/layouts/_head.html.erb`)](#javascript-library-using-cdn-located-on-appviewlayouts_headhtmlerb)

## Ruby(Located On `.ruby-version`)

- Version: 2.6.4

## Gem(Located On `Gemfile`)

### System Required Gem

- rails: 6.1.3 (load_defaults 5.2)
- mysql2: 0.5.3
- puma: 5.2.2
- sass-rails: 6.0.0 (No SCSS Written)
- coffee-rails: 5.0.0 (No Coffee Script Written)
- uglifier: 4.2.0
- turbolinks: 5
- jbuilder: 2.5
- bootsnap: 1.7.2
- tzinfo-data

### Project Required Gem

- rack-cas: 0.16.1
- wicked_pdf: 2.1
- combine_pdf: 1.0.21
- icalendar: 2.7.1
- nokogiri: 1.11.1
- browser: 5.3.1
- slack-notifier: 2.3.2
- whenever: 1.0.0
- wkhtmltopdf-binary-edge: 0.12.4.0

## Javascript Library (Using CDN Located on `app/view/layouts/_head.html.erb`)

- jquery: 3.6.0
- jqueryui: 1.12.1 (js and css)
- jquery-ui-timepicker-addon: 1.6.3 (js and css)
- bootstrap: 5.0.0 (js, css, popper)
- datatables: 1.10.21 (js and css)
- datatables-buttons: 1.7.0 (js, css, buttons.html5.js)
- moment.js: 2.29.1
- datatables-plugins: 1.10.22 (datetime-moment.js)
- jQuery-formBuilder: 3.6.2 (form-builder.js, form-render.js) (Builder only required on Admin)
- sweetalert2: 10.15.6 (js and css)
- chosen: 1.8.7 (js and css)(Only required on Admin)
- trix: 1.3.1 (js and css)(Only required on Admin)