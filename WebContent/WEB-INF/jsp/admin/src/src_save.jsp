<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="kr.or.voj.webapp.db.QueryInfoFactory"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<sp:sp queryPath="ui" action="save" processorList="" exception="false"/>
<c:forEach var="data" items="${req }">
	<c:if test="${ !fn:startsWith(data.key, 'ui_design') && sp:isType(data.value,'string') && !fn:endsWith(data.key,']') || fn:endsWith(data.key,'[]')}">
		
		<c:set var="paramData">${paramData }, "${data.key }" : "${fn:replace(fn:replace(data.value,"'","\\'"),'"',"\\'") }"</c:set>
	</c:if>
</c:forEach>
<sp:sp queryPath="ui" action="save" processorList="mybatis" exception="false">
	{
		ui_field: '${fn:substring(paramData, 1, fn:length(paramData))}'
	}
</sp:sp>
