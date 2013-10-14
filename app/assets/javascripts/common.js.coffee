window.BelvedereGit ||= {}
class BelvedereGit.Base

    # Rails server code can pass in some bootstrap data if necessary, which we will save off for use anywhere on the client
    constructor: (bootstrap_data={}) ->
        @bd = bootstrap_data
        # Put your general code here. Don't worry about document ready since this
        # code will only be called once the document is ready
        
        
        # Custom scrollbars for elements with the 'scrollable' class
            
        $(".scrollable").mCustomScrollbar({
            scrollButtons:{
                enable:true
            },
            theme:"dark"
        });
        
        
        # Full-page carousel
        
        bgAnimPrepare = (id_next) ->
            $('.bg-img').stop()
            $('.bg-img').not('.active').css('opacity', 0).css('display', 'none').css('z-index', -2)
            $('.bg-img.active').css('opacity', 1).css('display', 'block').css('z-index', -1)
            $("#bg#{id_next}.bg-img").css('opacity', 1).css('display', 'block')
        
        bgAnimFade = (id_next, ms) ->
            bgAnimPrepare(id_next)
            $prevElem = $(".bg-img.active")
            
            $prevElem.removeClass('active')
            $("#bg#{id_next}.bg-img").css('display', 'block')
            
            $("#bg-slider-controls a").removeClass('active')
            $("#bg-link-#{id_next}").addClass('active')
            
            $.when($prevElem.fadeOut ms).done (->
                $prevElem.css('opacity', 0)
                $("#bg#{id_next}.bg-img").addClass('active')
            )
        
        bgAnimAuto = ->
            if $('.bg-img').length > 1
                window.bgInterval = setInterval (->
                    bg_count = $('.bg-img').length
                    $bg_prev = $('.bg-img.active')
                    $bg_next = $bg_prev.next('.bg-img')
                    
                    if $bg_prev.attr('id') == "bg#{bg_count}"
                        bg_next_id = 1
                    else
                        bg_next_id = parseInt($bg_next.attr('id').replace('bg', ''))
                    
                    bgAnimFade bg_next_id, 4000
                ), 6000
        
        bgAnimManual = (id) ->
            bgAnimClear()
            bgAnimFade(id, 1000)
        
        bgAnimClear = ->
            clearInterval(window.bgInterval)
        
        bgAnimClear()
        bgAnimAuto()
        
        $('#bg-slider-controls a').click ->
            if $(this).hasClass('')
                bg_next = parseInt($(this).attr('href').replace('#',''))
                bgAnimManual(bg_next)
            false


        # MAKE SURE YOU RETURN this
        this
