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
	var d1 = [], price = 3.206, graph, i, a, b, c;

	for (i = 0; i < 50; i++) {
		a = Math.random();
		b = Math.random();
		c = (Math.random() * (a + b)) - b;
		d1.push([ i, price, price + a, price - b, price + c ]);
		price = price + c;
	}

	// Graph
	graph = Flotr.draw($("#${id}").get(0), [ d1 ], {
		candles : {
			show : true,
			candleWidth : 0.6
		},
		xaxis : {
			noTicks : 10
		}
	});

    setTitle('#${id }', '그래프 테스트2');

});
</script>


<div id="${id }" style="height: 100%; width: 100%;"></div>
