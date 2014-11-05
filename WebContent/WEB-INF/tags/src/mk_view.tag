<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="rcd_key" required="true" type="java.lang.String" description="리스트 레코드(key value set))"%>
<%@ attribute name="rcd_value" required="true" type="java.util.Map" description="리스트 레코드(key value set))"%>
<colgroup>
	<col width="150">
	<col width="*">
</colgroup>
<%//데이타가 없는 경우 등록 화면으로 전환%>
<c:set var="isEdit" value="${fn:length(rcd_value) > 0 ? '' : 'edit()'}"/>

<c:forEach var="info" items="${__META__[rcd_key]}">
	<c:set var="label">${info.key}_label</c:set>
	<c:set var="type">${info.key}_type</c:set>
	<c:set var="link">${info.key}_link</c:set>
	<c:set var="link_type">${info.key}_link_type</c:set>
	<c:set var="valid">${info.key}_valid[]</c:set>
	<c:set var="keyValid">${info.key}_key_valid</c:set>
	<c:set var="maxlength">${info.key}_maxlength</c:set>

	<c:if test="${!empty(ui_field[link]) }">
		<c:set var="links">
			${links }
			function link_${info.key }(obj){
				var ${info.key} = getVal('${info.key}');
				alert(${info.key});
			}
		</c:set>
	</c:if>
	<c:choose>
		<c:when test="${ui_field[type]=='total_record'}">
			<c:if test="${empty(paging) }">
				<c:set scope="request" var="paging">
					<src:paging totCount="${rcd_value[info.key]}" _start="${rcd_value['_start'] }" rows="${rcd_value['_rows']}"/>
				</c:set>
			</c:if>
		</c:when>
		<c:otherwise>
			<tr style="${ui_field[type]=='hidden' ? 'display: none;' : ''}">
				<th label="${info.key}"><span class="field_names" name="${info.key}">${ui_field[label] }</span></th>
				<td><span class="fields" name="${info.key}"><src:mk_field name="${info.key }" values="${rcd_value}" type="${ui_field[type] }" link="${ui_field[link] }" link_type="${ui_field[link_type] }" valid="${req[valid] }"  keyValid="${ui_field[keyValid] }" maxlength="${ui_field[maxlength] }" label="${ui_field[label] }"/></span></td>
			</tr>
		</c:otherwise>
	</c:choose>
</c:forEach>
