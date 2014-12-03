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
<meta name="viewport" content="user-scalable=yes, width=device-width, initial-scale=1, maximum-scale=2">
<title>Chili 프로젝트</title>
<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
<link href="../jquery/jquery-ui-1.11.2.custom/jquery-ui.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/css/ui.jqgrid.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" media="screen" />
<link href='../jquery/dynatree/skin/ui.dynatree.css' rel='stylesheet' type='text/css' >
<link href="../css/contents.css" rel="stylesheet" type="text/css" />
<link href="../css/contents${isMobile ? '-mb' : '-web' }.css" rel="stylesheet" type="text/css" />

<script src="../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../jquery/jquery-ui-1.11.2.custom/jquery-ui.min.js" type="text/javascript"></script>
<script src='../jquery/js/cookies.js' type="text/javascript"></script>

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
<script src="../js/chart.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$( document ).tooltip({
		items: "[title]",
		content: function() {
			var element = $( this );
			setTimeout(function () {
				var toolTip = $('.ui-tooltip');
				if(toolTip.length>1){
					toolTip.hide();
				}
				//alert(22);
			}, 2000);		
			
			if ( element.is( "[title]" ) ) {
				return element.attr( "title" );
			}
		}
	});
	
});
</script> 
</head>
<body >
	<header class="fix_height main_layout">
		<img src="../images/log3.jpg" height="100"><span style="font-size: 30px; margin-left:30px;">Chili프로젝트 <span id="header_title" style="font-size: 30px;"></span></span>
	</header>
	<div class="main_layout" style="margin: 3px auto 3px; overflow:auto; ">
		<c:import url="${UI_TPL }"/>
	</div>
	<footer class="fix_height main_layout" style="clear: both; ">
		test
	</footer>
</body>
</htm>