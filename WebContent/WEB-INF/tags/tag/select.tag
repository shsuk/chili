<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="name" type="java.lang.String" required="true"%>
<%@ attribute name="groupId" type="java.lang.String" required="true"%>
<%@ attribute name="selected" type="java.lang.String" %>
<%@ attribute name="emptyText" type="java.lang.String"%>
<%@ attribute name="className" type="java.lang.String"%>
<%@ attribute name="style" type="java.lang.String" %>
<%@ attribute name="valid" type="java.lang.String" %>
<%@ attribute name="attr" type="java.lang.String" %>
<c:if test="${empty(_code) }">
	<sp:sp var="RESULT" queryPath="ui" action="codeList" processorList="mybatis" exception="false"/>
	<tag:list2group var="_code" group_field="group_id" list="${rows }"/>
</c:if>
<select name="${name }" ${valid } style="${style }"  ${attr } class="${className }" >
<c:if test="${!empty(emptyText)}"><option value="">${emptyText}</option></c:if>
<c:forEach var="row" items="${_code[groupId]}"> 
	<option value="${row.code_value }" ${selected == row.code_value ? 'selected' : ''}>${row.code_name}</option>
</c:forEach>
</select>