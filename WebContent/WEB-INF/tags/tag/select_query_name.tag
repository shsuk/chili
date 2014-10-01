<%@tag import="kr.or.voj.webapp.processor.ProcessorServiceFactory"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="name" type="java.lang.String" required="true"%>
<%@ attribute name="selected" type="java.lang.String" %>
<%
jspContext.setAttribute("nss", ProcessorServiceFactory.getMyBatisNameSpace());
%>
<select id="${name }" name="${name }">
	<option value="" >쿼리 선택</option>
	<c:forEach var="ns" items="${nss}"> 
		<option value="${ns }" ${selected == ns ? 'selected' : ''}>${ns}</option>
	</c:forEach>
</select>