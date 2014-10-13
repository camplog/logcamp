# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'pure-alert pure-alert-danger'
  config.button_class = 'pure-button pure-button-primary'
  config.boolean_label_class = nil

  config.wrappers :aligned_form, tag: 'div', class: 'pure-control-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'pure-input-1-2'
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.default_wrapper = :aligned_form
end