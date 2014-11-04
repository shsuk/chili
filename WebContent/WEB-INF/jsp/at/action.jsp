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
<sp:sp var="ui_info" queryPath="ui" action="design" processorList="mybatis" exception="false"/>
<c:set var="query_path" value="${req.action_type=='D' ? ui.delete_paath : (req.action_type=='I' ? ui.indert_paath : ui.update_path) }"/>
<c:set scope="session" var="user_id" value="tester"/>
<sp:sp var="RESULT" queryPath="${fn:substringBefore(query_path,'.') }" action="${fn:substringAfter(query_path,'.' ) }" loopId="${req.loop_field_name }" processorList="attach,mybatis" exception="false">
	{
		${param.defaultValue }
	}
</sp:sp>
${RESULT.JSON}