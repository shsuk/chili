$(function() {
	
	
	$(document).on('click', '.view_control', function(e){
		var trg = $(e.currentTarget);
		var parents = trg.parents();
		for(var i=0; i<parents.length; i++){
			if($(parents[i]).attr('type')=='page'){
				if($(parents[i]).attr('isEditMode')=='true'){
					break;
				}else{
					return;
				}
			}
		}
				
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

function edit(page_id){
	var page = $(page_id);
	$('.view_control', page).hide();
	$('.in_control', page).show();
	$('#save_btn', page).show();
	$('#edit_btn', page).hide();
	page.attr('isEditMode', true);
}
//조회와 수정 모드 전환 처리를 위한 콘트롤을 생성 한다.
function initAutoPage(page_id){
	$(page_id).attr('isEditMode', false);
	
	var fields = $('.field', $(page_id));
	
	for(var i=0; i< fields.length; i++){
		var fld = $(fields[i]);
		var ctl = $('.in_control', fld);
		
		if(ctl.length>0){
			//var width = ctl.outerWidth() + 'px';
			var val;
			var width ='95%';
			//var height = ctl.outerHeight() + 'px';
			var view = $('<span class="view_control"></span>');
			var obj = $('.control', fld);
			if(obj.length>0 && obj.get(0).nodeName =='SELECT'){
				val = $('option:selected',obj).text();
			}else if(obj.length>0 && obj.get(0).nodeName =='RADIO'){
				val = $('label[for='+$('input:checked',ctl).attr('id')+']').text();
			}else{
				val = obj.val();
			}
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
function showRelocationUi(auto_generated_uI_id){
	var auto_generated_uI = $(auto_generated_uI_id);
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
function sowDefaultUi(id){
	$('#auto_generated_uI_'+id).show();
	$('#default_auto_generated_uI_'+id).show();

}

function addAttach(id){
	$('#attachs_'+id).append($('.attachTpl_'+id).clone().removeClass('attachTpl_'+id).show());
}

function delFile(file_id){
	$('#'+file_id).val(file_id);
	$('.'+file_id).hide();
}

function form_submit(page_id){	
	var url = '../at/action.sh';
	var form = $('#body_form', $(page_id));
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
function linkLoad(ui_id, data, selector){

	$(selector ? selector : '#auto_generated_uI_main').load('../unit/_'+ui_id+'.sh',data);
}
function linkPopup(ui_id, data){
	data['ui_id'] = ui_id;
	var dialog = $( "#dialog" );
	if(dialog.length==0){
		dialog = $('<div id="dialog"></div>');
		$('body').append(dialog);
		dialog.dialog({
			autoOpen: false,
			modal: true,
			position:{ my: "top", at: "top", of: '#auto_generated_uI_main' },
			minWidth: 1040, 
			show: {
				 effect: "blind",
				 duration: 1500
			},
			hide: {
				effect: "explode",
				duration: 1000
			}
		});
	}
	dialog.load('../unit/_'+ui_id+'.sh',data);
	dialog.dialog('open');
}
function linkPage(ui_id, data, path){

	document.location.href = (path ? path + '/' : '') + '_'+ui_id+'.sh?' + $.param(data);
}
function linkFnc(obj){
	;
}
