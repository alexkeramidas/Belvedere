#= require active_admin/base
#= require tinymce

$(document).ready ->
    tinyMCE.init
        plugins: 'code image'
        mode: 'textareas'
        theme : 'modern'
        width: '78%'
