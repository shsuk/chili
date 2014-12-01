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


});

</script> 

<div  id="content_main"  style="margin: 0px auto; padding:3px; ${isMobile ? 'mb_' : ''}width: 90%; ${isMobile ? 'mb_' : ''}min-width:1040px;">
	<tag:splitH id="h" splitCount="3" bodyIndex="1">
		<src:auto_make_src  type="bf"/>
	</tag:splitH>
</div>
