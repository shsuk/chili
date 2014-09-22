<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="rcd_key" required="true" type="java.lang.String" description="리스트 레코드(key value set))"%>
<%@ attribute name="rcd_value" required="true" type="java.util.List" description="리스트 레코드(key value set))"%>
<c:forEach var="info" items="${rcd_value[0] }" >
	<c:set var="width">${info.key}_width</c:set>
	<c:if test="${ui_field[type]!='hidden' }">
		<c:set var="tot_width">${ui_field[width]=='*' ? tot_width : tot_width+ui_field[width]}</c:set>
	</c:if>
</c:forEach>

<c:set var="tot_width">${ui_field['wUnit']=='wUnit' ? 100/tot_width : 1}</c:set>

<c:forEach var="row" items="${rcd_value }" varStatus="status">
	<tr class="row_${status.index + 1}">
		<c:forEach var="info" items="${row }" >
			<c:set var="key">${info.key}</c:set>
			<c:set var="label">${key}_label</c:set>
			<c:set var="type">${key}_type</c:set>
			<c:set var="link">${key}_link</c:set>
			<c:set var="link_type">${key}_link_type</c:set>
			<c:set var="valid">${key}_valid</c:set>
			<c:set var="keyValid">${key}_key_valid</c:set>
			<c:set var="width">${key}_width</c:set>
			<c:set var="maxlength">${key}_maxlength</c:set>
			<c:if test="${status.index==0 }">
				<c:set scope="request" var="title">${title }<th style="${ui_field[type]=='hidden' ? 'display: none;' : ''}" label="${key}" width="${ui_field[width]=='*' ? '*' : ui_field[width]*tot_width }${tot_width==1 ? '' : '%'}">${ui_field[label] }</th></c:set>
			</c:if>

			<c:choose>
				<c:when test="${type!='total_record'}">
				<!-- 캐쉬처리 -->
					<td  style="${ui_field[type]=='hidden' ? 'display: none;' : ''}" ${fn:startsWith(ui_field[type],'date') || ui_field[type] == 'select' || ui_field[type] == 'code' ? 'align="center"' : (fn:startsWith(ui_field[type],'number') ? 'align="right"' : '') }>
						<src:mk_field name="${key }" type="${ui_field[type] }" values="${row }" link="${ui_field[link] }"  link_type="${ui_field[link_type] }" valid="${ui_field[valid] }"  keyValid="${ui_field[keyValid] }" maxlength="${ui_field[maxlength] }"/> 
					</td>
				</c:when>
				<c:otherwise>
					<c:if test="${empty(paging) }">
						<c:set scope="request" var="paging">
							<src:paging totCount="${rcd_value[key]}" _start="${rcd_value['_start'] }" rows="${rcd_value['_rows']}"/>
						</c:set>
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</tr>
</c:forEach>
<c:set  scope="request" var="title"><tr>${title }</tr></c:set>
