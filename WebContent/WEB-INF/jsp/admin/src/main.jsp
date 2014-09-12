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
<link href="../../jquery/development-bundle/themes/redmond/jquery.ui.all.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../../jquery/jqGrid/css/ui.jqgrid.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../../jquery/jqGrid/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../../css/contents.css" rel="stylesheet" type="text/css" />

<script src="../../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../../jquery/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<script src="../../jquery/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../jquery/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../../js/commonUtil.js" type="text/javascript"></script>
<script src="../../js/autoPageUtils.js" type="text/javascript"></script>
<script type="text/javascript">
	
	$(function() {
		$( window ).resize(function(e,e1) {
			$("#ui_set").css('height', (window.innerHeight-200) + 'px');		
		}).resize();
		$('#tab' ).tabs();
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
	});

	function loadMain(){
		var data = $('#main_form').serializeArray();

		$('#prg_bar').animate({width: '0%'}, 1);

		$('#ui_set').load('src_load/bit.sh', data, function(){
			$( window ).resize();
			removeDupControl();
			initDrDg();
			
			$('#prg_bar').animate({width: '100%'}, 300);
		});
		
		$( "#tab" ).tabs( "option", "active", 0);	
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

		$('#ui_set').load('src_save/bit.sh', data, function(){
			loadMain();
		});
	}
	
	function tdSpan(obj){
		var title = obj.attr('title');
		var type =  obj.attr('type');
		$('td', $('#ui_source_dgn')).css({width:'100px'});
		var cspan =  Math.round((obj.outerWidth()+40)/100);
		obj.parent().parent().attr('colspan', cspan);
		//var rspan =  Math.round((obj.outerHeight()+10)/32);
		//$('.'+title+'[type='+type+']').attr('rowspan', rspan);
		obj.css({position: 'relative', top:'', left:''});
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
	
	function save(){
		var data = $('#src_form').serializeArray();

		$.post('src_save/bit.sh', data, function(){
			alert('저장되었습니다.');
		});
	}
	
	function runDefaultPage(){
		runPage();
		$( "#tab" ).tabs( "option", "active", 1);	
	}
	function runPage(){
		var data = $('#main_form').serializeArray();

		$('#auto_generated_uI_main').load('src_run/bit.sh',data, function(){
			$( window ).resize();
			//$('#formData').val('');
		});
		
	}
	
	function openPage(){

		var frm = $('#new_form');
		var param = $('#defaultValue').val().split(',').join('&').split(':').join('=').split(' ').join('').split('""').join('').split("'").join('');
		frm.attr('action', 'src_run/bit.sh?_ps=temp&' + param);
		frm.submit();
	}
</script> 
</head>
<body >

	<form id="main_form" action="aa" method="post">
		<div id="defaultData"  style="float: left;padding:1px;">
			<div class="border f_l p_1 m_3 ui-widget-header" >
				쿼리경로 <tag:select_query_name name="queryPath" selected="${req.queryPath }"/>
			</div>
			<div class="border f_l p_1 m_3 ui-widget-header" >기본값 <input type="text" id="defaultValue" name="defaultValue" style="width: 200px;" value="rows:10,_start:1,notice_id:72"></div>
			<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 5px; padding: 3px;" onclick="loadMain()">읽기</div>
			<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 5px; padding: 3px;" onclick="saveUi()">저장</div>
			<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 5px; padding: 3px;" onclick="runDefaultPage()" >실행</div>
		</div>
<!-- 		
			<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="makeData()">생성</div>
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="save()">임시저장</div>
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="openPage()" >미리보기</div>
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="loadQuery()">쿼리보기</div>	
 -->
 		<input type="hidden" id="ui_design" name="ui_design" value="">
 		<div id="form_data"></div>
		<div style="clear: both;">
			<div style=" float: left; border: 1px solid #c5dbec; width: 300px; height: 10px;"><div id="prg_bar" style="border: 1px solid #c5dbec; height: 8px;background: #c5dbec;"></div></div>
			<span  style="float: right;"> 
				<span style="float: left;"><b>Col Count : </b></span><input type="text" name="col_count" value="${col_count }"  class="spinner" style="width: 20px;height: 14px;"/>
				<span style="float: left;"><b>Unit of width : </b><tag:check_array name="wUnit" codes="wUnit=%"  checked="${param['wUnit'] }" /></span>
			</span>
			<span style=" clear:both;"></span>
		</div>
		<div id="source" style="clear: both;">
			<div id="tab">
				<ul>
					<li><a href="#tabs-1">UI설정</a></li>
					<li><a href="#auto_generated_uI_main">미리보기</a></li>
					<li><a href="#tabs-3">할일</a></li>
				</ul>
				<!-- UI설정 -->
				<div id="tabs-1">					
					<div id="ui_set" style="overflow:auto;"></div>
				</div>
				<!-- 미리보기 -->
				<div id="auto_generated_uI_main"></div>
				<div id="tabs-3">					
					코드 및 각종 콘트롤 구현<br>
					타이틀 스타일 안됨<br>
					페이징<br>
					볼륨처리<br>
					이미지 미리보기 타입추가<br>
					테이블 생성<br>
					맵퍼<br>
				</div>
			</div>
		</div>
	</form>
	<div id="query" title="쿼리보기"></div>
	<form id="new_form" action="/test/main.sh?_ps=temp" method="post" target="_new"></form>
</body>
</htm>