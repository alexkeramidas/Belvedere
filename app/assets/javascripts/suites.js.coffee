window.BelvedereGit ||= {}
class BelvedereGit.suites extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
        
    index: () ->
        missingImgReposition = ->
            $('.gallery.visible .item img[src*="missing"]').each ->
                $(this).css('margin-top', parseInt(($('.image-gallery').height() - $(this).height()) / 2))
                
        galleryControlsReposition = ->
            $('.gallery.visible .carousel-control').each ->
                $(this).css('top', parseInt($('.image-gallery').height() / 2))
        
        galleryCarouselStart = (gal) ->
            if gal.find('.item').length > 1
                gal.addClass('carousel').addClass('slide').carousel({interval: 10000}).on 'slid', (e) ->
                    if window.fancyClick == false
                        current_pos = $('.gallery.visible .carousel-inner .active').index()
                        $.fancybox.pos(current_pos)
                    else
                        window.fancyClick = false
        
        setGalleryHeight = ->
            min = parseInt($('.image-gallery').css('max-height'))
            $('.gallery.visible .item').each ->
                new_height = window.calculateNewImageHeight($(this).find('img'), $('.gallery.visible').width())
                if new_height < min
                    min = new_height
            $('.image-gallery').css('height', min)
            
            missingImgReposition()
            galleryControlsReposition()
        
        $(window).load ->
            $gal = $('.gallery.visible')
            galleryCarouselStart($gal)
            setGalleryHeight()
        
        $(window).resize ->
            setGalleryHeight()
        
        collapsibleEvent = jQuery.Event("collapsibleEvent")
        
        $container = $('.scrollable .mCSB_container')
        
        link_offs = {}
        $('.collapse-link').each ->
            link_offs[$(this).attr('id')] = - $("##{$(this).attr('id')}")[0].offsetTop
        
        window.fancyClick = false
        
        $('.collapse-link').click ->
            $link = $(this)
            collapsible_id = $(this).attr('href').replace(/.*#{1}/,'#')
            $collapsible = $(collapsible_id)
            $gallery = $($(this).data('gal'))
                
            $('.collapse-link').removeClass('active')
            $link.addClass('active')
            
            if $collapsible.hasClass('open')
                $collapsible.removeClass('open').slideUp(200)
            else
                $collapsible.parent().siblings().find('.collapsible').slideUp(200).removeClass('open')
                
                $('.gallery').each ->
                    $(this).removeClass('visible')
                    if $(this).hasClass('carousel')
                        $(this).removeClass('carousel').removeClass('slide').carousel('pause')
                
                $gallery.addClass('visible')
                
                galleryCarouselStart($gallery)
                
                $collapsible.slideDown(200, (->
                        $(this).addClass('open').trigger(collapsibleEvent)
                    )
                )
                
                setGalleryHeight()
            
            false

        $('a.fancybox').on 'click', (e) ->
            $('#fancybox-left').on 'click', (e) ->
                window.fancyClick = true
            $('#fancybox-right').on 'click', (e) ->
                window.fancyClick = true

        $('.collapsible').bind 'collapsibleEvent', (e) ->
            link_id = $(this).prev().attr('id')
            $container.css('top', link_offs[link_id])
