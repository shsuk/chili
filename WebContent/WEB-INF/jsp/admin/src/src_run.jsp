<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<sp:sp queryPath="${fn:substringBefore(param.queryPath,'.') }" action="${fn:substringAfter(param.queryPath,'.' ) }" processorList="mybatis" exception="false">
	{
		${param.defaultValue }
	}
</sp:sp>
<%//소스생성 %>
<c:forEach var="map" items="${RESULT }">
	<c:set var="use_set" value="use_${map.key}"/>
	<c:if test="${map.key!='success' && param[use_set]=='use'}">
	<c:set var="src">
		<c:forEach var="temp" items="${map.value}">
			<c:set var="isList" value="${empty(temp['value']) }"/>
		</c:forEach>
		
		<c:if test="${isList}"><%//리스트인 경우 %>
			<c:forEach var="info" items="${map.value[0] }" >
				<c:set var="width">${info.key}_width</c:set>
				<c:if test="${param[type]!='hidden' }">
					<c:set var="tot_width">${param[width]=='*' ? tot_width : tot_width+param[width]}</c:set>
				</c:if>
			</c:forEach>

			<c:set var="tot_width">${param['wUnit']=='wUnit' ? 100/tot_width : 1}</c:set>
	
			<c:forEach var="row" items="${map.value }" varStatus="status">
				<tr class="row_${status.index + 1}">
					<c:forEach var="info" items="${row }" >
						<c:set var="label">${info.key}_label</c:set>
						<c:set var="type">${info.key}_type</c:set>
						<c:set var="link">${info.key}_link</c:set>
						<c:set var="valid">${info.key}_valid</c:set>
						<c:set var="keyValid">${info.key}_key_valid</c:set>
						<c:set var="width">${info.key}_width</c:set>
						<c:if test="${status.index==0 }">
							<c:set var="title">${title }<th style="${param[type]=='hidden' ? 'display: none;' : ''}" label="${info.key}" width="${param[width]=='*' ? '*' : param[width]*tot_width }${tot_width==1 ? '' : '%'}">${param[label] }</th></c:set>
						</c:if>
						<c:if test="${!empty(param[link]) }">
							<c:set var="links">
${links }
function link_${info.key }(obj){
	var ${info.key} = getVal('${info.key}', obj);
	alert(${info.key});
}
							</c:set>
						</c:if>
						<td  style="${param[type]=='hidden' ? 'display: none;' : ''}" ${param[type]=='date' ? 'align="center"' : (param[type]=='number' ? 'align="right"' : '') }>
							<tag:fild2 src_id="row" name="${info.key }" type="${param[type] }" values="${row }" link="${param[link] }" index="row_${status.index + 1}" valid="${param[valid] }"  keyValid="${param[keyValid] }" /> 
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
			<c:set var="title"><tr>${title }</tr></c:set>
		</c:if>
		<c:if test="${!isList}">	<%//상세페이지인 경우%>
			<colgroup>
				<col width="150">
				<col width="*">
			</colgroup>
			<%//데이타가 없는 경우 등록 화면으로 전환%>
			<c:set var="isEdit" value="${fn:length(map.value) > 0 ? '' : 'edit()'}"/>

			<c:forEach var="info" items="${__META__[map.key]}">
				<c:set var="label">${info.key}_label</c:set>
				<c:set var="type">${info.key}_type</c:set>
				<c:set var="link">${info.key}_link</c:set>
				<c:set var="valid">${info.key}_valid[]</c:set>
				<c:set var="keyValid">${info.key}_key_valid</c:set>
				<c:if test="${!empty(param[link]) }">
					<c:set var="links">
${links }
function link_${info.key }(obj){
	var ${info.key} = getVal('${info.key}');
	alert(${info.key});
}
					</c:set>
				</c:if>
				<tr style="${param[type]=='hidden' ? 'display: none;' : ''}">
					<th label="${info.key}">${param[label] }</th>
					<td>${param[valid] }<tag:fild2 src_id="${map.key }" name="${info.key }" values="${map.value}" type="${param[type] }" link="${param[link] }" valid="${req[valid] }"  keyValid="${param[keyValid] }" /> </td>
				</tr>
			</c:forEach>
		</c:if>
	</c:set>
	<c:set var="html">
		${html }
		<table class="${isList ? 'lst' : 'vw' }" border="0" cellspacing="0" cellpadding="0"  style="margin-bottom: 10px;">
			${title }
			${src }
		</table>
	</c:set>
	</c:if>
</c:forEach>

<%-- 페이지 출력 --%>
<script type="text/javascript">
	$(function() {
		initAutoPage();
		//콘트롤 변경시 정합성 체크(미사용시 삭제)
		checkValidOnChange();
		${isEdit};
	});
	
	${links}
	

</script> 

<div id="main_layer" style="margin: 0 auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc;">
	<form id="main_form" action="" >
		
		${html }	
	</form>
	<div style="clear: both;width: 100%;height: 25px;margin-top: 10px;">
		<div id="save_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;display: none;" onclick="form_submit()">저장</div>
		<div id="edit_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;" onclick="edit()">수정</div>
	</div>
</div>

