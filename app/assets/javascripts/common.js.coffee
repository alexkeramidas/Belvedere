window.BelvedereGit ||= {}
class BelvedereGit.Base

    # Rails server code can pass in some bootstrap data if necessary, which we will save off for use anywhere on the client
    constructor: (bootstrap_data={}) ->
        @bd = bootstrap_data
        # Put your general code here. Don't worry about document ready since this
        # code will only be called once the document is ready
        
        
        # Custom scrollbars for elements with the 'scrollable' class
            
        $(".scrollable").mCustomScrollbar({
            scrollButtons:{
                enable:true
            },
            theme:"dark"
        });
        
        
        # Full-page carousel
        
        bgFade = (id) ->
            bg_count = $('.bg-img').length
            if id == 1
                id_prev = bg_count
            else
                id_prev = id - 1
            $("#bg#{id}.bg-img").fadeIn 4000
            $("#bg#{id_prev}.bg-img").fadeOut 4000
        
        clearInterval(window.bgInterval)
        
        if $('.bg-img').length > 1
            window.bgInterval = setInterval (->
                bg_count = $('.bg-img').length
                bg_prev = $('.bg-img').filter(':visible')
                bg_next = bg_prev.next('.bg-img').attr('id')
                
                if bg_prev.attr('id') == "bg#{bg_count}"
                    bg_next = "bg1"
                
                bg_next_id = parseInt(bg_next.replace('bg',''))
                
                bgFade bg_next_id
            ), 6000


        # MAKE SURE YOU RETURN this
        this
