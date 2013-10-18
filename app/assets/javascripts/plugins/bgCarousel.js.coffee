(($) ->
    $.fn.extend bgCarousel: (options) ->
        defaults =
            backgroundElem: '.bg-img'
            controlsContainer: '#bg-slider-controls'
            backgroundPrefix: '#bg'
            controlsPrefix: '#bg-link-'
            zIndexTop: -1
            zIndexBottom: -2

        options = $.extend(defaults, options)
    
        @each ->
            o = options
            obj = $(this)
            $items = $(o.backgroundElem, obj)
            
            
            # Full-page carousel methods
            
            bgAnimPrepare = (id_next) ->
                $items.stop()
                $items.not('.active').css('opacity', 0).css('display', 'none').css('z-index', o.zIndexBottom)
                $items.filter('.active').css('opacity', 1).css('display', 'block').css('z-index', o.zIndexTop)
                $items.filter("#{o.backgroundPrefix}#{id_next}").css('opacity', 1).css('display', 'block')
            
            bgAnimFade = (id_next, ms) ->
                bgAnimPrepare(id_next)
                $prevElem = $items.filter('.active')
                
                $prevElem.removeClass('active')
                $items.filter("#{o.backgroundPrefix}#{id_next}").css('display', 'block')
                
                $("#{o.controlsContainer} a").removeClass('active')
                $("#{o.controlsPrefix}#{id_next}").addClass('active')
                
                $items.filter("#{o.backgroundPrefix}#{id_next}").addClass('active')
                
                $.when($prevElem.fadeOut ms).done (->
                    $prevElem.css('opacity', 0)
                )
            
            bgAnimAuto = ->
                if $items.length > 1
                    window.bgInterval = setInterval (->
                        bg_count = $items.length
                        $bg_prev = $items.filter('.active')
                        $bg_next = $bg_prev.next("#{o.backgroundElem}")
                        
                        if $bg_prev.attr('id') == "#{o.backgroundPrefix.replace('#','')}#{bg_count}"
                            bg_next_id = 1
                        else
                            bg_next_id = parseInt($bg_next.attr('id').replace("#{o.backgroundPrefix.replace('#','')}", ''))
                        
                        bgAnimFade bg_next_id, 4000
                    ), 6000
            
            bgAnimManual = (id) ->
                bgAnimClear()
                bgAnimFade(id, 1000)
            
            bgAnimClear = ->
                clearInterval(window.bgInterval)
            
            
            # Image preloader
            
            obj.waitForImages
                finished: ->
                    $("#{o.controlsContainer}").show()
                    
                    
                    # Full-page carousel callbacks
                    
                    bgAnimClear()
                    bgAnimAuto()
                    
                    $("#{o.controlsContainer} a").click ->
                        if $(this).hasClass('')
                            bg_next = parseInt($(this).attr('href').replace('#',''))
                            bgAnimManual(bg_next)
                        false
                waitForAll: true
) jQuery
