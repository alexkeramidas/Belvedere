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
        
        $('.carousel').carousel()
        
        $('a.fancybox').fancybox
            cyclic: true
            autoDimensions: true
            onComplete: ->
                current_img_url = $('#fancybox-content img').attr('src')
                current_img_path = "#{current_img_url.replace(window.location.protocol+'//'+window.location.host, '')}"
                current_offset = $('.gallery.visible .carousel-inner').children().index($("a.fancybox[href*='#{current_img_path}']").parent())
                $('.gallery.visible').carousel(current_offset)
        
        
        # Custom resizable Fancybox
        
        calculateFancyboxDisplayRatio = ->
            $('#fancybox-content').width() / $('#fancybox-content').height()
        
        calculateNewFancyboxWidth = (h) ->
            calculateFancyboxDisplayRatio() * h
        
        $(window).resize ->
            new_height = $('body').height() - 100
            new_width = calculateNewFancyboxWidth(new_height)
            $('#fancybox-overlay').css('height', $('body').height())
            $('#fancybox-content').css('height', new_height).css('width', new_width)
            $('#fancybox-wrap').css('width', new_width + 20)


        # MAKE SURE YOU RETURN this
        this
