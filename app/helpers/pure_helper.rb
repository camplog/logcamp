module PureHelper

	def status_tag(status, options = {})
    klass = ["pure-badge"]
    if options.has_key?(:level)
      klass << "pure-badge-#{options.delete(:level).to_s}"
    end
    klass << options[:class].strip.split(/\s+/) unless options[:class].blank?
    options[:class] = klass.flatten.join(" ")
    content_tag(:span, status, options)
  end

  def label_tag(label, options = {})
    klass = ["pure-label"]
    if options.has_key?(:level)
      klass << "pure-label-#{options.delete(:level).to_s}"
    end
    klass << options[:class].strip.split(/\s+/) unless options[:class].blank?
    options[:class] = klass.flatten.join(" ")
    content_tag(:span, label, options)
  end

  def icon_tag(icon)
    content_tag(:span, '', class: "icon-#{icon}")
  end

  def icon_link_to(text, url, options)
    icon = options.delete(:icon) if options.has_key?(:icon)
    icon_tag = ''
    if icon
      icon_klass = ["icon-#{icon}"]
      if options.has_key?(:white)
        icon_klass << ["icon-white"]
        options.delete(:white)
      end
      icon_tag = content_tag(:i, '', class: icon_klass.join(' '))
    end
    link_to (icon_tag + " #{text}").html_safe, url, options
  end

  def label_link_to(text, url, options)
  	label = options.delete(:label) if options.has_key?(:label)
    label_tag = ''
    if label
      label_klass = ["pure-label pure-label-#{label}"]
      label_tag = content_tag(:span, '', class: label_klass.join(' '))
    end
    link_to (label_tag + " #{text}").html_safe, url, options
  end

  def button_link_to(text, url, options={})
    klass = ["pure-button"]
    if options.has_key?(:size)
      klass << "pure-button-#{options[:size]}"
      options.delete(:size)
    end
    if options.has_key?(:level)
      klass << "pure-button-#{options[:level]}"
      options.delete(:level)
    end
    klass << options[:class].strip.split(/\s+/) unless options[:class].blank?
    options[:class] = klass.flatten.join(" ")
    link_to text, url, options
  end

  def icon_button_link_to(text, url, options)
    klass = ["pure-button"]
    icon = options.delete(:icon) if options.has_key?(:icon)
    icon_tag = ''
    if icon
      klazz = ["icon-#{icon}"]
      if options.has_key?(:white)
        klazz << ["icon-white"]
        options.delete(:white)
      end
      icon_tag = content_tag(:span, '', class: klazz.join(' '))
    end
    if options.has_key?(:size)
      klass << "pure-button-#{options[:size]}"
      options.delete(:size)
    end
    if options.has_key?(:level)
      klass << "pure-button-#{options[:level]}"
      options.delete(:level)
    end

    klass << options[:class].strip.split(/\s+/) unless options[:class].blank?
    options[:class] = klass.flatten.join(" ")
    button_link_to (icon_tag + " #{text}").html_safe, url, options
  end

end