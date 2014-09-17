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
<%@ attribute name="checked" type="java.lang.String" %>
<%@ attribute name="className" type="java.lang.String"%>
<%@ attribute name="style" type="java.lang.String" %>
<%@ attribute name="valid" type="java.lang.String" %>
<%@ attribute name="attr" type="java.lang.String" %>
<c:if test="${empty(_code) }">
	<sp:sp queryPath="ui" action="codeList" processorList="mybatis" exception="false"/>
	<tag:list2group var="_code" group_field="group_id" list="${rows }"/>
</c:if>
<c:set var="id" value="${sp:uuid() }"/>
<radio  class="${className }" >
<c:forEach var="row" items="${_code[groupId]}">
	<input name="${name}" id="${id}_${row.code_value }"  type="radio" value="${row.code_value }" ${checked == row.code_value ? ' checked ' : ''} ${valid } ${att } style="float: left;"   ><label style="float: left;line-height: 20px;" for="${id}_${row.code_value }">${row.code_name}&nbsp;&nbsp;</label>
</c:forEach>
</radio>