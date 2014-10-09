<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 

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
	
	var height_etc = $("header").get(0).clientHeight + $("footer").get(0).clientHeight+75;
	
	$( window ).resize(function(e,e1) {
		var h = window.innerHeight-height_etc;
		var height = h + 'px';
		$("#left_content").css('height', height);
		$("#center_content").css('height', height);
		$("#resizer1").css('height', (h+33) + 'px');
	}).resize();
	
	$( '#resizer1' ).draggable({ containment: '#content_main', stop: function( event, ui ) {
		var wBack = (window.innerWidth - ($("header").get(0).clientWidth-36)) / 2;
		var w = event.pageX - (wBack);
		$("#left_content_td").css('width', w+13);
		$(this).css('left' , 0);
	} });
});

</script> 

<div  id="content_main"  style="margin: 5px auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
	<table style="width: 100%">
		<tr>
			<td id="left_content_td" valign="top" style=" width: 250px; min-width:200px;">
				<div id="left_content_title"></div>
				<div id="left_content" style=" height:500px; overflow-y: auto; ">
						<src:auto_make_src  type="BF"/>
				</div>
			</td>
			<td style="padding: 0px;">
				<div id="resizer1" style="height:500px; width:3px; margin:0px 1px 0 1px; border:1px solid #cccccc;cursor: ew-resize; "></div>
			</td>
			<td>
				<div id="center_content_title"></div>
				<div id="center_content" style=" min-width:500px; height:500px; overflow-y: auto; "></div>
			</td>
		</tr>
	</table>
</div>
