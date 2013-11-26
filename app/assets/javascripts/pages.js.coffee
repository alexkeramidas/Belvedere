window.BelvedereGit ||= {}
class BelvedereGit.pages extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
        
    home: () ->
        $('body').bgCarousel()
        
        $('.reservationform').formValidator
            validatedFields: ['name', 'email', 'phone', 'mobile', 'arrival', 'departure', 'adults', 'children', 'message']
        
        $('#arrival').on('changeDate', (e) ->
            this_day = new Date($('#arrival').val())
            next_day_obj = new Date(this_day.getFullYear(), this_day.getMonth(), this_day.getDate() + 1)
            next_day = "#{next_day_obj.getFullYear()}-#{('0' + (next_day_obj.getMonth() + 1)).slice(-2)}-#{('0' + next_day_obj.getDate()).slice(-2)}"
            $('#arrival').datepicker('hide').blur()
            $('#departure').datepicker('setStartDate', next_day).datepicker('update', next_day).focus()
        )
        
        $formwrapper = $('.formwrapper')
        
        if window.location.hash == ''
            $('.form-link').addClass('form-closed').addClass('with-bg')
            $('.external-link').removeClass('initialized')
            $formwrapper.css('display', 'none')
        
        $('.form-link').on('click', (e) ->
            if window.location.hash == '#reservation'
                $('.external-link').removeClass('initialized').css('display', 'none')
            
            if $formwrapper.css('display') == 'none'
                $formwrapper.find('form > .mCustomScrollbar').removeClass('scrollable')
                $formwrapper.slideDown(1000, (->
                        $formwrapper.find('form > .mCustomScrollbar').addClass('scrollable')
                        $('.form-link').removeClass('form-closed')
                    )
                )
                $('.form-link').removeClass('with-bg')
                $('.external-link').css('display', 'none')
                window.location.hash = '#reservation'
            else
                $formwrapper.slideUp(1000, (->
                        $('.form-link').addClass('form-closed').addClass('with-bg')
                        $('.external-link').css('display', 'block')
                    )
                )
                history.pushState('', document.title, "#{window.location.pathname}#{window.location.search}")
        )
        
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
        $('.contactform').formValidator
            validatedFields: ['name', 'email', 'comment']
