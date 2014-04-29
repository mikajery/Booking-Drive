## app/inputs/date_time_picker_input.rb
class ClipInput < SimpleForm::Inputs::Base
  def input
    template.content_tag()
    template.content_tag(:div, class: 'col-sm-9') do
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def input_html_options
    {class: 'form-control'}
  end

end