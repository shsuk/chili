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
<link href="../css/contents.css" rel="stylesheet" type="text/css" />
<link href='../jquery/dynatree/skin/ui.dynatree.css' rel='stylesheet' type='text/css' >

<script src="../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../jquery/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<script src="../js/commonUtil.js" type="text/javascript"></script>
<script src="../js/autoPageUtils.js" type="text/javascript"></script>
<script src='../jquery/dynatree/jquery.dynatree.js' type="text/javascript"></script>
<script src='../jquery/js/jquery.cookie.js' type="text/javascript"></script>
<script type="text/javascript">

</script> 
</head>
<body >
	<header style="margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		<img src="../images/log.png" height="100">
		<div style="float: right;padding:10px;">
			<a href="../_admin_mapper/createtbl.sh">XML연동 테이블 생성</a><br><div style="height: 5px;"></div>
			<a href="../_admin_mapper/mappingxml.sh">XML연동 매퍼</a>
		</div>
	</header>
	<div style="margin: 5px auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		<c:import url="${IMPORT_PAGE }.jsp"/>
	</div>

	<footer style="margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		test
	</footer>
				
</body>
</htm>