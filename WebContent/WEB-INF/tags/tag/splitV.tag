<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="id" required="true" type="java.lang.String" description="아이디"%>
<%@ attribute name="bodyIndex" required="true" type="java.lang.Integer" description="태그의 body가 들어갈 분할 영억의 인덱스"%>
<h3 id="${id }_1_title" class="ui-widget-header fix_height" style="padding:2px; margin: 0px;">&nbsp;</h3>
<div id="${id }_1" class="fix_height vsplit" style=" height:400px; overflow: auto;">
	<c:if test="${bodyIndex == 1}"><jsp:doBody/></c:if>
</div>
<h3 id="${id }_2_title" class="ui-widget-header fix_height" style="padding:2px; margin: 0px;">&nbsp;</h3>
<div id="${id }_2" class="auto_height" style=" height:400px; overflow: auto; ">
	<c:if test="${bodyIndex == 2}"><jsp:doBody/></c:if>
</div>