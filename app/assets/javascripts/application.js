// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
	var bind_choice = function(){
		$ctx = $(this).parent().parent();
		$('textarea', $ctx).attr('id').search(/(\d+)(?=_title)/gi);
		var index = RegExp.$1;
		var new_id = new Date().getTime();
		var content = $('#choice_template').html().replace(/\d+(?=(\]\[|_)choices_attributes(\]|_))/gi, index).replace(/new_placeholder/gi, new_id);
		$(".choices>div", $ctx).append(content);
		$(".questions label>.delete").click(delete_op);
	};
	
	var delete_op = function(){
		$(this).prev("input[type=hidden]").val(1);
	  	$(this).parentsUntil(".group").parent().hide(100);
	};
	
	$('.survey > button.title').click(function(){
//		$('#question_template>div').clone().appendTo(".questions");
		var new_id = new Date().getTime();
		$('.questions').append($('#question_template').html().replace(/new_placeholder/gi, new_id));
		$(".choices > button.title").click(bind_choice);		
	});
	
	$(".choices > button.title").click(bind_choice);	
	$(".questions label>.delete").click(delete_op);
});
