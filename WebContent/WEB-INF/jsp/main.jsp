<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<link href="jquery/development-bundle/themes/redmond/jquery.ui.all.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="jquery/jqGrid/css/ui.jqgrid.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="jquery/jqGrid/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" media="screen" />
<link href="css/contents.css" rel="stylesheet" type="text/css" />

<script src="jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="jquery/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<script src="jquery/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="jquery/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="js/commonUtil.js" type="text/javascript"></script>
<script type="text/javascript">
	
	$(function() {
		$['isEditMode'] = false;
		
		var fields = $('.field');
		
		for(var i=0; i< fields.length; i++){
			var fld = $(fields[i]);
			var ctl = $('.in_control', fld);
			
			if(ctl.length>0){
				var width = ctl.outerWidth() + 'px';
				var height = ctl.outerHeight() + 'px';
				var view = $('<div class="view_control"></div>');
				view.text(ctl.val());
				view.css({width: width, height: height, disply:'inline', overflow:'hidden', 'margin-right':'8px'});
				ctl.hide();
				fld.append(view);
			}
		}
		
		$('.view_control').click(function(e){
			if(!$.isEditMode){
				return;
			}
			var trg = $(e.currentTarget);
			trg.hide();
			$('.in_control',trg.parent()).show().focus();
		});
		$('.in_control').change(function(e){
			var trg = $(e.currentTarget);
			trg.hide();
			var view = $('.view_control',trg.parent());
			view.text(trg.val());
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
</script>
</head>
<body>
	<div id="main_layer" style="margin: 0 auto;  padding: 3px; width: 90%; min-width: 1000px; border: 1px solid #cccccc;">
		<div>test system</div>
		<c:import url="${IMPORT_PATH }.jsp"/>
		<div>ccc</div>
	</div>
</body>
</htm>