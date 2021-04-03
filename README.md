# LA Management System

[![Ruby](https://github.com/cseseniordesign/la-mgmt-system/actions/workflows/rails.yml/badge.svg)](https://github.com/cseseniordesign/la-mgmt-system/actions/workflows/rails.yml)

## Introduction

This website is developed for the LA program at [Computer Science and Engineering Department](https://cse.unl.edu/home)
located at the [University of Nebraska - Lincoln](https://www.unl.edu) and sponsor
by [Ann Koopmann](mailto:akoopmann1@unl.edu) and [Ashok Samal](mailto:samal@cse.unl.edu).

The survey system in this project is developed
by [hbiede/LA-Feedback-System](https://github.com/hbiede/LA-Feedback-System), version supported v3.0.1.

## Installation

1. Make sure you have ruby 2.6.4.
2. Make sure you have clone the website and ready to deploy.
3. rename `Gemfile.example` to `Gemfile`. Then do one of the following:
   1) Install wkhtmltopdf by hand (recommended): https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF
   2) Uncomment `gem 'wkhtmltopdf-binary', '~> 0.12.6.5'` from `Gemfile` when running Debian/Ubuntu, CentOS,
      Archlinux/manjaro or macOS
   3) Uncomment `gem  'wkhtmltopdf-binary-edge', ' ~> 0.12.2.1'` from `Gemfile` when running on none linux i386(
      linux-amd64 or darwin-x86_64)
4. Create file `.ruby-version` in the ruby root directory. Then do one of the following:
   1) `echo 2.6.4 >> .ruby-version` when you are contributing on none CSCE server.
   2) `echo ruby-2.6.4@lab-assistants >> .ruby-version` when you are contributing on CSCE server.
5. run `bundle install` to install all the requirement.
6. We recommend to deploy on Apache, but here is the
   instruction: [Instruction to deploy a Rails App with Passenger and Apache](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-apache-on-ubuntu-14-04)
   ; [Instruction to deploy a Rails App with Puma and Nginx](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04)
   .
7. run `bundle exec whenever --update-crontab` to install the timeout function to crontab and verify the crontab has
   been successfully install by running `crontab -l`

## Configurations

If you decide to host your own website, you will need to change the following:

1. `config/database.yml.example` to `config/database.yml` and change configurations accordingly. Remember that if you
   are developing the application, you should never commit sensitive information in the `database.yml` in the version
   control system.
2. Go to `config/environments` and open the file that correspond to the environments that you gonna use. Update the SMTP
   settings, EMAIL_SENDER(an email address that tie to the SMTP), EMAIL_SENDER_NAME and SLACK_WEBHOOK_URL. the
   instruction of getting a SLACK_WEBHOOK_URL can be found at [this website](https://github.com/stevenosloan/slack-notifier)
   To get the WEBHOOK_URL you need to do the following:
   1. go to https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
   2. choose your team, press configure
   3. in configurations press add configuration
   4. choose channel, press "Add Incoming WebHooks integration"
3. The scheduled work for appointment time out can be set at `config/initializers/scheduler.rb`.
4. To install the survey, please follow the instruction for
   the [LA-Feedback-System](https://github.com/hbiede/LA-Feedback-System) and fill in the database configuration
   in `config/database.yml`


## Testing and Contributing

1. run `rails server` if you are contributing;
2. open your browser and go to `localhost:3000` or the domain you bind with.