<%@tag import="kr.or.voj.webapp.utils.XmlUtil"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src"%> 
<%@ attribute name="chartType" required="true" type="java.lang.String" description="차트 종류"%>
<%@ attribute name="rcd_value" required="false" type="java.util.List" description="리스트 레코드(key value set)"%>

<c:set var="chartId" value="${sp:uuid()}"/>
<c:forEach var="info" items="${rcd_value[0] }" >
	<c:set var="key">${info.key}</c:set>
	<c:set var="type">${key}_type</c:set>
	
	<c:choose>
		<c:when test="${ui_field[type]=='xFld' }">
			<c:set var="xFld">${key}</c:set>
		</c:when>
		<c:when test="${ui_field[type]=='yFld' }">
			<c:set var="yFld">${key}</c:set>
		</c:when>
		<c:when test="${ui_field[type]=='zFld' }">
			<c:set var="zFld">${key}</c:set>
		</c:when>
		<c:when test="${ui_field[type]=='lblFld' }">
			<c:set var="lblFld">${key}</c:set>
		</c:when>
	</c:choose>
</c:forEach>
<script type="text/javascript">
	$(function() {
		
		var chartData = ${sp:list2chart(rcd_value, lblFld, xFld, yFld, zFld)  };
		
		drawChart('${chartType}', '#${chartId}', chartData);

	});
</script>
<div id="${chartId }" style="margin:0px auto; height: 100%; width: 85%; max-height: 400px; min-height: 200px;"></div>