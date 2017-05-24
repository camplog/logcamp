
$(document).ready ->

  jQuery.validator.addMethod "emailListValid", (value, element) ->
    listEmail = value.split ','
    errors = []
    $(listEmail).each (index, email)->
      email = email.trim()
      console.log(email)
      if email != '' && !/([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})/.test(email)
        errors.push email

    if errors.length > 0
      jQuery.validator.messages.emailListValid = I18n.t('users.index.validates.list_email', {list: errors.join(', ')})
      return false
    else
      return true

  $("#form-invite-app").validate
    rules:
      email_list:
        required: true
        emailListValid: true

    errorLabelContainer: '#error-msg'
