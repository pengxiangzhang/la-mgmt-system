module AdminHelper
  def application_form
    FormBuilder.find_by(formname: 'application')['formdata']
  end

  def interview_form
    FormBuilder.find_by(formname: 'interview')['formdata']
  end

  def admin_email
    SystemValue.find_by(name: 'admin_email')
  end

  def system_url
    SystemValue.find_by(name: 'system_url')
  end

  def get_la_course(id)
    return @lac = LaCourse.joins(:course).where({ la_detail_id: id })
  end
end
