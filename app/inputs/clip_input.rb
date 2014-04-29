## app/inputs/date_time_picker_input.rb
class ClipInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'col-sm-9') do
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def input_html_options
    {class: 'form-control'}
  end

  def label_input(wrapper_options = nil)
    if options[:label] == false
      input(wrapper_options)
    elsif nested_boolean_style?
      html_options = label_html_options.dup
      html_options[:class] ||= []
      html_options[:class].push(SimpleForm.boolean_label_class) if SimpleForm.boolean_label_class

      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      build_hidden_field_for_checkbox +
        @builder.label(label_target, html_options) {
          build_check_box_without_hidden_field(merged_input_options) + label_text
        }
    else
      input(wrapper_options) + label(wrapper_options)
    end
  end

  def label(wrapper_options)
  end
end