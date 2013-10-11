window.BelvedereGit ||= {}
class BelvedereGit.pages extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        this


    home: () ->
        changeBackground = ->
            window.bgoffs = 0  if window.bgoffs >= bg_list.length
            jQuery('html').css 'background-image', ->
                "url(#{bg_list[window.bgoffs++]})"
