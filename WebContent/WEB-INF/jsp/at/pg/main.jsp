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
<link href='../jquery/dynatree/src/skin/ui.dynatree.css' rel='stylesheet' type='text/css' >

<script src="../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../jquery/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<script src="../jquery/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../jquery/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../js/commonUtil.js" type="text/javascript"></script>
<script src="../js/autoPageUtils.js" type="text/javascript"></script>
<script src='../jquery/js/jquery.dynatree.js' type="text/javascript"></script>
<script src='../jquery/js/jquery.cookie.js' type="text/javascript"></script>
<script type="text/javascript">

</script> 
</head>
<body >
	<div style="margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		<img src="../images/log.png" height="100">
		다른 디자인 예) <a href="../_at_pg2/_${UI_ID }.sh">../_at_pg2/_${UI_ID }.sh</a><br><br>
	</div>

	<div id="auto_generated_uI_main" style="margin: 5px auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc; ">
			<src:auto_make_src isForm="true"/>
	</div>

	<b>URL 패턴</b>
	<table class="vw" style="width: 500px;">
		<tr>
			<th align="left">1. _{layerPath}/_{ui_id}.sh</th>
			<td>전체 레이아웃이 있는 자동 생성된 페이지</td>
		</tr>
		<tr>
			<th align="left">2. piece/_{uiId}.sh</th>
			<td>자동 생성된 페이지</td>
		</tr>
		<tr>
			<th align="left">3. unit/_{uiId}.sh</th>
			<td>폼이 있는 자동 생성된 페이지</td>
		</tr>
		<tr>
			<th align="left">4. _{mainPath}/{page}.sh</th>
			<td>전체 레이아웃이 있는 개발자가 만든 페이지</td>
		</tr>
		<tr>
			<th align="left">5. {path}/{page}.sh</th>
			<td>개발자가 만든 페이지</td>
		</tr>
	</table>
	
	<b>인자 설명</b>
	<table class="vw" style="width: 500px;">
		<tr>
			<th align="left">layerPath</th>
			<td>
				1) prefix '_'로 시작하여 레이아웃을 사용함을 알린다.
				2) {layerPath}에 main.jsp를 구현하여 서로다른 레이아웃을 적용할 수 있다.<br>
				3) 경로구분자 '/ 대신 '_' 로 대치하여 2 depth를 유지한다.
			</td>
		</tr>
		<tr>
			<th align="left">ui_id</th>
			<td>
				1) prefix '_'로 시작하여 uiID임을 알린다.
			</td>
		</tr>
	</table>
	<br>

</body>
</htm>