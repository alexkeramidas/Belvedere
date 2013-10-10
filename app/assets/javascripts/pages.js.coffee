window.BelvedereGit ||= {}
class BelvedereGit.pages extends BelvedereGit.Base

    constructor: () ->
        # By calling super, we make sure that all the code in the Base class constructor gets run
        super

        clearInterval(window.bgslide)
        
        $(".scrollable").mCustomScrollbar({
            scrollButtons:{
                enable:true
            },
            theme:"dark"
        });

        this


    home: () ->
        changeBackground = ->
            window.bgoffs = 0  if window.bgoffs >= bg_list.length
            jQuery('html').css 'background-image', ->
                "url(#{bg_list[window.bgoffs++]})"
    
        bg_list = $('html').attr('data-bg').split(',')
        bg = $('html').css('background-image').match(/url\((.*)\)/)[1]
        bg_list.push bg
        window.bgoffs = 0
    
        window.bgslide = setInterval changeBackground, 8000
