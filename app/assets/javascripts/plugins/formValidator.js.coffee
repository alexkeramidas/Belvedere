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
            
            hasPattern = (el) ->
                el.is('[pattern]')
            
            hasMinLength = (el) ->
                el.is('[minlength]')
            
            hasMaxLength = (el) ->
                el.is('[maxlength]')
            
            initializeFields = ->
                for field_id in fields_list
                    if !validateField($("##{field_id}")) && $("##{field_id}").val() == ''
                        $("##{field_id}").removeClass('has-success').removeClass('has-error').addClass('is-required')
            
            validateField = (el) ->
                if isRequired(el) && el.val() == ''
                    false
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
                if !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
                else
                    switchFieldClasses($(this))
            )
            
            obj.find('textarea').on('focus focusin', (e) ->
                if !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
                else
                    switchFieldClasses($(this))
            )
            
            obj.find('input').on('blur focusout', (e) ->
                if !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
            )
            
            obj.find('textarea').on('blur focusout', (e) ->
                if !validateField($(this)) && $(this).val() == ''
                    $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
            )
) jQuery
