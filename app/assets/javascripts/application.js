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

if(typeof(current_index) == 'undefined'){
	var current_index = 0;
}

$(function(){
	
	function init_tabs(){
		$(".tabs > ul").addClass("tab-title");
		$(".tabs > div").addClass("tab-content");	
		$('.tab-title').each(function(i, e){
			$(e).find('li').eq(current_index).addClass("selected");	
		});		
	}
	
	init_tabs();
	
});

$(document).ready(function(){
	var bind_choice = function(){
		$ctx = $(this).parent().parent();
		$('textarea', $ctx).attr('id').search(/(\d+)(?=_title)/gi);
		var index = RegExp.$1;
		var new_id = new Date().getTime();
		var content = $('#choice_template').html().replace(/\d+(?=(\]\[|_)choices_attributes(\]|_))/gi, index).replace(/new_placeholder/gi, new_id);
		$(".choices>div", $ctx).append(content);
		$(".questions label>.delete").on('confirm:complete', delete_op);
	};
	
	var delete_op = function(e, sure){
		if(sure){
			$(this).prev("input[type=hidden]").val(1);
			$(this).parentsUntil(".group").parent().hide(100);
		}
	};
	
	$('.survey > button.title').click(function(){
//		$('#question_template>div').clone().appendTo(".questions");
		var new_id = new Date().getTime();
		$('.questions').append($('#question_template').html().replace(/new_placeholder/gi, new_id));
		$(".choices > button.title").on('click', bind_choice);		
	});
	
	$(".choices > button.title").on('click', bind_choice);	
	$(".questions label>.delete").on('confirm:complete', delete_op);
	
	$(':checkbox').click(function(){
		$(this).next(':hidden').val(!$(this).is(':checked'));
	});
	$(':radio').click(function(){
		var name = $(this).attr('name');
		$('input[name="' + name + '"]').each(function(){
			var checked = $(this).is(':checked');			
			$(this).next(':hidden').val(!checked);
		});
	});
	
	//Cancel the beforeunload function.
	$(".survey>.actions>.submit").on('confirm:complete', function(e, sure){
		if(sure){
			$(window).off('.check_leave_page');
//			$(window).on('beforeunload', function(e){
//				//if no data return, this event will not be trigger.
//				e.preventDefault();
//			});
		}
	});
	
	//For user go back the Browser(Safari, Chrome), we should keep the operation record.
	$(':checked').each(function(){
		$(this).next(':hidden').val(false);
	});
	
	//User for every question, ensure they must select one.
	$('form[name=take_survey_form]').submit(function(){
		var accepted = true;
		$('.question_body').each(function(){
			if(!$(':checked', $(this)).length){
				alert('You must select a choice for question:\n ' + $(this).prev('.question_title').text());
				accepted = false;
				return false;
			}
		});
		return accepted;
	});
	
	
	//Make percentage bar.
/*	
	$('div[data-progress]').each(function(i, e){
		var $ctx = $(e), progress = $ctx.data('progress');
		$ctx.css("border", "solid 1px #cccccc").css("height", "10px").css("width", "300px").css("float", "left");
		$('<div></div>').css("width", 300 * progress)
			.css("height", "100%")
			.css("background-color", "#66cc99")
			.css("float", "left")
			.appendTo($ctx);
	});
*/
	
	//We use colorful bar.
	$('.question_body').each(function(){
		$ctx = $(this), colors = ['#ccf066', '#ff9933', '#66cc99', '#6699cc', '#999933', '#333399'], i = 0;
		$('div[data-progress]', $ctx).each(function(i, e){
			var $ctx = $(e), progress = $ctx.data('progress');
			$ctx.css("border", "solid 1px #cccccc").css("height", "10px").css("width", "300px").css("float", "left");
			$('<div></div>').css("width", 300 * progress)
				.css("height", "100%")
				.css("background-color", colors[(i++) % colors.length])
				.css("float", "left")
				.appendTo($ctx);
		});
	});
	
	$('input[data-link]').click(function(){
		window.open($(this).data('link'), '_self');
	});
	
});


//Here script need to move to roles.js.coffee
$(function(){
	$('form[data-remote]').on('ajax:success', function(evt, data, eventName, xhr){
		var status = data.status;
		if(!status){
			alert(data);
		}else if(status == "success"){
			window.location.reload();
		}else if(status == 'nochanged'){
			alert("No data changed.");
		}
	}).on('ajax:error', function(evt, xhr, eventName, statusText){
		alert(statusText);
	});
	
	$('form[name=grant_form] :button').on('click', function(evt){
		$(this).parents('form[name=grant_form]').attr('action', $(this).data('link')).submit();
	});
	
	$(".role:contains('System')").css('background-color', '#ffcc66').css('color', '#006699');
	$(".role:contains('Admin')").css('background-color', '#ff6600').css('color', '#f0f0f0');
	$(".role:contains('Owner')").css('background-color', '#669933').css('color', '#cfcfcf');	
	
	var edit_form_div = $('div.edit_role_form').hide();
	var edit_form = $('form[name=edit_role_form]');
	var items = $('.list_roles .tr>div');
	var links = $('.list_roles a[data-remote]');
		
	links.on('ajax:success', function(ext, data, eventName, xhr){
		$('input[name="role[name]"]', edit_form).val(data.name);
		$('select', edit_form).val(data.group);		
		edit_form.attr('action', '/roles/update/' + data.id);
		
		items.show();
		$(this).parent().parent().hide(100);
		edit_form.show(100).appendTo($(this).parents('.tr'));
	});
});
