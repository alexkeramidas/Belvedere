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
        
        setGalleryHeight = ->
            min = parseInt($('.image-gallery').css('max-height'))
            $('.gallery.visible .item').each ->
                if $(this).height() < min
                    min = $(this).height()
            $('.image-gallery').css('height', min)
            
            missingImgReposition()
            galleryControlsReposition()
        
        $(window).load ->
            setGalleryHeight()
        
        $(window).resize ->
            setGalleryHeight()
        
        collapsibleEvent = jQuery.Event("collapsibleEvent")
        
        $container = $('.scrollable .mCSB_container')
        
        link_offs = {}
        $('.collapse-link').each ->
            link_offs[$(this).attr('id')] = - $("##{$(this).attr('id')}")[0].offsetTop
        
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
                
                if $gallery.find('.item').length > 1
                    $gallery.addClass('carousel').addClass('slide').carousel({interval: 10000}).on 'slid', (e) ->
                        current_pos = $('.gallery.visible .carousel-inner .active').index()
                        $.fancybox.pos(current_pos)
                $collapsible.slideDown(200, (->
                        $(this).addClass('open').trigger(collapsibleEvent)
                    )
                )
                
                setGalleryHeight()
            
            false

        $('.collapsible').bind 'collapsibleEvent', (e) ->
            link_id = $(this).prev().attr('id')
            $container.css('top', link_offs[link_id])
