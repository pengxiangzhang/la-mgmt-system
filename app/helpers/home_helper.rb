module HomeHelper
  def contact_form
    FormBuilder.find_by(formname: 'contact')['formdata']
  end
end
