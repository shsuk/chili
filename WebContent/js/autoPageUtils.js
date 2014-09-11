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
		var type = trg.attr('type');
		if(type=='file' || type=='files'){
			return;
		}
		trg.hide();
		var view = $('.view_control',trg.parent());
		var val = $('.control',trg).val();
		if(val==''){
			view.html('&nbsp;');
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
//조회와 수정 모드 전환 처리를 위한 콘트롤을 생성 한다.
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
			var view = $('<span class="view_control"></span>');
			var val = $('.control', fld).val();
			if(val && val!=''){
				view.text(val);	
			}else{
				view.html($('.control', fld).html());
			}
			view.css({width: width, disply:'inline', overflow:'hidden', 'margin-right':'8px'});
			ctl.hide();
			fld.append(view);
		}
	}
	
}
//사용자정의 UI 디자인을 적용한다.
function showRelocationUi(){
	var auto_generated_uI = $('#auto_generated_uI');
	var fields = $('.to_field', auto_generated_uI);
	//드롭영역에 필드가 있으면 필드를 추가 하고 없으면 삭제한다.
	for(var i=0; i<fields.length; i++){
		fldArea = $(fields[i]);
		var td = fldArea.parent();

		var flds = $('.drg', fldArea);
		//필드를 추가 한다
		for(var n=0; n<flds.length;n++){
			var fld = $(flds[n]);
			var tit = fld.attr('title');
			var type = fld.attr('type');
			
			td.append($('.'+type+'s[name='+tit+']'));
		}
		//없으면 삭제한다.
		if(flds.length<1){
			td.remove();
			//td.hide();			
		}
	}
	
	fields.hide();
	$('.drg', auto_generated_uI).hide();
	auto_generated_uI.show();
	//$('#default_auto_generated_uI').show();
}
function sowDefaultUi(){
	$('#auto_generated_uI').show();
	$('#default_auto_generated_uI').show();

}

function addAttach(id){
	$('#attachs_'+id).append($('.attachTpl_'+id).clone().removeClass('attachTpl_'+id).show());
}

function delFile(file_id){
	$('#'+file_id).val(file_id);
	$('.'+file_id).hide();
}

function form_submit(){	
	var url = 'action/bit.sh';
	var form = $('#body_form');
	//폼 정합성 체크
	if(!valid(form)){
		return;
	}
	//첨부파일이 있는 폼 처리
	if($('input[type=file]',form).length>0){
		attach_form_submit(url, form);
		return;
	}

	var formData =$(form).serializeArray();		

	$.post(url, formData, function(response, textStatus, xhr){

		var data = $.parseJSON(response);
		
		if(data.success){
			document.location.href='list.jsp';
		}else{
			alert("처리하는 중 오류가 발생하였습니다. \n문제가 지속되면 관리자에게 문의 하세요.\n" + data.message);					
		}
		
	});
}
function attach_form_submit(url, form){
	var fd = new FormData(form[0]);
	//FormData를 지원하지 않는 경우 처리
	if(fd==null){
	    $('#msg').text('업로드 정보 없습');
	    form.attr('target','submit_frame');
	    form.submit();
	    return;
	}
	//FormData를 지원하는 경우 처리
	var xhr = new XMLHttpRequest();
	 
	xhr.upload.addEventListener("progress", function(e, a1, a2) {
	       if (e.lengthComputable) {
	            var percentage = Math.round((e.loaded * 100) / e.total);
	           // $("#msg").text( ' - ' + percentage + '%');
	        	$('#msg').animate({width: percentage + '%'},70);	        }
	    }, false
	);
	
	xhr.onreadystatechange = function() { 
	    if (xhr.readyState == 4 && xhr.status == 200) {
	        //alert(xhr.responseText);
	    }
	};
	
	xhr.upload.addEventListener("load", function(e){
	       $('#msg').text('전송완료');
	    }, false
	);
	     
	xhr.open("POST", url);
	      
	xhr.send(fd);
	
}