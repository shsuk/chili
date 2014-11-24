<%@tag import="kr.or.voj.webapp.utils.XmlUtil"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="rcd_value" required="true" type="java.util.List" description="리스트 레코드(key value set))"%>
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
		<c:when test="${ui_field[type]=='lblFld' }">
			<c:set var="lblFld">${key}</c:set>
		</c:when>
	</c:choose>
</c:forEach>
<script type="text/javascript">
	$(function() {
		
		var horizontal = false;
		var data = ${sp:list2chart(rcd_value, xFld, yFld, lblFld)  };
		// Draw the graph
		Flotr.draw($("#${chartId}").get(0), data.data, {
			HtmlText : false,
			grid : {
				verticalLines : false,
				horizontalLines : false
			},
			xaxis : {
				showLabels : false
			},
			yaxis : {
				showLabels : false
			},
			pie : {
				show : true,
				explode : 6
			},
			mouse : {
				track : true,
				trackFormatter: function(data) {
					return data.series.label + ' : ' + Math.ceil(data.y)
				}
			},
			legend : {
				position : 'ne',
				backgroundColor : '#D2E8FF'
			}
		});

	});
</script>
<div id="${chartId }" style="height: 100%; width: 95%;margin: auto;"></div>