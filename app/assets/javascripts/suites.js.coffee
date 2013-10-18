window.BelvedereGit ||= {}
class BelvedereGit.suites extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this
        
    index: () ->
        $('.collapse-link').click ->
            collapsible_id = $(this).attr('href').replace(/.*#{1}/,'#')
            $collapsible = $(collapsible_id)
            
            if $collapsible.hasClass('open')
                $collapsible.slideUp(200).removeClass('open')
            else
                $collapsible.parent().siblings().find('.collapsible').slideUp(200).removeClass('open')
                $collapsible.slideDown(200).addClass('open')
            
            false
