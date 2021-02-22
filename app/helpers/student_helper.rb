module StudentHelper

  def hiring_calendar
    SystemValue.find_by(name: 'hiring_calendar').value
  end

  def accept_application
    SystemValue.find_by(name: 'application_opening')
  end

  def application_form
    FormBuilder.find_by(formname: 'application')['formdata']
  end

  def application_email
    SystemValue.find_by(name: 'application_email').value
  end
end
