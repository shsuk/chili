<%@tag import="kr.or.voj.webapp.utils.XmlUtil"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src"%> 
<%@ attribute name="refName" required="false" type="java.lang.String" description="리스트 레코드(key value set))"%>
<%@ attribute name="rcd_value" required="false" type="java.util.List" description="리스트 레코드(key value set))"%>
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
		
		$( window  ).resize(function() {
			try {
				try {
					if($('#${chartId}').get(0).clientHeight==0){
						return;
					}
					drawPie('#${chartId}', chartData);
				} catch (e) {
					// TODO: handle exception
				}
			} catch (e) {
				// TODO: handle exception
			}
			drawLineIXY('#${chartId}', chartData);
		}).resize();		
		
		// Draw the graph
		function drawLineIXY(selector, chartData){
			Flotr.draw($(selector).get(0), chartData.data, {
				bubbles: {
		            show: true,
		            baseRadius: 5
		        },
				xaxis : {
					mode: chartData.type,
		            labelsAngle: 45,
					noTicks: 5,
					tickFormatter: function(n) {
		                return Math.ceil(n);
		            }
				},
				yaxis : {
					min:0,
					autoscaleMargin : 1,
					tickFormatter: function(n) {
		                return Math.ceil(n);
		            }
				},
				mouse : {
					track : true,
					relative : true,
	                position: 'ss',
					trackFormatter: function(data) {
						return data.series.label + ' : (' + Math.ceil(data.x) + ', ' + Math.ceil(data.y) + ', ' + Math.ceil(data.series.data[0][2]) + ')';
					}
				},
	            grid: {
	                horizontalLines: true,
	                verticalLines: true
	            }
			});
		}
	});
</script>
<div id="${chartId }" style="height: 100%; width: 95%;margin: auto; max-height: 400px;"></div>