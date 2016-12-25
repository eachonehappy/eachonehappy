# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ajax:success', 'a.vote', (status,data,xhr)->
  $(".votes-count[data-id=#{data.id}]").text data.count

  $("a.vote[data-id=#{data.id}]").each ->
    $a = $(this)
    href = $a.attr 'href'
    text = $a.text()
    $a.text($a.data('toggle-text')).attr 'href', $a.data('toggle-href')
    $a.data('toggle-text', text).data 'toggle-href', href
    return

  return

$(document).on 'ajax:success', 'a.follow', (status,data,xhr)->
  $(".follow-count[data-id=#{data.id}]").text data.count

  $("a.follow[data-id=#{data.id}]").each ->
    $a = $(this)
    href = $a.attr 'href'
    text = $a.text()
    $a.text($a.data('toggle-text')).attr 'href', $a.data('toggle-href')
    $a.data('toggle-text', text).data 'toggle-href', href
    return

  return  