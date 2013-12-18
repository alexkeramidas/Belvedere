#= require ./common

window.BelvedereGit ||= {}
class BelvedereGit.articles extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
    
    index: () ->
        initializeContainers = ->
            $('#page-content').removeAttr('style')
            $('.articles .wrapper').removeAttr('style')
            $('.articles .wrapper .content').removeAttr('style')
        
        initializeContainers()
        
        # Make certain that each article container's style attribute gets removed when a turbolinks
        # page change occurs.
        $(document).bind 'page:change', ->
            initializeContainers()
        
        $(window).load ->
            initializeContainers()
        
        $(window).resize ->
            initializeContainers()
        
    show: () ->
        resizeContainer = ->
            $('.scroll-wrap > .mCustomScrollbar').removeClass('scrollable')
            
            $header = $('.articles h1')
            
            $('#page-content').css('height', $('#page-wrapper').height())
            
            articles_container_new_height = $('#page-wrapper').height() - $('#top-menu').height() - $('#bottom-menu').height() - parseInt($('.articles').css('padding-top')) - parseInt($('.articles').css('padding-bottom'))
            header_total_height = $header.height() + parseInt($header.css('padding-top')) + parseInt($header.css('padding-bottom')) + parseInt($header.css('margin-top')) + parseInt($header.css('margin-bottom')) + parseInt($header.css('border-top-width')) + parseInt($header.css('border-bottom-width'))
            wrapper_new_height = articles_container_new_height - header_total_height
            
            $('.articles .wrapper').css('height', wrapper_new_height)
            $('.articles .wrapper .content').css('height', wrapper_new_height - 70)
                
            $('.scroll-wrap > .mCustomScrollbar').addClass('scrollable')
            $('.scrollable').mCustomScrollbar('update')
        
        resizeContainer()
        
        # Make certain that the article container gets resized properly when a turbolinks
        # page change occurs.
        $(document).bind 'page:change', ->
            resizeContainer()
        
        $(window).load ->
            resizeContainer()
        
        $(window).resize ->
            resizeContainer()
