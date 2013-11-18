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
