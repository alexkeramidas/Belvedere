#= require active_admin/base
#= require rich
#= require rich_config

#update days field on dates change
$(document).ready ->
    $("#reservation_arrival").change ->
      $arrival = new Date($('#reservation_arrival').val())
      $departure = new Date($('#reservation_departure').val())
      $('#reservation_days').val(new Date($departure - $arrival)/1000/60/60/24 - 1)
    $("#reservation_departure").change ->
      $arrival = new Date($('#reservation_arrival').val())
      $departure = new Date($('#reservation_departure').val())
      $('#reservation_days').val(new Date($departure - $arrival)/1000/60/60/24 - 1)