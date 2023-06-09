ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = ''

  form_fields = [
    'textarea',
    'input',
    'select'
  ]

  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')

  elements.each do |e|
    if e.node_name.eql? 'label'
      html = %(#{e}).html_safe
    elsif e['type'].present? && e['type'] == 'hidden'
      # Patch per selectpicker
      html = %(#{e}).html_safe
    elsif form_fields.include? e.node_name
      if e['class'].present?
        e['class'] += ' is-invalid'
      else
        e['class'] = ' is-invalid'
      end
      if instance.error_message.kind_of?(Array)
        html = %(#{e}<div class="invalid-feedback">#{instance.error_message.uniq.join(', ')}</div>).html_safe
      else
        html = %(#{e}<div class="invalid-feedback">#{instance.error_message.join(', ')}</div>).html_safe
      end
    end
  end
  html
end
