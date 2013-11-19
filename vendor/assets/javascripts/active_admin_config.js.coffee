#update days field on dates change

$(document).ready ->
    durationFormat()

    $('#reservation_arrival').on('change', (e) ->
        $arrival = $('#reservation_arrival').val()
        $departure = $('#reservation_departure').val()
        
        if $departure != ''
            calculateDuration($arrival, $departure)
            durationFormat()
    )
    
    $('#reservation_departure').on('change', (e) ->
        $arrival = $('#reservation_arrival').val()
        $departure = $('#reservation_departure').val()
        
        if $arrival != ''
            calculateDuration($arrival, $departure)
            durationFormat()
    )

calculateDuration = (arrival, departure) ->
    arrival_date = new Date(arrival)
    departure_date = new Date(departure)
    
    $('#reservation_days').val(new Date(departure_date - arrival_date)/1000/60/60/24)

durationFormat = ->
    if ($('#reservation_arrival').val() == '' && $('#reservation_departure').val() == '') || ($('#reservation_days').val() > 0 && $('#reservation_days').val() <= 180)
        $('#reservation_days').parent().removeClass('error')
        $('#reservation_arrival').parent().removeClass('error')
        $('#reservation_departure').parent().removeClass('error')
    else
        $('#reservation_days').parent().addClass('error')
        $('#reservation_arrival').parent().addClass('error')
        $('#reservation_departure').parent().addClass('error')
