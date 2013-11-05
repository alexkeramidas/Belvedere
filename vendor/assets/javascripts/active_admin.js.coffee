#= require active_admin/base
#= require tinymce

$(document).ready ->
    tinyMCE.init
        plugins: 'code image'
        editor_selector : 'myTextEditor'
        theme : 'modern'
        width: '78%'
