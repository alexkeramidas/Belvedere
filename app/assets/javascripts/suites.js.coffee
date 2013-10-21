window.BelvedereGit ||= {}
class BelvedereGit.suites extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
        
    index: () ->
        collapsibleEvent = jQuery.Event("collapsibleEvent")
        
        $container = $('.scrollable .mCSB_container')
        
        link_offs = {}
        $('.collapse-link').each ->
            link_offs[$(this).attr('id')] = - $("##{$(this).attr('id')}")[0].offsetTop
        
        $('.collapse-link').click ->
            collapsible_id = $(this).attr('href').replace(/.*#{1}/,'#')
            $collapsible = $(collapsible_id)
            
            if $collapsible.hasClass('open')
                $collapsible.removeClass('open').slideUp(200)
            else
                $collapsible.parent().siblings().find('.collapsible').slideUp(200).removeClass('open')
                $collapsible.slideDown(200, (->
                        $(this).addClass('open').trigger(collapsibleEvent)
                    )
                )
            
            false

        $('.collapsible').bind 'collapsibleEvent', (e) ->
            link_id = $(this).prev().attr('id')
            $container.css('top', link_offs[link_id])
