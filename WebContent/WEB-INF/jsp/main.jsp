<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 

<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>Chili 프로젝트</title>
<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
<link href="../jquery/development-bundle/themes/smoothness/jquery.ui.all.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/css/ui.jqgrid.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" media="screen" />
<link href='../jquery/dynatree/skin/ui.dynatree.css' rel='stylesheet' type='text/css' >
<link href="../css/contents.css" rel="stylesheet" type="text/css" />
<script src="../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../jquery/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<script src='../jquery/js/jquery.cookie.js' type="text/javascript"></script>

<script src='../jquery/dynatree/jquery.dynatree.js' type="text/javascript"></script>
<!--[if IE]>
    <script type="text/javascript" src="../jquery/flotr2/flotr2.ie.min.js"></script>
<![endif]-->
<script src="../jquery/flotr2/flotr2.min.js" type="text/javascript"></script>
<!-- 
<script src="../jquery/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../jquery/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
 -->
<script src="../js/commonUtil.js" type="text/javascript"></script>
<script src="../js/autoPageUtils.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$( document ).tooltip({
		items: "[title]",
		content: function() {
			var element = $( this );
			
			if ( element.is( "[title]" ) ) {
				return element.attr( "title" );
			}
		}
	});
	
	function getFixHeight(){
		var fixHeights = $(".fix_height");
		var fh = 60;
		
		for(var i=0; i<fixHeights.length; i++){
			fh += fixHeights[i].clientHeight;
		}
		return fh;
	}

	$( window ).resize(function(e,e1) {
		var h = window.innerHeight - getFixHeight();
		var height = h + 'px';
		var obj = $(".auto_height");
		obj.css('height', height);
		var sizeSyncs = $('[size_sync]');
		for(var i=0; i<sizeSyncs.length ; i++){
			var syncObj = $($(sizeSyncs[i]).attr('size_sync')).get(0);
			$(sizeSyncs[i]).css('height', syncObj.clientHeight + 'px');
			$(sizeSyncs[i]).css('width', (syncObj.clientWidth-5) + 'px');
		}
	}).resize();
});
</script> 
</head>
<body >
	<header class="fix_height" style="margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		<img src="../images/log3.jpg" height="100"><span style="font-size: 30px; margin-left:30px;">Chili프로젝트 <span id="header_title" style="font-size: 30px;"></span></span>
	</header>
	<c:import url="${UI_TPL }"/>
	<footer class="fix_height" style="clear: both; margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		test
	</footer>
</body>
</htm>