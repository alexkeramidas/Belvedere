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
        
        $gallery_title = $('.photo-gallery .title')
        $gallery_description = $('.photo-gallery .wrapper')
        
        contentSliding = (el) ->
            el.css('display') == 'block' && window.css(el).height != 'auto'
        
        if $gallery_description.length
            gallery_text = $gallery_title.find('h1').text()
            
            $gallery_title.addClass('has-description').css('cursor', 'pointer')
            $gallery_description.css('height', $gallery_description.css('min-height'))
            
            $('.photo-gallery .title').on('click', (e) ->
                if $gallery_description.css('display') == 'block'
                    $gallery_description.slideUp(1000, (->
                            $gallery_title.addClass('closed')
                            $gallery_description.css('min-height', '0')
                        )
                    )
                else
                    $gallery_description.find('.mCustomScrollbar').removeClass('scrollable')
                    $gallery_description.slideDown(1000, (->
                            $gallery_description.find('.mCustomScrollbar').addClass('scrollable')
                        )
                    )
                    $gallery_title.removeClass('closed')
            )
            
            $('.photo-gallery .title h1').on('mouseenter', ->
                window.clicked = false
                
                window.initial_display = $('.photo-gallery .wrapper').css('display')
                window.initial_content = $('.photo-gallery .title').find('h1').text()
                
                if $gallery_description.css('display') == 'none' || contentSliding($gallery_description)
                    $(this).css('margin-right', '0').css('width', '99%').text(gallery_text).parent().removeClass('hidden-text')
                
                $('.photo-gallery .title').on('click', ->
                    window.clicked = true
                )
                
                $('.photo-gallery .title h1').on('mouseleave', (e) ->
                    e.stopImmediatePropagation()
                    if (window.clicked == false && window.initial_display == 'none') || (window.clicked == true && (window.initial_content != ''))
                        $(this).css('margin-right', '30px').css('width', 'auto').text('').parent().addClass('hidden-text')
                    false
                )
            )
                
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
