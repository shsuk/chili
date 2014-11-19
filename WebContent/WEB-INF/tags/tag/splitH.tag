<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="id" required="true" type="java.lang.String" description="아이디"%>
<%@ attribute name="splitCount" required="true" type="java.lang.Integer" description="분할갯수"%>
<%@ attribute name="bodyIndex" required="true" type="java.lang.Integer" description="태그의 body가 들어갈 분할 영억의 인덱스"%>
<table  class="" style="width:100%;" >
	<tr class="split_containment">
		<c:forEach begin="1" end="${splitCount-1 }" varStatus="status">
			<td valign="top" class="hsplit"  style="width:300px;padding-right: 8px;">
				<h3 id="${id }_${status.index }_title" class="fix_height ui-widget-header" style="padding:2px; margin: 0px;">&nbsp;</h3>
				<div id="${id }_${status.index }" class=" auto_height" style=" overflow: auto;">
					<c:if test="${bodyIndex == status.index}"><jsp:doBody/></c:if>
				</div>
			</td>
		</c:forEach>
		<td valign="top">
			<h3 id="${id }_${splitCount }_title" class="fix_height ui-widget-header" style="padding:2px; margin: 0px;">&nbsp;</h3>
			<div id="${id }_${splitCount }" class="auto_height" style="overflow: auto; ">
				<c:if test="${bodyIndex == splitCount}"><jsp:doBody/></c:if>
			</div>
		</td>
	</tr>
</table>	
