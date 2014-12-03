<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ attribute name="height" required="true" type="java.lang.String" description="포들릿 아이템 높이"%>
<c:set var="portlet_id" scope="request" value="${empty(portlet_id) ? 1 :portlet_id + 1 }"/>
<c:set var="id" value="id${sp:uuid() }"/>

<div id="portlet_${portlet_id}" class="portlet no_init_portlet_item">
	<div class="portlet-item"   >
		<div class="portlet-header"><span id="${id }_title"></span></div>
		<div class="portlet-content" style="height:${height}" id="${id }">
			<c:catch var="ex">
				<jsp:doBody/>
			</c:catch>
			${ex}
		</div>
	</div>
</div>