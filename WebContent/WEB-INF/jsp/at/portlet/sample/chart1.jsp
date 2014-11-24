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
		var d1 = [ [ 1, 4 ] ], d2 = [ [ 1, 3 ] ], d3 = [ [ 1, 1.03 ] ], d4 = [ [ 1, 3.5 ] ], graph;

		graph = Flotr.draw($("#${id}").get(0), [ {
			data : d1,
			label : 'Comedy'
		}, {
			data : d2,
			label : 'Action'
		}, {
			data : d3,
			label : 'Romance',
			pie : {
				explode : 50
			}
		}, {
			data : d4,
			label : 'Drama'
		} ], {
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
				track : true
			},
			legend : {
				position : 'se',
				backgroundColor : '#D2E8FF'
			}
		});

		setTitle('#${id }', 'Pie 그래프 테스트');

	});
</script>


<div id="${id}" style="height: 100%; width: 100%;"></div>
