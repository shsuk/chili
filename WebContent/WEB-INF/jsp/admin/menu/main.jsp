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

	function load(url){
		var target = $('#main_contents${isMobile ? "" : "_td"}');
		target.load(url);
	}
	function openUrl(url){

		document.location.href = url;
	}
	function check(chartId){
		if(chartId.length>0 && chartId.get(0).clientHeight==0){
			return;
		}
		
	}
</script> 

<div id="main_contents" >
	<table class="lst">
		<tr>
			<th class="hide_mb">메 뉴</th>
			<th>UI 목록</th>
		</tr>
		<tr>
			<td class="hide_mb" style="width: 150px;; " valign="top">
				<ul class="menu">
					<li class="ui-widget-header">개발 메뉴</li>
					<li><a target="ui" href="../admin-src/main.sh">UI 생성</a></li>
					
					<li class="ui-widget-header">XML to DB 연동</li>
					<li><a target="new" href="../-admin-mapper-main/createtbl.sh">1. 테이블 생성</a></li>
					<li><a target="new" href="../-admin-mapper-main/xml2db_mapping.sh">2. XPath에 필드 매핑</a></li>
					<li><a target="new" href="../-admin-mapper-main/trigger_mapping.sh">3. XPath에 연동쿼리 매핑</a></li>

					<li class="ui-widget-header">페이지 로딩 예제</li>
					<li onclick="openUrl('../-at-portlet-ly/sample1.sh')">포틀릿 예제</li>
					<li onclick="load('../at-portlet/sample1.sh')">포틀릿 예제(레이어)</li>
					<li onclick="openUrl('../-at-lo-h3/-group_list.sh')">코드 관리</li>
					<li onclick="load('../at-lo-h3/-group_list.sh')">코드 관리(레이어)</li>
					<li class="ui-widget-header">기타</li>
					<li><a target="new" href="../-admin-menu-manual/.sh">메뉴얼</li>
				</ul>
			</td>
			<td id="main_contents_td" valign="top">
				<src:auto_make_src type="bf"/>
			</td>
		</tr>
	</table>
</div>