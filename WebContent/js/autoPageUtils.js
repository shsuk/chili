$(function() {
	//수정모드에서 필드클릭시 에디트모드로 전환
	$(document).on('click', '.view_control', function(e){
		var trg = $(e.currentTarget);

		if(trg.attr('isEditMode')=='true'){
			trg.hide();
			$('.editable',trg.parent()).show().focus();
		}	
	});
	//수정모드에서 콘트롤 값 변경시 에디트모드->조회모드로 전환
	$(document).on('change', '.editable', function(e){
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
	var page = $(page_id ? page_id : 'form');
	$('[name=action_type]', page).val('U');
	
	var view_controls = $('.view_control', page);
	view_controls.hide();
	view_controls.attr('isEditMode','true');
	
	$('.editable', page).show();
	//버튼제어
	$('.save_btn', page).show();
	$('.edit_btn', page).hide();
	$('.cancel_btn', page).show();
}
function cancel(page_id){
	var page = $(page_id);
	var view_controls = $('.view_control', page);
	view_controls.show();
	view_controls.attr('isEditMode','false');

	$('.editable', page).hide();
	//버튼제어
	$('.save_btn', page).hide();
	$('.edit_btn', page).show();
	$('.cancel_btn', page).hide();
}
function closePop(page_id){
	$( "#dialog" ).dialog('close');	
}
//콘트롤을 초기화 한다.
function initControl(){	
	var fields = $('.field');
	
	for(var i=0; i< fields.length; i++){
		var fld = $(fields[i]);
		//이미 초기화 된 경우
		if(fld.attr('init')){
			continue;
		}
		
		var ctl = $('.editable', fld);
		
		if(ctl.length<1){
			continue;
		}
		
		fld.attr('init', true);
		
		var val;
		var width ='95%';
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
function delField(id_field){
	$('#'+id_field).val(id_field);
	$('.'+id_field).parentsUntil('tr').parent().hide();

}

function form_submit(form_id){	
	var url = '../at/action.sh';
	var form = form_id ? $(form_id) : $('form');
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
			alert("저장 콜백 미구현");
			//document.location.href='list.jsp';
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
	       alert(1);
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
//타이들을 설정한다.
function setTitle(selector,title){
	$('#'+$(selector).parent().attr('id')+'_title').text(title);

}
function linkLoad(ele, ui_id, data, selector){
	var target;
	
	if($.isNumeric(selector)){
		target = $(ele).closest(".monitor");
		var idx = parseInt(target.attr('monitor')) + parseInt(selector);
		target = $('.monitor' + idx);
	}else{
		target = $(selector ? selector : '#auto_generated_uI_main');//없는 경우는 자신에 로딩
	}
	if(target.length<1){//로딩될 타켓이 없는 경우
		alert('페이지를 불러올 selector : ' + selector + ' 를 찾을수 없습니다.');
		return;
	}
	target.load('../piece/-'+ui_id+'-bf.sh',data);
}
function linkPopup(ele, ui_id, data){
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
	dialog.load('../piece/-'+ui_id+'-bf.sh',data);
	dialog.dialog('open');
}
function linkPage(ele, ui_id, data, path){
	
	if(ui_id==''){
		document.location.href = path + '?' + $.param(data);
	}else{
		document.location.href = (path ? path + '/' : '') + '-'+ui_id+'.sh?' + $.param(data);
	}
}
function linkFnc(obj){
	;
}
