(($) ->
    $.fn.extend formValidator: (options) ->
        defaults =
            validatedFields: ['email']

        options = $.extend(defaults, options)
    
        @each ->
            o = options
            obj = $(this)
            fields_list = o.validatedFields
            
            
            # Form validation methods
            
            isRequired = (el) ->
                el.is('[required]')
            
            isNumeric = (el) ->
                if el.is('[type=number]')
                    true
                else
                    if el.is('[data-type]')
                        if el.attr('data-type') == 'numeric'
                            true
                        else
                            false
                    else
                        false
            
            hasMin = (el) ->
                el.is('[min]')
            
            hasMax = (el) ->
                el.is('[max]')
            
            hasPattern = (el) ->
                el.is('[pattern]')
            
            hasMinLength = (el) ->
                el.is('[minlength]')
            
            hasMaxLength = (el) ->
                el.is('[maxlength]')
            
            initializeFields = ->
                for field_id in fields_list
                    if !validateField($("##{field_id}")) && $("##{field_id}").val() == ''
                        if !isRequired($("##{field_id}"))
                            $("##{field_id}").removeClass('has-success').removeClass('has-error').removeClass('is-required')
                        else
                            $("##{field_id}").removeClass('has-success').removeClass('has-error').addClass('is-required')
            
            validateField = (el) ->
                if isNumeric(el)
                    current_numeric = el.val().replace(/\D/g, '')
                    if current_numeric == ''
                        el.val('')
                        false
                    else if hasMin(el) && parseInt(current_numeric) < parseInt(el.attr('min'))
                        el.val(el.attr('min'))
                        true
                    else if hasMax(el) && parseInt(current_numeric) > parseInt(el.attr('max'))
                        el.val(el.attr('max'))
                        true
                    else
                        el.val(current_numeric)
                        true
                else if isRequired(el) && el.val() == ''
                    false
                else if !isRequired(el) && el.val() == ''
                    true
                else if hasPattern(el) && el.val().match(new RegExp(el.attr('pattern'), 'g')) == null
                    false
                else if hasPattern(el) && el.val() != el.val().match(new RegExp(el.attr('pattern'), 'g'))[0]
                    false
                else if hasMinLength(el) && parseInt(el.attr('minlength')) > el.val().length
                    false
                else if hasMaxLength(el) && parseInt(el.attr('maxlength')) < el.val().length
                    false
                else
                    true
            
            switchFieldClasses = (el) ->
                if validateField(el)
                    el.removeClass('is-required').removeClass('has-error').addClass('has-success')
                else
                    el.removeClass('is-required').removeClass('has-success').addClass('has-error')
                
                if !isRequired(el) && el.val() == ''
                    el.removeClass('has-error').removeClass('has-success').removeClass('is-required')
            
            
            # Validates the form
            
            # If javascript is enabled, disable CSS3 validations
            obj.attr('novalidate', 'novalidate')
            
            initializeFields()
            
            # Make sure form fields get properly initialized if we click on the 'Contact' bottom menu option.
            # The setTimeout addition forces Internet Explorer to play nice and the 'page:change' event
            # is used for compatibility with turbolinks.
            $(document).bind 'page:change', ->
                setTimeout initializeFields, 10
            
            $(window).load ->
                initializeFields()
            
            obj.submit ->
                for field_id in fields_list
                    switchFieldClasses($("##{field_id}"))
                
                if (fields_list.every (field_id)-> validateField($("##{field_id}")))
                    $(this).submit()
                
                false
            
            obj.find('input').on('input keyup keydown keypress change', (e) ->
                switchFieldClasses($(this))
            )
            
            obj.find('textarea').on('input keyup keydown keypress change', (e) ->
                switchFieldClasses($(this))
            )
            
            obj.find('input').on('focus focusin', (e) ->
                if isRequired($(this)) && !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
                else
                    switchFieldClasses($(this))
            )
            
            obj.find('textarea').on('focus focusin', (e) ->
                if isRequired($(this)) && !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
                else
                    switchFieldClasses($(this))
            )
            
            obj.find('input').on('blur focusout', (e) ->
                if isRequired($(this)) && !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
            )
            
            obj.find('textarea').on('blur focusout', (e) ->
                if isRequired($(this)) && !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
            )
) jQuery
