<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<script src="../jquery/js/hammer.min.js" type="text/javascript"></script>

<script type="text/javascript">
	$(function() {
		$('#header_title').text('메뉴');
	});
</script> 

<div id="main_contents" >
	<table class="lst">
		<tr>
			<th>UI 목록</th>
		</tr>
		<tr>
			<td id="main_contents_td" valign="top">
				<src:auto_make_src type="bf"/>
			</td>
		</tr>
	</table>
</div>