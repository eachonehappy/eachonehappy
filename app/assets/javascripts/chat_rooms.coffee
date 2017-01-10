# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

href = window.location.pathname
$page_name = href.split('/') 
$chat_room = $page_name[1]
$chat_room_id = $page_name[2]
if ($chat_room == "chat_rooms") && ($chat_room_id % 1 == 0)
	$(document).ready ->
	  currentUrl = window.location.href
	  chat_roomID = currentUrl.substr(currentUrl.lastIndexOf('/') + 1)
	  setInterval (->
	    $.ajax
	      type: 'GET'
	      url: '/chat_rooms/' + chat_roomID + '/get_messages'
	    return
	  ), 5000
	  return