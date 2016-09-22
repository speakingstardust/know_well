# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
	jigs = $(".jig_select").html()
	$('.customer_select').change ->
		customer = $('.customer_select :selected').text()
		options = $(jigs).filter("optgroup[label='#{customer}']").html()
		if options 
			$('.jig_select').html(options)
		else 
			$('.jig_select').empty()