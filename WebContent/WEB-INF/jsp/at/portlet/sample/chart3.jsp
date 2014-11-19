<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/tag"%>
<c:set var="id" value="id${sp:uuid() }"/>
<script type="text/javascript">
	$(function() {

		var horizontal = false,
		// Show horizontal bars
		d1 = [],
		// First data series
		d2 = [],
		// Second data series
		point, // Data point variable declaration
		i;

		for (i = 1; i < 5; i++) {

			if (horizontal) {
				point = [ Math.ceil(Math.random() * 10), i ];
			} else {
				point = [ i, Math.ceil(Math.random() * 10) ];
			}

			d1.push(point);

			if (horizontal) {
				point = [ Math.ceil(Math.random() * 10), i + 0.4 ];
			} else {
				point = [ i+0.4, Math.ceil(Math.random() * 10) ];
			}

			d2.push(point);
		};

		// Draw the graph
		Flotr.draw($("#${id}").get(0), [ {data:d1,label:'a1'}, {data:d2,label:'a2'} ], {
			bars : {
				show : true,
				horizontal : horizontal,
				shadowSize : 0,
				barWidth : 0.4
			},
			legend: {
	            position: 'ne',
	            // Position the legend 'south-east'.
	            //labelFormatter: labelFn,
	            // Format the labels.
	            backgroundColor: '#D2E8FF' // A light blue background color.
	        },
			mouse : {
				track : true,
				relative : true
			},
			xaxis : {
				noTicks: 4,
	            // Display 7 ticks.
	            tickFormatter: function(n) {
	                return '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ' + Math.ceil(n) + '월';
	            }
			},
			yaxis : {
				min : 0,
				autoscaleMargin : 1
			}
		});

		setTitle('#${id }', '그래프 테스트3');
	});
</script>

<div id="${id}" style="height: 100%; width: 100%;"></div>
