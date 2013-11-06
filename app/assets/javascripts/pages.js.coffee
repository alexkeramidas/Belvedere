window.BelvedereGit ||= {}
class BelvedereGit.pages extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
        
    home: () ->
        $('body').bgCarousel()
        
    photo_gallery: () ->
        $('body').bgCarousel()

    location: () ->
        MyPositioningControl = (controlDiv, map) ->
            controlDiv.style.padding = '5px'
            controlDiv.style.height = '110px'
            controlDiv.id = 'mycontrol'
            
        positionControls = ->
            $('#mycontrol').css('position','relative').css('right','').css('float','right').css('clear','both')
            $('.gmnoprint.gm-style-mtc').css('position','relative').css('right','').css('float','right').css('clear','both')

        initialize = ->
            belvedereLocation = new google.maps.LatLng(39.147625, 23.460580)
            
            mapOptions =
                zoom: 14,
                center: belvedereLocation,
                mapTypeControl: true,
                mapTypeControlOptions: {
                    style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
                    position: google.maps.ControlPosition.TOP_RIGHT
                },
                panControl: false,
                zoomControl: true,
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE,
                    position: google.maps.ControlPosition.LEFT_CENTER
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP
            
            map = new google.maps.Map(document.getElementById("map"), mapOptions);
            
            marker = new google.maps.Marker
                position: belvedereLocation,
                map: map,
                title: 'Belvedere Hotel'
            
            controlDiv = document.createElement('div')
            myControl = new MyPositioningControl(controlDiv, map)
            
            controlDiv.index = 1
            
            map.controls[google.maps.ControlPosition.TOP_RIGHT].push(controlDiv)
        
            google.maps.event.addListener map, 'tilesloaded', ->
                positionControls()
            
            google.maps.event.addListener map, 'idle', ->
                positionControls()
                
            google.maps.event.addDomListener window, 'resize', ->
                map.setCenter(belvedereLocation)
        
        initialize()
        
    contact: () ->
        isRequired = (el) ->
            el.is('[required]')
        
        hasPattern = (el) ->
            el.is('[pattern]')
        
        hasMinLength = (el) ->
            el.is('[minlength]')
        
        hasMaxLength = (el) ->
            el.is('[maxlength]')
        
        initializeFields = ->
            if !validateField($('#name')) && $('#name').val() == ''
                $('#name').removeClass('has-success').removeClass('has-error').addClass('is-required')
            if !validateField($('#email')) && $('#email').val() == ''
                $('#email').removeClass('has-success').removeClass('has-error').addClass('is-required')
            if !validateField($('#comment')) && $('#comment').val() == ''
                $('#comment').removeClass('has-success').removeClass('has-error').addClass('is-required')
        
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
        
        # If javascript is enabled, disable CSS3 validations
        $('.contactform').attr('novalidate', 'novalidate')
        
        initializeFields()
        
        # Make sure form fields get properly initialized if we click on the 'Contact' bottom menu option.
        # The setTimeout addition forces Internet Explorer to play nice and the 'page:change' event
        # is used for compatibility with turbolinks.
        $(document).bind 'page:change', ->
            setTimeout initializeFields, 10
        
        $(window).load ->
            initializeFields()
        
        $('.contactform').submit ->
            switchFieldClasses($('#name'))
            switchFieldClasses($('#email'))
            switchFieldClasses($('#comment'))
            
            if validateField($('#name')) && validateField($('#email')) && validateField($('#comment'))
                $(this).submit()
            
            false
        
        $('.contactform input').on('input keyup keydown keypress change', (e) ->
            switchFieldClasses($(this))
        )
        
        $('.contactform textarea').on('input keyup keydown keypress change', (e) ->
            switchFieldClasses($(this))
        )
        
        $('.contactform input').on('focus focusin', (e) ->
            if !validateField($(this)) && $(this).val() == ''
                $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
            else
                switchFieldClasses($(this))
        )
        
        $('.contactform textarea').on('focus focusin', (e) ->
            if !validateField($(this)) && $(this).val() == ''
                $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
            else
                switchFieldClasses($(this))
        )
        
        $('.contactform input').on('blur focusout', (e) ->
            if !validateField($(this)) && $(this).val() == ''
                $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
        )
        
        $('.contactform textarea').on('blur focusout', (e) ->
            if !validateField($(this)) && $(this).val() == ''
                $(this).removeClass('has-success').removeClass('has-error').addClass('is-required')
        )
