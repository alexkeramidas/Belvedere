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


        # MAKE SURE YOU RETURN this
        this
