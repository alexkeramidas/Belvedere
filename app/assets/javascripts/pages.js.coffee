window.BelvedereGit ||= {}
class BelvedereGit.pages extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this

    home: () ->
        $('body').bgCarousel()

        # Show welcome tip with animation
        showTip = ->
            $('.tip').removeClass('hidden')
            $('body').waitForImages
                finished: ->
                    $('.tip').removeClass('small')
                waitForAll: true

        # Hide welcome tip with animation
        hideTip = ->
            $('.tip').addClass('small')
            setTimeout (->
                $('.tip').addClass('hidden')
            ), 1000

        # Hide welcome tip without animation
        hideTipImmediately = ->
            $('.tip').addClass('small').addClass('hidden')

        showTip() if window.location.hash == ''
        $('.tip .button-close').on('click', (e) ->
            hideTip()
            false
        )

        $('#arrival').datepicker 'option',
            startDate: '+0d'
        $('#departure').datepicker 'option',
            startDate: '+1d'

        $('.reservationform').formValidator
            validatedFields: ['name', 'email', 'phone', 'mobile', 'arrival', 'departure', 'adults', 'children', 'message']

        $('#arrival').on('changeDate', (e) ->
            $('#arrival').datepicker('hide').blur()

            this_day = new Date($('#arrival').val())
            next_day_obj = new Date(this_day.getFullYear(), this_day.getMonth(), this_day.getDate() + 1)
            next_day = "#{next_day_obj.getFullYear()}-#{('0' + (next_day_obj.getMonth() + 1)).slice(-2)}-#{('0' + next_day_obj.getDate()).slice(-2)}"

            $('#departure').datepicker('setStartDate', next_day).datepicker('update', next_day).focus()
        )

        $formwrapper = $('.formwrapper')
        $errors = $('#reservation-errors')
        $success = $('.alert.alert-success')

        if window.location.hash == ''
            $('.form-link').addClass('form-closed').addClass('with-bg')
            $('.external-link').removeClass('initialized')
            $formwrapper.css('display', 'none')
            $errors.css('display', 'none')
            $('.reservation-link').removeClass('active')
        else if window.location.hash == '#reservation'
            if !$('.formwrapper .has-error').length
                $errors.css('display', 'none')
            $('.reservation-link').addClass('active')

        reservationFormOpen = ->
            $formwrapper.find('form > .mCustomScrollbar').removeClass('scrollable')
            $formwrapper.slideDown(1000, (->
                    $formwrapper.find('form > .mCustomScrollbar').addClass('scrollable')
                    $('.form-link').removeClass('form-closed')
                    if $('.formwrapper .has-error').length
                        $errors.css('display', 'block')
                )
            )
            $('.form-link').removeClass('with-bg')
            $('.external-link').css('display', 'none')

            window.location.hash = '#reservation'
            $('.reservation-link').addClass('active')

        reservationFormClose = ->
            $formwrapper.slideUp(1000, (->
                    $('.form-link').addClass('form-closed').addClass('with-bg')
                    $('.external-link').css('display', 'block')
                )
            )
            $errors.css('display', 'none')
            $success.css('display', 'none')

            if history.pushState
                history.pushState('', document.title, "#{window.location.pathname}#{window.location.search}")
            else
                window.location.hash = '#'
            $('.reservation-link').removeClass('active')

        $('.form-link').on('click', (e) ->
            hideTipImmediately()

            if window.location.hash == '#reservation'
                $('.external-link').removeClass('initialized').css('display', 'none')

            if $formwrapper.css('display') == 'none'
                reservationFormOpen()
            else
                reservationFormClose()

            false
        )

        $('.reservation-link').on('click', (e) ->
            hideTipImmediately()

            if $formwrapper.css('display') == 'none'
                reservationFormOpen()
            false
        )

    photo_gallery: () ->
        $('body').bgCarousel()

        $gallery_title = $('.photo-gallery .title')
        $gallery_description = $('.photo-gallery .wrapper')

        contentSliding = (el) ->
            el.css('display') == 'block' && window.css(el).height != 'auto'

        # Opening and closing the photo gallery details is not allowed on IE8 and lower
        # because when translating css values to a readable object, many of these
        # are not supported and we get an error.
        if jQuery.support.opacity == true
            if $gallery_description.length
                gallery_text = $gallery_title.find('h1').text()

                $gallery_title.addClass('has-description').css('cursor', 'pointer')
                $gallery_description.css('height', $gallery_description.css('min-height')).css('min-height', '0')

                window.sliding_up = false
                window.sliding_down = false

                window.slide_up_requested = false

                $('.photo-gallery .title').on('click', (e) ->
                    if $gallery_description.css('display') == 'block'
                        $gallery_description.slideUp(1000, (->
                                $gallery_title.addClass('closed')
                                window.sliding_up = false
                                $(this).addClass('hidden-text').find('h1').css('margin-right', '30px').css('width', 'auto').text('')
                            )
                        )
                        window.sliding_up = true
                        window.slide_up_requested = true
                    else
                        $gallery_description.find('.mCustomScrollbar').removeClass('scrollable')
                        $gallery_description.slideDown(1000, (->
                                $gallery_description.find('.mCustomScrollbar').addClass('scrollable')
                                window.sliding_down = false
                                $(this).removeClass('hidden-text').find('h1').css('margin-right', '0').css('width', '99%').text(gallery_text)
                            )
                        )
                        window.sliding_down = true
                        window.slide_up_requested = false
                        $gallery_title.removeClass('closed')
                )

                $('.photo-gallery .title h1').on('mouseenter', ->
                    window.initial_display = $('.photo-gallery .wrapper').css('display')
                    window.initial_content = $('.photo-gallery .title').find('h1').text()

                    if $gallery_description.css('display') == 'none' || contentSliding($gallery_description)
                        $(this).css('margin-right', '0').css('width', '99%').text(gallery_text).parent().removeClass('hidden-text')

                    $('.photo-gallery .title h1').on('mouseleave', (e) ->
                        e.stopImmediatePropagation()
                        if !($('.photo-gallery .wrapper').css('display') == 'block' && $('.photo-gallery .title').find('h1').text() != '' && !window.sliding_up && !window.sliding_down)
                            if window.sliding_up || (!window.sliding_up && !window.sliding_down && window.initial_display == 'none' && window.initial_content == '') || ($('.photo-gallery .wrapper').css('display') == 'none' && !window.sliding_up && !window.sliding_down && window.slide_up_requested && window.initial_display == 'block' && window.initial_display != '')
                                $(this).css('margin-right', '30px').css('width', 'auto').text('').parent().addClass('hidden-text')
                        false
                    )
                )

    location: () ->

        window.myjson = $(document).ready ->
            $.getJSON beaches, (json) ->
                window.myjson = json

        MyPositioningControl = (controlDiv, map) ->
            controlDiv.style.padding = '5px'
            controlDiv.style.height = '110px'
            controlDiv.id = 'mycontrol'

        positionControls = ->
            $('#mycontrol').css('position','relative').css('right','').css('float','right').css('clear','both')
            $('.gmnoprint.gm-style-mtc').css('position','relative').css('right','').css('float','right').css('clear','both')

        initialize = ->
            belvedereLocation = new google.maps.LatLng(39.147625, 23.460580)
            lalariaLocation = new google.maps.LatLng(39.206085, 23.480626)
            kastroLocation = new google.maps.LatLng(39.207814, 23.462781)
            oldSkiathosLocation = new google.maps.LatLng(39.210626,23.461227)
            aselinosLocation = new google.maps.LatLng(39.173457, 23.424469)
            bananaLocation = new google.maps.LatLng(39.146748, 23.392599)
            vromolimnosLocation = new google.maps.LatLng(39.137132, 23.44576)
            koukounariesLocation = new google.maps.LatLng(39.148617, 23.401736)
            megaliAmmosLocation = new google.maps.LatLng(39.162740, 23.480006)
            axladiesLocation = new google.maps.LatLng(39.147068, 23.464035)
            vasiliasLocation = new google.maps.LatLng(39.152797, 23.468265)
            tzaneriaLocation = new google.maps.LatLng(39.139532, 23.457621)
            kanapitsaLocation = new google.maps.LatLng(39.136759, 23.460220)
            koliosLocation = new google.maps.LatLng(39.141417, 23.445740)
            troulosLocation = new google.maps.LatLng(39.140154, 23.420040)
            ampelakiaLocation = new google.maps.LatLng(39.145603, 23.397103)
            mikriBananaLocation = new google.maps.LatLng(39.149325, 23.392008)
            kryfiAmmosLocation = new google.maps.LatLng(39.158342, 23.389743)
            agiaEleniLocation = new google.maps.LatLng(39.154259, 23.391176)
            mandrakiLocation = new google.maps.LatLng(39.165776, 23.398773)
            eliaLocation = new google.maps.LatLng(39.167806, 23.402463)
            aggistrosLocation = new google.maps.LatLng(39.167731, 23.408842)

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

            beachPin = image_path('beach_pin.png')
            hotelPin = image_path('belvedere_pin.png')


# Belvedere Hotel Info & Marker
            belvedereMarker = new google.maps.Marker
                position: belvedereLocation
                map: map
                icon: hotelPin


# Koukounaries Beach Info & Marker
            koukounariesMarker = new google.maps.Marker
                position:koukounariesLocation
                map: map
                icon: beachPin

            infoKoukounaries = new google.maps.InfoWindow()

            google.maps.event.addListener koukounariesMarker, 'click', ->
              if myjson[0].description.length > 5
                infoKoukounaries.setContent myjson[0].description
              else
                infoKoukounaries.setContent myjson[0].title
              infoKoukounaries.open map, this

# Big Banana Beach Info & Marker
            bananaMarker = new google.maps.Marker
                position:bananaLocation
                map: map
                icon: beachPin

            infoBanana = new google.maps.InfoWindow()

            google.maps.event.addListener bananaMarker, 'click', ->
                if myjson[1].description.length > 5
                  infoBanana.setContent myjson[1].description
                else
                  infoBanana.setContent myjson[1].title
                infoBanana.open map, bananaMarker


# Megali Ammos Beach Info & Marker
            megaliAmmosMarker = new google.maps.Marker
                position:megaliAmmosLocation
                map: map
                icon: beachPin

            infomegaliAmmos = new google.maps.InfoWindow()

            google.maps.event.addListener megaliAmmosMarker, 'click', ->
                if myjson[2].description.length > 5
                  infomegaliAmmos.setContent myjson[2].description
                else
                  infomegaliAmmos.setContent myjson[2].title
                infomegaliAmmos.open map, this

# Axladies Beach Info & Marker
            axladiesMarker = new google.maps.Marker
                position:axladiesLocation
                map: map
                icon: beachPin

            infoaxladies = new google.maps.InfoWindow()

            google.maps.event.addListener axladiesMarker, 'click', ->
                if myjson[3].description.length > 5
                  infoaxladies.setContent myjson[3].description
                else
                  infoaxladies.setContent myjson[3].title
                infoaxladies.open map, this

# Vasilias Beach Info & Marker
            vasiliasMarker = new google.maps.Marker
                position:vasiliasLocation
                map: map
                icon: beachPin

            infovasilias = new google.maps.InfoWindow()

            google.maps.event.addListener vasiliasMarker, 'click', ->
                if myjson[4].description.length > 5
                  infovasilias.setContent myjson[4].description
                else
                  infovasilias.setContent myjson[4].title
                infovasilias.open map, this

# Tzaneria Beach Info & Marker
            tzaneriaMarker = new google.maps.Marker
                position:tzaneriaLocation
                map: map
                icon: beachPin

            infotzaneria = new google.maps.InfoWindow()

            google.maps.event.addListener tzaneriaMarker, 'click', ->
                if myjson[5].description.length > 5
                  infotzaneria.setContent myjson[5].description
                else
                  infotzaneria.setContent myjson[5].title
                infotzaneria.open map, this

# Kanapitsa Beach Info & Marker
            kanapitsaMarker = new google.maps.Marker
                position:kanapitsaLocation
                map: map
                icon: beachPin

            infokanapitsa = new google.maps.InfoWindow()

            google.maps.event.addListener kanapitsaMarker, 'click', ->
                if myjson[6].description.length > 5
                  infokanapitsa.setContent myjson[6].description
                else
                  infokanapitsa.setContent myjson[6].title
                infokanapitsa.open map, this

# Kolios Beach Info & Marker
            koliosMarker = new google.maps.Marker
                position:koliosLocation
                map: map
                icon: beachPin

            infokolios = new google.maps.InfoWindow()

            google.maps.event.addListener koliosMarker, 'click', ->
                if myjson[7].description.length > 5
                  infokolios.setContent myjson[7].description
                else
                  infokolios.setContent myjson[7].title
                infokolios.open map, this

# Troulos Beach Info & Marker
            troulosMarker = new google.maps.Marker
                position:troulosLocation
                map: map
                icon: beachPin

            infotroulos = new google.maps.InfoWindow()

            google.maps.event.addListener troulosMarker, 'click', ->
                if myjson[8].description.length > 5
                  infotroulos.setContent myjson[8].description
                else
                  infotroulos.setContent myjson[8].title
                infotroulos.open map, this

# Ampelakia Beach Info & Marker
            ampelakiaMarker = new google.maps.Marker
                position:ampelakiaLocation
                map: map
                icon: beachPin

            infoampelakia = new google.maps.InfoWindow()

            google.maps.event.addListener ampelakiaMarker, 'click', ->
                if myjson[9].description.length > 5
                  infoampelakia.setContent myjson[9].description
                else
                  infoampelakia.setContent myjson[9].title
                infoampelakia.open map, this

# Mikri Banana Beach Info & Marker
            mikriBananaMarker = new google.maps.Marker
                position:mikriBananaLocation
                map: map
                icon: beachPin

            infomikriBanana = new google.maps.InfoWindow()

            google.maps.event.addListener mikriBananaMarker, 'click', ->
                if myjson[10].description.length > 5
                  infomikriBanana.setContent myjson[10].description
                else
                  infomikriBanana.setContent myjson[10].title
                infomikriBanana.open map, this

# Kryfi Ammos Beach Info & Marker
            kryfiAmmosMarker = new google.maps.Marker
                position:kryfiAmmosLocation
                map: map
                icon: beachPin

            infokryfiAmmos = new google.maps.InfoWindow()

            google.maps.event.addListener kryfiAmmosMarker, 'click', ->
                if myjson[11].description.length > 5
                  infokryfiAmmos.setContent myjson[11].description
                else
                  infokryfiAmmos.setContent myjson[11].title
                infokryfiAmmos.open map, this

# Agiaeleni Beach Info & Marker
            agiaEleniMarker = new google.maps.Marker
                position:agiaEleniLocation
                map: map
                icon: beachPin

            infoagiaEleni = new google.maps.InfoWindow()

            google.maps.event.addListener agiaEleniMarker, 'click', ->
                if myjson[12].description.length > 5
                  infoagiaEleni.setContent myjson[12].description
                else
                  infoagiaEleni.setContent myjson[12].title
                infoagiaEleni.open map, this

# Mandraki Beach Info & Marker
            mandrakiMarker = new google.maps.Marker
                position:mandrakiLocation
                map: map
                icon: beachPin

            infomandraki = new google.maps.InfoWindow()

            google.maps.event.addListener mandrakiMarker, 'click', ->
                if myjson[13].description.length > 5
                  infomandraki.setContent myjson[13].description
                else
                  infomandraki.setContent myjson[13].title
                infomandraki.open map, this

# Elia Beach Info & Marker
            eliaMarker = new google.maps.Marker
                position:eliaLocation
                map: map
                icon: beachPin

            infoelia = new google.maps.InfoWindow()

            google.maps.event.addListener eliaMarker, 'click', ->
                if myjson[14].description.length > 5
                  infoelia.setContent myjson[14].description
                else
                  infoelia.setContent myjson[14].title
                infoelia.open map, this

# Aggistros Beach Info & Marker
            aggistrosMarker = new google.maps.Marker
                position:aggistrosLocation
                map: map
                icon: beachPin

            infoaggistros = new google.maps.InfoWindow()

            google.maps.event.addListener aggistrosMarker, 'click', ->
                if myjson[15].description.length > 5
                  infoaggistros.setContent myjson[15].description
                else
                  infoaggistros.setContent myjson[15].title
                infoaggistros.open map, this

# Kastro Beach Info & Marker
            kastroMarker = new google.maps.Marker
                position:kastroLocation,
                map: map,
                icon: beachPin

            infokastro = new google.maps.InfoWindow()

            google.maps.event.addListener kastroMarker, 'click', ->
                if myjson[16].description.length > 5
                  infokastro.setContent myjson[16].description
                else
                  infokastro.setContent myjson[16].title
                infokastro.open map, this


# Lalaria Beach Info & Marker
            lalariaMarker = new google.maps.Marker
                position:lalariaLocation
                map: map
                icon: beachPin

            infolalaria = new google.maps.InfoWindow()

            google.maps.event.addListener lalariaMarker, 'click', ->
                if myjson[17].description.length > 5
                  infolalaria.setContent myjson[17].description
                else
                  infolalaria.setContent myjson[17].title
                infolalaria.open map, this


# Aselinos Beach Info & Marker
            aselinosMarker = new google.maps.Marker
                position:aselinosLocation
                map: map
                icon: beachPin

            infoaselinos = new google.maps.InfoWindow()

            google.maps.event.addListener aselinosMarker, 'click', ->
                if myjson[18].description.length > 5
                  infoaselinos.setContent myjson[18].description
                else
                  infoaselinos.setContent myjson[18].title
                infoaselinos.open map, this



# Vromolimnos Beach Info & Marker
            vromolimnosMarker = new google.maps.Marker
                position:vromolimnosLocation
                map: map
                icon: beachPin

            infovromolimnos = new google.maps.InfoWindow()

            google.maps.event.addListener vromolimnosMarker, 'click', ->
                if myjson[19].description.length > 5
                    infovromolimnos.setContent myjson[19].description
                else
                    infovromolimnos.setContent myjson[19].title
                infovromolimnos.open map, this

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
