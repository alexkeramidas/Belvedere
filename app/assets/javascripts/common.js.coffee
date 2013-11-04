window.BelvedereGit ||= {}
class BelvedereGit.Base

    # Rails server code can pass in some bootstrap data if necessary, which we will save off for use anywhere on the client
    constructor: (bootstrap_data={}) ->
        @bd = bootstrap_data
        # Put your general code here. Don't worry about document ready since this
        # code will only be called once the document is ready
        
        
        # Custom scrollbars for elements with the 'scrollable' class
        
        $('.scrollable').mCustomScrollbar({
            mouseWheelPixels: 120,
            scrollInertia: 0,
            scrollButtons: {
                enable: true,
                scrollSpeed: 30,
                scrollAmount: 30
            },
            advanced: {
                autoScrollOnFocus: false,
                updateOnContentResize: true
            },
            theme: 'dark'
        })
        
        # Initialize carousel for elements with the 'carousel' class
        
        $('.carousel').carousel()
        
        # Make certain that fancybox works with turbolinks
        
        $(document).bind 'page:change', ->
            $.fancybox.init()
        
        # Initialize fancybox for links within galleries, that have the 'fancybox' class
        
        $('.gallery a.fancybox').fancybox
            cyclic: true
            autoDimensions: true
            onComplete: ->
                current_img_url = $('#fancybox-content img').attr('src')
                current_img_path = "#{current_img_url.replace(window.location.protocol+'//'+window.location.host, '')}"
                current_offset = $('.gallery.visible .carousel-inner').children().index($("a.fancybox[href*='#{current_img_path}']").parent())
                $.fancybox.current_offs = current_offset
                $('.gallery.visible').carousel(current_offset)
                fancyboxContainersResize()
        
        
        # Custom resizable Fancybox for image galleries
        
        window.calculateImageDisplayRatio = (img) ->
            img_width = img.width()
            img_height = img.height()
            if img_width == 0 || img_height == 0
                img_width = img.attr('data-width')
                img_height = img.attr('data-height')
            img_width / img_height
        
        window.calculateNewImageWidth = (img, h) ->
            calculateImageDisplayRatio(img) * h
        
        window.calculateNewImageHeight = (img, w) ->
            parseInt(w / calculateImageDisplayRatio(img))
        
        fancyboxContainersResize = () ->
            $('#fancybox-overlay').css('width', '100%').css('height', $('body').height())
            $('#fancybox-outer').css('height', 'auto').css('width', 'auto')
            $('#fancybox-wrap').css('width', 'auto').css('height', 'auto')
        
        fancyboxResize = () ->
            new_base_width = $('body').width() - 100
            new_base_height = $('body').height() - 100
            
            img_width = $(".gallery.visible .item").eq($.fancybox.current_offs).find('img').attr('data-width')
            img_height = $(".gallery.visible .item").eq($.fancybox.current_offs).find('img').attr('data-height')
            
            new_width = window.calculateNewImageWidth($($('.collapse-link.active').attr('data-gal')).find('.item.active img'), new_base_height)
            new_height = window.calculateNewImageHeight($($('.collapse-link.active').attr('data-gal')).find('.item.active img'), new_base_width)

            current_width = $('#fancybox-img').width()
            current_height = $('#fancybox-img').height()

            fancyboxContainersResize()
            
            if new_base_width > 20 && new_base_height > 20
                if img_width >= new_base_width && new_height <= new_base_height
                    $('#fancybox-content').css('width', new_base_width).css('height', new_height)
                else if img_height >= new_base_height && new_width <= new_base_width
                    $('#fancybox-content').css('height', new_base_height).css('width', new_width)
        
        $(window).resize ->
            fancyboxResize()


        # MAKE SURE YOU RETURN this
        this
