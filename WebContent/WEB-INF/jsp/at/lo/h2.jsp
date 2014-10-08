<%@page import="java.util.Date"%>
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
<link href="../jquery/development-bundle/themes/redmond/jquery.ui.all.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/css/ui.jqgrid.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../jquery/jqGrid/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../css/contents.css" rel="stylesheet" type="text/css" />
<link href='../jquery/dynatree/skin/ui.dynatree.css' rel='stylesheet' type='text/css' >

<script src="../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../jquery/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<script src="../jquery/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../jquery/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../js/commonUtil.js" type="text/javascript"></script>
<script src="../js/autoPageUtils.js" type="text/javascript"></script>
<script src='../jquery/dynatree/jquery.dynatree.js' type="text/javascript"></script>
<script src='../jquery/js/jquery.cookie.js' type="text/javascript"></script>
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
	
	var height_header = $("header").get(0).clientHeight;
	var height_etc = height_header + $("footer").get(0).clientHeight + 130;
	
	$( window ).resize(function(e,e1) {
		var height = (window.innerHeight-($("#top_content").get(0).clientHeight + height_etc)) + 'px';
		$("#center_content").css('height', height);	
	}).resize();
	
	$( '#resizer' ).draggable({ containment: 'parent', stop: function( event, ui ) {
		var h = event.pageY - (height_header + 50);
		$("#top_content").css('height', h);
		$(this).css('top' , 0);
		$( window ).resize();
	} });
});

</script> 

<div id="main_content" style="margin: 5px auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
	<table class="lst">
		<tr>
			<th style="" id="top_content_title"></th>
		</tr>
		<tr>
			<td  valign="top" style="">
				<div id="top_content" style=" height:400px; overflow-y: auto; ">
						<src:auto_make_src type="BF"/>
				</div>
			</td>
			
		</tr>
	</table>
	<p id="resizer" style="height:3px; margin:1px 0 1px 0; border:1px solid #cccccc;cursor: ns-resize; "></p>
	<table class="lst">
		<tr>
			<th style="" id="center_content_title"></th>
		</tr>
		<tr>
			<td valign="top">
				<div id="center_content" style=" height:400px; overflow-y: auto; "></div>
			</td>
		</tr>
	</table>
</div>

