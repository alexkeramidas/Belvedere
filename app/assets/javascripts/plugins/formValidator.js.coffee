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
            
            testAndReplaceNumeric = (el) ->
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
            
            isPhone = (el) ->
                if el.is('[type=tel]')
                    true
                else
                    if el.is('[data-type]')
                        if el.attr('data-type') == 'phone'
                            true
                        else
                            false
                    else
                        false
            
            testPhone = (el) ->
                if el.val().match(/^[\d\(\)\[\]\s\-\+\/\.]{5,}$/g) != null
                    phone_num = parseInt($.grep(el.val().split(/(\d+)/), (num, index) ->
                                    num  if RegExp("^[0-9]*$").test(num)
                                ).join(""))
                    if phone_num > 10000 && phone_num < 999999999999999
                        if el.val().match(/^.+\+.*$/g) == null
                            if el.val().match(/\(/g) != null && el.val().match(/\)/g) != null
                                if el.val().match(/\(/g).length == el.val().match(/\)/g).length
                                    if el.val().match(/\[/g) != null && el.val().match(/\]/g) != null
                                        false
                                    else
                                        true
                                else
                                    false
                            else
                                true
                        else
                            false
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
                    testAndReplaceNumeric(el)
                else if isPhone(el)
                    testPhone(el)
                else if isRequired(el) && el.val() == ''
                    false
                else if !isRequired(el) && el.val() == ''
                    true
                else if hasPattern(el) && el.val().match(new RegExp(el.attr('pattern'), 'g')) == null
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
            
            obj.on('submit', (e) ->
                all_is_empty = true
                all_is_good = true
                
                for field_id in fields_list
                    field_valid = validateField($("##{field_id}"))
                    switchFieldClasses($("##{field_id}"))
                
                    if $("##{field_id}").val() != ''
                        all_is_empty = false
                        if !field_valid
                            all_is_good = false
                    else if isRequired($("##{field_id}")) && $("##{field_id}").val() == ''
                        all_is_good = false
                    
                if all_is_good && !all_is_empty
                    true
                else
                    false
            )
            
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
