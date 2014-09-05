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
			$("textarea").css('height', (window.innerHeight-170) + 'px');		
		}).resize();
		$('#tab' ).tabs();
	});
	
	function loadData(){
		var data = $('#main_form').serializeArray();
		var formData = $('#formData').val();
		
		if(formData!=''){
			data = $.parseJSON(formData);
		}

    	$('#prg_bar').animate({width: '0%'},1);

    	$('#ui_set').load('src_load/bit.sh',data, function(){
			$( window ).resize();
			$('#formData').val('');
			
			$('.field' ).draggable({ revert: "invalid" });
			$(".field" ).resizable({grid: 32, minWidth: 40, containment: '#resizable_container', stop: function( event, ui ) {
				span($(this));
			}});
			
			$('.field_name' ).draggable({ revert: "invalid" });
			$(".field_name" ).resizable({grid: 32, minWidth: 40, containment: '#resizable_container', stop: function( event, ui ) {
				span($(this));
			}});
			
			$( ".to_field" ).droppable({
				activeClass: "ui-state-default",
				hoverClass: "ui-state-hover",
				out: function( event, ui ) {
					var td = $($( this ).parent());
					var src = $(ui.draggable);
					var type = src.attr('type');
					if(type=='field_name'){
						td.removeClass( "th" );
					}
					td.removeClass(src.attr('title'));
					td.attr('type', '');
					td.attr('title', '');
					td.attr('colspan', 1);
					td.attr('rowspan', 1);
				},
				drop: function( event, ui ) {
					var td = $($( this ).parent());
					var src = $(ui.draggable);
					var type = src.attr('type');
					var title = src.attr('title');
					if(type=='field_name'){
						td.addClass( "th" );
					}
					td.addClass(title);
					td.attr('type', type);
					td.attr('title', title);
					
					span(src);
				}
			});
			
			
	    	$('#prg_bar').animate({width: '100%'}, 300);
		});
		
		$( "#tab" ).tabs( "option", "active", 0);	
	}
	
	function span(obj){
		var title = obj.attr('title');
		var type =  obj.attr('type');
		var cspan =  Math.round((obj.outerWidth()+40)/100);
		$('.'+title+'[type='+type+']').attr('colspan', cspan);
		var rspan =  Math.round((obj.outerHeight()+10)/32);
		$('.'+title+'[type='+type+']').attr('rowspan', rspan);

	}
	
	function makeUi(){
		var fields = $('.to_field');

		for(var i=0; i<fields.length; i++){
			var td = $(fields[i]).parent();
			var tit = td.attr('title');
			var type = td.attr('type');
			if(type==null || type==''){
				td.hide();
			}else{
				td.append($('.'+type+'s[name='+tit+']'));
			}
		}
		
		fields.hide();
		$('.drg').hide();
	}
	function editUi(){
		$('.to_field_td').show();
		$('.to_field').show();
		$('.drg').show();
		$('.fields').remove();
		$('.field_names').remove();
		
	}
	function makeData(){
		var data = $('#main_form').serializeArray();
		var formData = $('#formData').val();
		
		if(formData!=''){
			data = $.parseJSON(formData);
		}

		$('#tabs-2').load('src_make/bit.sh',data, function(){
			$( window ).resize();
			$('#formData').val('');
		});
	}
	
	function save(){
		var data = $('#src_form').serializeArray();

		$.post('src_save/bit.sh', data, function(){
			alert('저장되었습니다.');
		});
	}
	
	function loadQuery(){
		var data = $('#main_form').serializeArray();
		var formData = $('#formData').val();
		
		if(formData!=''){
			data = $.parseJSON(formData);
		}

		$('#query').load('src_query/bit.sh',data, function(){
			$( "#query" ).dialog();
		});
		
	}
	function runPage(){
		var data = $('#main_form').serializeArray();
		var formData = $('#formData').val();
		
		if(formData!=''){
			data = $.parseJSON(formData);
		}

		$('#tabs-3').load('src_run/bit.sh',data, function(){
			$( window ).resize();
			$('#formData').val('');
		});
		
		$( "#tab" ).tabs( "option", "active", 2);	
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
			<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="loadData()">읽기</div>
			<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="makeData()">생성</div>
			<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="runPage()" >실행</div>
		</div>
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="save()">임시저장</div>
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="openPage()" >미리보기</div>
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="loadQuery()">쿼리보기</div>
		<input type="text" id="formData" name="formData" value="" style="width: 100%" placeholder="소스 생성 정보 (생성된 소스의 하단 주석에 있는 코드)">
		<div id="source" style="clear: both;">
			<div id="tab">
				<ul>
					<li><a href="#tabs-1">UI설정</a></li>
					<li><a href="#tabs-2">소스</a></li>
					<li><a href="#tabs-3">미리보기</a></li>
				</ul>
				
				<!-- UI설정 -->
				<div id="tabs-1">
					<div style="float: left; border: 1px solid #c5dbec; width: 300px; height: 10px;"><div id="prg_bar" style="border: 1px solid #c5dbec; height: 8px;background: #c5dbec;"></div></div>
					<div id="ui_set" ></div>
				</div>
				<!-- UI소스 -->
				<div id="tabs-2"></div>
				<!-- 미리보기 -->
				<div id="tabs-3"></div>
			</div>
		</div>
	</form>
	<div id="query" title="쿼리보기"></div>
	<form id="new_form" action="/test/main.sh?_ps=temp" method="post" target="_new"></form>
</body>
</htm>