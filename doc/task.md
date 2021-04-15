# LA Management System - Maintenance Task

# Table of contents

- [LA Management System - Maintenance Task](#la-management-system---maintance-task)
    - [Maintenance Log](#maintenance-log)
    - [Maintenance Task](#maintenance-task)

- [ ]  To ensure the project has a long life span, we are using `Bootstrap v5.0.0-beta3` during development. This will
  need to be changed to the stable version on `app/view/layouts/_head.html.erb` when it is available.

## Maintenance Log

- [ ]  Check Error log on `log/cselap.log`
- [ ]  Check corn log on `log/cron_log.log`
- [ ]  If there is a security concern check on the action log on `log/action_log.log`

## Maintenance Task

- [ ]  If requested, remove past application form on `storage/application/` and `applications` table on database.
- [ ]  If requested, check if there is an unsend queued email on `storage/send_later/`
- [ ]  If requested, clear out past appointment records on the database on `appointments` table (Note: Only clear status
  is closed. If you want to remove unclose record is needed to make sure `hasAppointment = 0` on `user_details` table
- [ ]  If requested on a really rare case, clear out past sessions record on the database on `sessions` table
- [ ]  If requested on a really rare case, clear out users on `user_details` if they are not an `admin` or `la`
