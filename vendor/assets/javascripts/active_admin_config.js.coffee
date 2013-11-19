#update days field on dates change

$(document).ready ->
    if !($('#reservation_arrival').parent().hasClass('error') || $('#reservation_departure').parent().hasClass('error'))
        durationFormat()
    else
        $('#reservation_days').val('')

    $('#reservation_arrival').on('change', (e) ->
        $arrival = $('#reservation_arrival').val()
        $departure = $('#reservation_departure').val()
        
        if $arrival != ''
            if calculateDuration("#{(new Date()).getFullYear()}-#{(new Date()).getMonth() + 1}-#{(new Date()).getDate()}", $arrival, '') < 0
                $('#reservation_arrival').parent().addClass('error')
            else
                $('#reservation_arrival').parent().removeClass('error')
            
            if $departure != ''
                if calculateDuration("#{(new Date()).getFullYear()}-#{(new Date()).getMonth() + 1}-#{(new Date()).getDate()}", $departure, '') > 0
                    $('#reservation_departure').parent().removeClass('error')
                
                calculateDuration($arrival, $departure, '#reservation_days')
                durationFormat()
        else
            $('#reservation_days').val('')
    )
    
    $('#reservation_departure').on('change', (e) ->
        $arrival = $('#reservation_arrival').val()
        $departure = $('#reservation_departure').val()
        
        if $departure != ''
            if calculateDuration("#{(new Date()).getFullYear()}-#{(new Date()).getMonth() + 1}-#{(new Date()).getDate()}", $departure, '') <= 0
                $('#reservation_departure').parent().addClass('error')
            else
                $('#reservation_departure').parent().removeClass('error')
            
            if $arrival != ''
                if calculateDuration("#{(new Date()).getFullYear()}-#{(new Date()).getMonth() + 1}-#{(new Date()).getDate()}", $arrival, '') >= 0
                    $('#reservation_arrival').parent().removeClass('error')
                
                calculateDuration($arrival, $departure, '#reservation_days')
                durationFormat()
        else
            $('#reservation_days').val('')
    )

calculateDuration = (arrival, departure, output) ->
    arrival_date = new Date(arrival)
    departure_date = new Date(departure)
    
    if output != ''
        $(output).val(new Date(departure_date - arrival_date)/1000/60/60/24)
    else
        new Date(departure_date - arrival_date)/1000/60/60/24

durationFormat = ->
    if $('#reservation_days').val() > 0 && $('#reservation_days').val() <= 180
        $('#reservation_days').parent().removeClass('error')
    else if $('#reservation_days').val() == ''
        $('#reservation_arrival').parent().removeClass('error')
        $('#reservation_departure').parent().removeClass('error')
    else
        $('#reservation_days').parent().addClass('error')
