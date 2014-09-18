<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 

<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>Chili 프로젝트</title>
<link href="../../jquery/development-bundle/themes/redmond/jquery.ui.all.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../../jquery/jqGrid/css/ui.jqgrid.css"  rel="stylesheet" type="text/css" media="screen" />
<link href="../../jquery/jqGrid/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../../css/contents.css" rel="stylesheet" type="text/css" />

<script src="../../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="../../jquery/js/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
<script src="../../jquery/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../jquery/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../../js/commonUtil.js" type="text/javascript"></script>
<script src="../../js/autoPageUtils.js" type="text/javascript"></script>
<script type="text/javascript">

</script> 
</head>
<body >
	at/{pathName}/.sh?ui_id={ui_id}<br>
	at/{pathName}에 main.jsp를 구현하여 서로다른 레이아웃을 적용할 수 있다.<br>
	<a href="../pg2/.sh?ui_id=${param.ui_id }">../../at/pg2/.sh?ui_id=${param.ui_id }</a>
	
	<div id="auto_generated_uI_main" style="margin: 0 auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc; ">
		<form id="body_form" action="" method="post" enctype="multipart/form-data">
			<c:set scope="request" var="isForm" value="${true }"/>
			<c:import url="../src_run.jsp"/>
		</form>
	</div>
	p1_p2_p3~.sh : 루트에 있는 main.jsp를 사용하여 p1/p2/p3~.jsp를 include한다.<br>
	path1/p1_p2_p3~.sh : path1에 있는 main.jsp를 사용하여 path1/p1/p2/p3~.jsp를 include한다.<br>
<	path1/path2/p1_p2_p3~.sh : path1/path2에 있는 main.jsp를 사용하여 path1/path2/p1/p2/p3~.jsp를 include한다.<br>
</body>
</htm>