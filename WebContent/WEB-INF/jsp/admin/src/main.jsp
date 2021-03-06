<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 

<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>Chili 프로젝트</title>
<meta name="viewport" content="user-scalable=yes, width=device-width, initial-scale=1, maximum-scale=2">
<link href="../jquery/jquery-ui-1.11.2.custom/jquery-ui.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/css/ui.jqgrid.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../css/contents.css" rel="stylesheet" type="text/css" />

<script src="../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../jquery/jquery-ui-1.11.2.custom/jquery-ui.min.js" type="text/javascript"></script>
<script src="../jquery/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../jquery/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../jquery/js/hammer.min.js" type="text/javascript"></script>
<script src='../jquery/js/cookies.js' type="text/javascript"></script>

<script src="../js/commonUtil.js" type="text/javascript"></script>
<script src="../js/autoPageUtils.js" type="text/javascript"></script>
<script type="text/javascript">

$(function() {
	$( document ).tooltip({
		track: true,
		items: "[title]",
		content: function() {
			var element = $( this );
			
			if ( element.is( "[title]" ) ) {
				return element.attr( "title" );
			}
		}
	});
	
	viewUiList();

	$('#prg_bar').progressbar();
	//콘트롤 설정시 마우스 이동에 대한 백그라운드 처리
	$(document).on('mouseenter', '.field_settion', function(){
		var ts = $(this);
		ts.css({background:'#cccccc'});
		var field_id = ts.attr('field_id');
		$('[title='+field_id+']').css('color','red');
	});
	$(document).on('mouseleave', '.field_settion', function(){
		var ts = $(this);
		ts.css({background:''});
		var field_id = ts.attr('field_id');
		$('[title='+field_id+']').css('color','');
	});
	$(document).on('mouseenter', '.drg[title]', function(){
		var ts = $(this);
		ts.css('color','red');
		var field_id = ts.attr('title');
		$('.field_settion[field_id='+field_id+']').css({background:'#cccccc'});
	});
	$(document).on('mouseleave', '.drg[title]', function(){
		var ts = $(this);
		ts.css('color','');
		var field_id = ts.attr('title');
		$('.field_settion[field_id='+field_id+']').css({background:''});
	});
/* 
	//링크필드 처리
	$(document).on('focusin', '.input_link', function(e){
		$(e.target).css({position: 'absolute', width:'300px'});
	});
	$(document).on('focusout', '.input_link', function(e){
		$(e.target).css({position: '', width:''});
	});

	//UI리스트 숨김
	$('#main_form').click(function(e){
		var nodes = $(e.target).parentsUntil('#ui_list_btn');
		if($(nodes[nodes.length-1]).attr('id')!='ui_list'){
			$('#ui_list').hide();
		}
	});
*/	
});

function progressValue(val) {
	 $('#prg_bar').progressbar('value', val);
}

function loadPage(){
	var data = $('#main_form').serializeArray();

	progressValue(false);

	$('#ui_set').load('../admin-src/src_load.sh', data, function(){
		//$('#ui_list').hide();
		
		$( window ).resize();
		removeDupControl();
		initDrDg();
		var old_query_path = $('#old_query_path').val();
		$("#queryPath").val(old_query_path).attr("selected", "selected");
		progressValue(100);
	});
	
}

function changePage(ui_id){
	$('#ui_id').val(ui_id);
	loadPage();
	hideMenu();
}

function removeDupControl(){
	var ui_source_dgn = $('#ui_source_dgn');
	var ui_source_config = $('#ui_source_config');
	var configFieldName = $('.field_name', ui_source_config );
		
	for(var i=0; i<configFieldName.length; i++){
		var fld = $(configFieldName[i]);
		var name = fld.attr('title');
		var dgnFld = $('.field_name[title='+name+']', ui_source_dgn);
		dgnFld.parent().append(fld);
		dgnFld.remove();
	}
	var configField = $('.field', ui_source_config );
	for(var i=0; i<configField.length; i++){
		var fld = $(configField[i]);
		var name = fld.attr('title');
		var dgnFld = $('.field[title='+name+']', ui_source_dgn);
		dgnFld.parent().append(fld);
		dgnFld.remove();
	}
}

function saveUi(){
	var ui_source_dgn = '';
	if($('.drg', $('#ui_source_dgn')).length>0){
		ui_source_dgn = $('#ui_source_dgn').html();
	}
	$('#ui_design').val(ui_source_dgn);
	var data = $('#main_form').serializeArray();

	$('#prg_bar').animate({width: '0%'}, 1);

	$('#ui_set').load('../admin-src/src_save.sh', data, function(){
		loadPage();
	});
}

function tdSpan(obj){
	$('td', $('#ui_source_dgn')).css({width:'100px'});

	var cspan =  Math.round((obj.outerWidth()+40)/100);
	obj.css({position: 'relative', top:'', left:''});
	var td = obj.parent().parent();
	td.attr('colspan', cspan);
	
	hideTd(td);
}

function hideTd(trgTd){
	var allSpan = 0;
	var tr = trgTd.parent();
	var tds = $('td', tr);
	var len = tds.length;
	
	for(var i=0; i<len; i++){
		var td = $(tds[i]);
		var span = td.attr('colspan');
		span = span ? parseInt(span,10) : 1;
		allSpan += span;
		if(allSpan > len){
			td.hide();
		}else{
			td.show();
		}
	}
	
}

function initDrDg(){
	var ui_design_form = $('.ui_design_form');
	$('.field', ui_design_form ).draggable({ revert: "invalid" });
	$(".field", ui_design_form ).resizable({helper: 'ui-resizable-helper', maxHeight: 20, minHeight: 20, minWidth: 60, containment: '#resizable_container', stop: function( event, ui ) {
		tdSpan($(this));
	}});
	
	$('.field_name', ui_design_form ).draggable({ revert: "invalid" });
	$('.field_name', ui_design_form ).resizable({helper: 'ui-resizable-helper', maxHeight: 20, minHeight: 20, minWidth: 60, containment: '#resizable_container', stop: function( event, ui ) {
		tdSpan($(this));
	}});
	
	$('.to_field', ui_design_form ).droppable({
		activeClass: "ui-state-default",
		hoverClass: "ui-state-hover",
		out: function( event, ui ) {
			var td = $($( this ).parent());
			var src = $(ui.draggable);
			var type = src.attr('type');
			if(type=='field_name'){
				td.removeClass( "th" );
			}
			
			td.attr('colspan', 1);
			td.attr('rowspan', 1);
			
			hideTd(td);
		},
		drop: function( event, ui ) {
			var td = $($( this ).parent());
			var src = $(ui.draggable);
			var type = src.attr('type');
			//필드명인 경우 색상처리
			if(type=='field_name'){
				td.addClass( "th" );
			}

			$( this ).append(src);
			src.css({top:'', left:''});
			tdSpan(src);
		}
	});
}

function runDefaultPage(){
	var form = $('#new_form');
	form.attr('action', '../' + $('#tpl_path').val() + '/-' + $('#ui_id').val() + '.sh');
	form.submit();
	//runPage();
	//$( "#tab" ).tabs( "option", "active", 1);	
}

function viewUiList(){
	$('#ui_list').load('../piece/-uilist-.sh', function(){
		showMenu();
	});
}
/* 	
function save(){
	var data = $('#src_form').serializeArray();

	$.post('src_save/bit.sh', data, function(){
		alert('저장되었습니다.');
	});
}

function openPage(){

	var frm = $('#new_form');
	var param = $('#defaultValue').val().split(',').join('&').split(':').join('=').split(' ').join('').split('""').join('').split("'").join('');
	frm.attr('action', 'src_run/bit.sh?_ps=temp&' + param);
	frm.submit();
}
 */	
</script> 
</head>
<body >
	<div class="menu" type="user" style="width: 320px;">
		<div class="ui-widget-header">UI 리스트</div> 
		<div id="ui_list" class="auto_height" style=" overflow-y: auto;"></div> 
	</div>


	<form id="main_form" action="aa" method="post">
 		<input type="hidden" id="ui_design" name="ui_design" value="">
		<div id="defaultData"  style="float: left;padding:1px;">
			<div id="ui_list_btn" class="border f_l p_1  ui-widget-header" >
				<span>UI ID</span> <input type="text" id="ui_id" name="ui_id" value="${param.ui_id }">
			</div>
			<div class="border f_l p_1  ui-widget-header" >
				쿼리경로 <tag:select_query_name name="queryPath" selected="${req.queryPath }"/>
			</div>
			<div class="border f_l p_1  ui-widget-header" >기본값 <input type="text" id="defaultValue" name="defaultValue" style="width: 200px;" value="rows:10,_start:1,notice_id:72"></div>
			<div class=" ui-widget-header ui-corner-all btn_left f_l" onclick="loadPage()">읽기</div>
			<div class=" ui-widget-header ui-corner-all btn_left f_l" onclick="saveUi()">저장</div>
			<div class=" ui-widget-header ui-corner-all btn_left f_l" onclick="runDefaultPage()" >실행</div>
		</div>
		
 		<div id="form_data"></div>
			<div style=" float: right; border: 1px solid #c5dbec; width: 300px;padding: 5px;margin: 0px 0px 8px 4px;">
				<div id="prg_bar" style="height: 8px;"></div>
			</div>
			<span  style="float: right;"> 
				<span><b>Col Count : </b></span><input type="text" name="col_count" value="${col_count }"  class="spinner" style="width: 20px;height: 14px;"/>
			</span>
			<span style=" clear:both;"></span>
		<div id="source" style="clear: both;border: 1px solid #c5dbec;padding: 5px;">
					
			<div id="ui_set" style="overflow:auto;"></div>
				
		</div>
	</form>
	<form id="new_form" action="" method="post" target="_new"></form>
</body>
</htm>