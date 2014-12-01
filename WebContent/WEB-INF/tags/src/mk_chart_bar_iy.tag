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
<c:set var="rcd_value" value="${empty(rcd_value) ? sourceData : rcd_value}"/>
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
		
		var chartData = ${sp:list2chart(rcd_value, lblFld, xFld, yFld, null)  };
		
		$( window  ).resize(function() {
			if($('#${chartId}').get(0).clientHeight==0){
				return;
			}
			try {
				drawBarIY('#${chartId}', chartData);
			} catch (e) {
				// TODO: handle exception
			}
		}).resize();		
		
		// Draw the graph
		function drawBarIY(selector, chartData){
			var horizontal = false;

			Flotr.draw($(selector).get(0), chartData.data, {
				bars : {
					show : true,
					horizontal : horizontal,
					//shadowSize : 0,
					barWidth : 1
				},
				legend: {
		            position: 'ne',
		            // Position the legend 'south-east'.
		            //labelFormatter: labelFn,
		            // Format the labels.
		            backgroundColor: '#D2E8FF' // A light blue background color.
		        },
				xaxis : {
					noTicks: chartData.data.length+2, // Display n ticks.
		            tickFormatter: function(n) {
		                return '&nbsp;'; //''&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ' + Math.ceil(n) + '월';
		            },
					showLabels: true
				},
				yaxis : {
					min : 0,
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
						return data.series.label + ' : ' + Math.ceil(data.y)
					}
				},
	            grid: {
	                horizontalLines: true,
	                verticalLines: false
	            }
			});
			
		}

	});
</script>
<div id="${chartId }" style="height: 100%; width: 95%; max-height: 400px;"></div>