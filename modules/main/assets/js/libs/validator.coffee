###
  global validator class
  map şu şekilde girilmeli

  error_map =
    'horizon_create_unchecked_review_form[companyName]':
      display: '#s2id_firma-input'
      position: 'top'
      message: 'Firma adını boş bırakmayınız'
###

class window.Validator
  $map = []

  placeholder_validator: (element)->
    if $(element).data('state') is 'empty' and ($(element).is('[required]') or $(element).is('[data-rule-required]'))
      if $(element).is('[data-msg-required]')
        $(element).attr('data-msg-required')
      else
        'Lütfen bu alanı boş bırakmayınız.'
    else
      null

  constructor: (@form,@map,@handleBackend=true)->
    prn = @ # parent
    $map = @map
    @form.on 'submit', ()->
      if prn.form.valid()
        $(this).trigger 'validation_success'
        true
      else
        false

    @validator = @form.validate(
      ignore: ''
    # any other options & rules,
      errorPlacement: (error, element) ->
        lastError = $(element).data("lastError")
        newError = $(error).text()
        $(element).data "lastError", newError
        if newError isnt "" and newError isnt lastError
          name = $(element).attr('name')
          if prn.map[name]?
            error_display_element = $(prn.map[name].display)
            unless error_display_element.data('tooltipstered')?
              error_display_element.data 'tooltipstered', 1
              error_display_element.tooltipster
                theme: 'tooltipster-error'
                trigger: "custom"
                onlyOne: false
                position: prn.map[name].position

            error_message = if  prn.map[name].message? then prn.map[name].message else newError
            error_display_element.tooltipster "content", error_message
            error_display_element.tooltipster "show"
        return

        this.defaultShowErrors()
        return
      success: (label, element) ->
        name = $(element).attr('name')
        if prn.map[name]?
          error_display_element = $(prn.map[name].display)
          if error_display_element.data('tooltipstered')?
            error_display_element.tooltipster "hide"
        return
    )

    if @handleBackend is true
      #$(".validation-error[error-field='#{@form.attr("name")}']").removeClass('validation-error').addClass('validation-form-error')
      $('.validation-error').each ->
        name = $(this).attr('error-field')
        error_message = ''
        if prn.map[name]?
          error_display_element = $(prn.map[name].display)
          if error_display_element.data('tooltipstered')?
            error_message = error_display_element.tooltipster('content')+"<br>"
          else
            error_display_element.data 'tooltipstered', 1
            error_display_element.tooltipster
              theme: 'tooltipster-error'
              trigger: "custom"
              onlyOne: false
              position: prn.map[name].position
              contentAsHTML: true

          error_message += $(this).html()
          error_display_element.tooltipster "content", error_message
          error_display_element.tooltipster "show"
          $(this).parent().remove()
        else
          $(this).parent().addClass('validation-form-error')

  clear_validation: ->
    # Internal $.validator is exposed through $(form).validate()
    form = @form
    validator = form.validate()

    checker = ->
      if form.find('.tooltipster:visible').length is 0
        form.find('[name]').each ->
          validator.successList.push this #mark as error free
          validator.showErrors() #remove error messages if present
          validator.resetForm() #remove error class on name elements and clear history
          validator.reset() #remove all error and success data
          return
      else
        setTimeout(checker, 400)
      return

    setTimeout(checker, 400)

    for own name,val of $map
      if $(val.display).data('tooltipstered')?
        $(val.display).tooltipster 'hide'

    #Iterate through named elements inside of the form, and mark them as error free
    #    $("[name]", @form).each ->
    #      console.log(this)
    #      validator.successList.push this #mark as error free
    #      validator.showErrors() #remove error messages if present
    #      return


    return

  form: ->
    @validator.form()
    return

  element: (selector)->
    @validator.element(selector)
    return