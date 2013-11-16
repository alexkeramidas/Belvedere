#= require active_admin/base
#= require rich
#= require rich_config

#update days field on dates change
$(document).ready ->
    daysBorder()

    $('#reservation_arrival').change ->
        $arrival = new Date($('#reservation_arrival').val())
        $departure = new Date($('#reservation_departure').val())
        $('#reservation_days').val(new Date($departure - $arrival)/1000/60/60/24 - 1)
        daysBorder()

    $('#reservation_departure').change ->
        $arrival = new Date($('#reservation_arrival').val())
        $departure = new Date($('#reservation_departure').val())
        $('#reservation_days').val(new Date($departure - $arrival)/1000/60/60/24 - 1)
        daysBorder()


daysBorder = ->
    if($('#reservation_days').val() < 1 || $('#reservation_days').val() > 180 || $('#reservation_days').val() == null || isNaN($('#reservation_days').val()))
            $('#reservation_days').css('border','solid 1px red')
        else
            $('#reservation_days').css('border','')