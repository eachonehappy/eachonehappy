# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'ajax:success', 'a.friend', (status,data,xhr)->
  $(".friends-count[data-id=#{data.id}]").text data.count

  $("a.friend[data-id=#{data.id}]").each ->
    $a = $(this)
    href = $a.attr("disabled", true);
    text = $a.text()
    $a.text($a.data('toggle-text')).attr 'href', $a.data('toggle-href')
    $a.data('toggle-text', text).data 'toggle-href', href
    return

  return

$(document).on 'ajax:success', 'a.acceptfriend', (status,data,xhr)->
  $(".friend-message[data-id=#{data.id}]").text data.count

  $("a.acceptfriend[data-id=#{data.id}]").each ->
    $a = $(this)
    href = $a.attr("disabled", true);
    text = $a.text()
    $a.text($a.data('toggle-text')).attr 'href', $a.data('toggle-href')
    $a.data('toggle-text', text).data 'toggle-href', href
    return

  return  