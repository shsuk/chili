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
		$('#header_title').text('매뉴얼');
	});
</script> 


<div style="margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
	<b>URL 패턴</b>
	<table class="vw" style="width: 500px;">
		<tr>
			<th align="left">1. -{TemplatePath}/-{ui_id}.sh</th>
			<td>전체 레이아웃이 있는 자동 생성된 페이지</td>
		</tr>
		<tr>
			<th align="left">2. piece/-{uiId}.sh</th>
			<td>자동 생성된 페이지</td>
		</tr>
		<tr>
			<th align="left">3. unit/-{uiId}.sh</th>
			<td>폼이 있는 자동 생성된 페이지</td>
		</tr>
		<tr>
			<th align="left">4. -{TemplatePath}/{page}.sh</th>
			<td>전체 레이아웃이 있는 개발자가 만든 페이지</td>
		</tr>
		<tr>
			<th align="left">5. {path}/{page}.sh</th>
			<td>개발자가 만든 페이지</td>
		</tr>
	</table>
	
	<b>인자 설명</b>
	<table class="vw"  ">
		<tr>
			<th align="left">Template Path</th>
			<td>
				1) prefix '-'로 시작하여 레이아웃을 사용함을 알린다.<br>
				2) {TemplatePath}에 Template의 경로를 입력한다.<br>
				3) 경로구분자 '/ 대신 '-' 로 치환하여 2 depth를 유지한다.
			</td>
		</tr>
		<tr>
			<th align="left">ui_id</th>
			<td>
				1) prefix '-'로 시작하여 uiID임을 알린다.
			</td>
		</tr>
		<tr>
			<th align="left">page</th>
			<td>
				1) URL패턴 4의 경우는 TemplatePath 에 템플릣 페이지를 제외한 경로와 조합되어 패스가 구성된다.<br>
				2) 경로구분자 '/ 대신 '-' 로 치환하여 사용 한다.
			</td>
		</tr>
	</table>
	<br>
</div>