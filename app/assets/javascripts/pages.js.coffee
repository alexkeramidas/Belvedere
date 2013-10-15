window.BelvedereGit ||= {}
class BelvedereGit.pages extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this

    location: () ->
        MyControl = (controlDiv, map) ->
            controlDiv.style.padding = '5px'
            
            controlUI = document.createElement('div')
            controlUI.style.backgroundColor = 'white'
            controlUI.style.borderStyle = 'solid'
            controlUI.style.borderWidth = '2px'
            controlUI.style.cursor = 'pointer'
            controlUI.style.textAlign = 'center'
            controlUI.id = 'mycontrol'
            controlUI.title = 'Click to set the map to Home'
            controlDiv.appendChild(controlUI)
            
            controlText = document.createElement('div')
            controlText.style.fontFamily = 'Arial,sans-serif'
            controlText.style.fontSize = '12px'
            controlText.style.paddingLeft = '4px'
            controlText.style.paddingRight = '4px'
            controlText.innerHTML = '<strong>Home</strong>'
            controlUI.appendChild(controlText)
            
            controlUI.click ->
                map.setCenter(chicago)

        initialize = ->
            mapOptions =
                zoom: 8,
                center: new google.maps.LatLng(-34.397, 150.644),
                mapTypeControl: true,
                mapTypeControlOptions: {
                    style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
                    position: google.maps.ControlPosition.TOP_RIGHT
                },
                zoomControl: true,
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE,
                    position: google.maps.ControlPosition.LEFT_CENTER
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP
            
            map = new google.maps.Map(document.getElementById("map"), mapOptions);
            
            controlDiv = document.createElement('div')
            myControl = new MyControl(controlDiv, map)
            
            controlDiv.index = 1
            
            map.controls[google.maps.ControlPosition.TOP_RIGHT].push(controlDiv)
        
        initialize()
