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
	
	var height_etc = $("header").get(0).clientHeight + $("footer").get(0).clientHeight+50;
	
	$( window ).resize(function(e,e1) {
		var height = (window.innerHeight-height_etc) + 'px';
		$("#left_content").css('height', height);		
		$("#center_content").css('height', height);		
	}).resize();
});

</script> 

<div style="margin: 5px auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
	<table class="lst">
		<tr>
			<th style=" width: 250px; min-width:200px;" id="left_content_title"></th>
			<th style=" width: 400px; min-width:200px;" id="center_content_title"></th>
		</tr>
		<tr>
			<td  valign="top" style=" width: 250px; min-width:200px;">
				<div id="left_content" style=" height:500px; overflow-y: auto; ">
						<src:auto_make_src isForm="true"/>
				</div>
			</td>
			<td valign="top">
				<div id="center_content" style=" height:500px; overflow-y: auto; "></div>
			</td>
		</tr>
	</table>
</div>
