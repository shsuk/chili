$(function() {
	$(document).on('click', '.view_control', function(e){
		if(!$.isEditMode){
			return;
		}
		var trg = $(e.currentTarget);
		trg.hide();
		$('.in_control',trg.parent()).show().focus();
	});
	$(document).on('change', '.in_control', function(e){
		var trg = $(e.currentTarget);
		trg.hide();
		var view = $('.view_control',trg.parent());
		var val = $('.control',trg).val();
		if(val==''){
			view.html('&nbsp;')
		}else{
			view.text(val);
		}
		
		view.show();
	});
});

function edit(){
	$('.view_control').hide();
	$('.in_control').show();
	$('#save_btn').show();
	$('#edit_btn').hide();
	$.isEditMode = true;
}

function initAutoPage(){
	$['isEditMode'] = false;
	
	var fields = $('.field');
	
	for(var i=0; i< fields.length; i++){
		var fld = $(fields[i]);
		var ctl = $('.in_control', fld);
		
		if(ctl.length>0){
			//var width = ctl.outerWidth() + 'px';
			var width ='95%';
			//var height = ctl.outerHeight() + 'px';
			var view = $('<div class="view_control"></div>');
			view.text($('.control', fld).val());
			view.css({width: width, disply:'inline', overflow:'hidden', 'margin-right':'8px'});
			ctl.hide();
			fld.append(view);
		}
	}
	
}


function form_submit(){	
	var form = $('#main_form');
	//폼 정합성 체크
	if(!valid(form)){
		return;
	}

	var formData =$(form).serializeArray();		
	var url = form.attr('action');

	$.post(url, formData, function(response, textStatus, xhr){

		var data = $.parseJSON(response);
		
		if(data.success){
			document.location.href='list.jsp';
		}else{
			alert("처리하는 중 오류가 발생하였습니다. \n문제가 지속되면 관리자에게 문의 하세요.\n" + data.message);					
		}
		
	});
}