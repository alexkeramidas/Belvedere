window.BelvedereGit ||= {}
class BelvedereGit.suites extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this

    index: () ->
        updateScrollbarSize = ->
            $('.scrollable').mCustomScrollbar('update')
        
        $(".rooms .scrollable ul li .collapse").on
            hidden: ->
                updateScrollbarSize()
            shown: ->
                updateScrollbarSize()
