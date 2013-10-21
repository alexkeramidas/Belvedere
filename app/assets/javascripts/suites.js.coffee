window.BelvedereGit ||= {}
class BelvedereGit.suites extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
        
    index: () ->
        
        collapsibleEvent = jQuery.Event("collapsibleOpened")
        
        window.link_offs = {}
        $('.collapse-link').each ->
            window.link_offs[$(this).attr('id')] = - $("##{$(this).attr('id')}")[0].offsetTop
        
        $('.collapse-link').click ->
            collapsible_id = $(this).attr('href').replace(/.*#{1}/,'#')
            $collapsible = $(collapsible_id)
            
            if $collapsible.hasClass('open')
                $collapsible.slideUp(200).removeClass('open')
            else
                $collapsible.parent().siblings().find('.collapsible').slideUp(200).removeClass('open')
                $collapsible.slideDown(200).trigger(collapsibleEvent).addClass('open')
            
            false

        $('.collapsible').bind 'collapsibleOpened', (e) ->
            link_id = $(this).prev().attr('id')
            $container = $('.scrollable .mCSB_container')
            $container.css('top', window.link_offs[link_id])
