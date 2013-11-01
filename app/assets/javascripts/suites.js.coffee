window.BelvedereGit ||= {}
class BelvedereGit.suites extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
        
    index: () ->
        # Vertically aligns missing images according to current gallery height
        missingImgReposition = ->
            $('.gallery.visible .item img[src*="missing"]').each ->
                $(this).css('margin-top', parseInt(($('.image-gallery').height() - $(this).height()) / 2))
        
        # Vertically aligns the 'previous' and 'next' buttons according to current gallery height
        galleryControlsReposition = ->
            $('.gallery.visible .carousel-control').each ->
                $(this).css('top', parseInt($('.image-gallery').height() / 2))
        
        # Initializes gallery animation and attaches fancybox-related events
        galleryCarouselInit = (gal) ->
            if gal.find('.item').length > 1
                gal.addClass('carousel').addClass('slide').carousel({interval: 10000}).on('slide', (e) ->
                    $img = gal.find('.item.active img')
                    $img.width(gal.width())
                ).on('slid', (e) ->
                    if window.fancyClick == false
                        current_pos = gal.find('.carousel-inner .active').index()
                        $.fancybox.pos(current_pos)
                    else
                        e.stopImmediatePropagation()
                        window.fancyClick = false
                )
        
        # Image gallery height is set to the minimum height of its contained images
        # Contained elements are also repositioned accordingly
        setGalleryHeight = ->
            min = parseInt($('.image-gallery').css('max-height'))
            $('.gallery.visible .item').each ->
                new_height = window.calculateNewImageHeight($(this).find('img'), $('.gallery.visible').width())
                if new_height < min
                    min = new_height
            $('.image-gallery').css('height', min)
            
            missingImgReposition()
            galleryControlsReposition()
        
        # Prepares gallery for display
        galleryPrepare = ->
            $gal = $('.gallery.visible')
            galleryCarouselInit($gal)
            setGalleryHeight()
        
        galleryPrepare()
        
        $(window).load ->
            galleryPrepare()
        
        $(window).resize ->
            $('.gallery.visible .item.active img').width($('.gallery.visible').width())
            setGalleryHeight()
        
        # Define custom event that fires when one of the collapsible list items is opened
        collapsibleEvent = jQuery.Event("collapsibleEvent")
        
        $container = $('.scrollable .mCSB_container')
        
        link_offs = {}
        $('.collapse-link').each ->
            $parent = $(this).parent()
            link_offs["link_#{$parent.index()}"] = - ($parent.index() * ($parent.height() + parseInt($parent.css('margin-top')) + parseInt($parent.css('margin-bottom'))))
        
        # Identifies whether somebody clicked on the 'next' or 'previous' fancybox arrows
        window.fancyClick = false
        
        # What happens when we click on one of the collapsible list items
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
                
                galleryCarouselInit($gallery)
                
                $collapsible.slideDown(200, (->
                        $(this).addClass('open').trigger(collapsibleEvent)
                    )
                )
                
                setGalleryHeight()
            
            false

        # Triggers when fancybox is opened and its 'next' and 'previous' controls are used
        $('a.fancybox').on 'click', (e) ->
            $('#fancybox-left').on 'click', (e) ->
                window.fancyClick = true
            $('#fancybox-right').on 'click', (e) ->
                window.fancyClick = true

        # Scrolls scrollable area accordingly when our custom collapsible event is fired
        $('.collapsible').bind 'collapsibleEvent', (e) ->
            link_id = $(this).prev().attr('id')
            
            list_container_height = $(this).closest('.mCSB_container').height()
            scrollable_height = $(this).closest('.scrollable').height()
            
            if list_container_height > scrollable_height
                $container.css('top', link_offs[link_id])
