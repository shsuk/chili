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
	<header style="margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		<img src="../images/log.png" height="100">
	</header>
	<div style="margin: 5px auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		<table class="lst">
			<tr>
				<td  valign="top" style=" width: 250px; min-width:200px;">
					<div id="left_content" style=" height:500px; overflow-y: auto; ">
						<c:import url="${IMPORT_PAGE }.jsp"/>
					</div>
				</td>
				<td valign="top">
					<div id="center_content" style=" height:500px; overflow-y: auto; "></div>
				</td>
			</tr>
		</table>
	</div>

	<footer style="margin: 0 auto; padding:3px; width: 90%; min-width:1040px; border:1px solid #cccccc; ">
		test
	</footer>
				
</body>
</htm>