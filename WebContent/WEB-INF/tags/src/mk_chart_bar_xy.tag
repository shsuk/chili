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
		var chartData = ${sp:list2chart(rcd_value, xFld, yFld, lblFld) };
		var data = chartData.data;
		var chartType = chartData.type;
		// Draw the graph
		Flotr.draw($("#${chartId}").get(0), data, {
			bars : {
				show : true,
				horizontal : horizontal,
				//shadowSize : 0,
				barWidth : 3600000*21
			},
			xaxis : {
				mode: chartType,
	            labelsAngle: 45,
				noTicks: data.length+5,
				tickFormatter: function(n) {
					var date = new Date();
					date.setTime(n);
					return $.datepicker.formatDate(('yy-mm-dd '), date);
	            }
			},
			yaxis : {
				autoscaleMargin : 1,
				tickFormatter: function(n) {
	                return Math.ceil(n);
	            }
			},
			mouse : {
				track : true,
				relative : true,
                position: 'ns',
				trackFormatter: function(data) {
					var date = new Date();
					date.setTime(data.x);
					return $.datepicker.formatDate(('yy-mm-dd '), date) + ' : ' + Math.ceil(data.y)
				}
			},
            grid: {
                horizontalLines: true,
                verticalLines: true
            }
		});

	});
</script>
<div id="${chartId }" style="height: 100%; width: 95%;margin: auto;"></div>