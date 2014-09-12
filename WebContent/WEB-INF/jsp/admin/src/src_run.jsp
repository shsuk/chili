<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<sp:sp queryPath="ui" action="design" processorList="mybatis" exception="false"/>
<c:set scope="request" var="ui_design" value="${ui.UI_DESIGN }"/>
<c:set scope="request" var="ui_field" value="${sp:str2jsonObj(ui.UI_FIELD) }"/>

<sp:sp queryPath="${fn:substringBefore(param.queryPath,'.') }" action="${fn:substringAfter(param.queryPath,'.' ) }" processorList="mybatis" exception="true">
	{
		${param.defaultValue }
	}
</sp:sp>
<%//소스생성 %>
<c:forEach var="map" items="${RESULT }">
	<c:set var="use_set" value="use_${map.key}"/>
	<c:if test="${map.key!='success'}">
		<c:set scope="request" var="title" value=""/>
		<c:set var="isList" value="${sp:isType(map.value,'list') }"/>
		<c:set var="src">
			<c:choose>
				<c:when test="${ui_field[use_set]!='use'}">
					<src:mk_view rcd_key="${map.key }" rcd_value="${map.value }"/>
				</c:when>
				<c:when test="${isList}"><%//리스트인 경우 %>
						<src:mk_list rcd_key="${map.key }" rcd_value="${map.value }"/>
				</c:when>
				<c:otherwise><%//상세페이지인 경우%>
					<src:mk_view rcd_key="${map.key }" rcd_value="${map.value }"/>
				</c:otherwise>
			</c:choose>
		</c:set>
	
		<c:set var="html">
			${html }
			<c:if test="${ui_field[use_set]=='use'}">
				<table class="${isList ? 'lst' : 'vw' }" border="0" cellspacing="0" cellpadding="0"  style="margin-bottom: 10px;">
					${title }
					${src }
				</table>
			</c:if>
			${paging }
			<c:set scope="request" var="paging" value=""/>
		</c:set>
	</c:if>
</c:forEach>

<%-- 페이지 출력 --%>
<script type="text/javascript">
	$(function() {
		$['isEditMode'] = false;
		initAutoPage();
		//콘트롤 변경시 정합성 체크(미사용시 삭제)
		checkValidOnChange();
		${empty(ui_design) ? 'sowDefaultUi()' : 'showRelocationUi()' };
		
		${isEdit};
		var auto_generated_uI = $('#auto_generated_uI');
		$('.tpl', auto_generated_uI).css({width:'100%'});
		$('td', auto_generated_uI).css({width:''});
		$('.th', auto_generated_uI).css({width:'150px'});
	});
	
	${links}
	
</script> 
<div id="auto_generated_uI" style="margin: 0 auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc; display: none;">
	<form id="body_form" action="" method="post" enctype="multipart/form-data">
		${ui_design }
		<div id="default_auto_generated_uI" style="margin: 0 auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc;display: none;">
				<input type="hidden" name="queryPath" value="${fn:substringBefore(ui_field.querypath,'.') }">
				${html }	
		</div>
	</form>
	<div style="clear: both;width: 100%;height: 25px;margin-top: 10px;">
		<div id="save_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;display: none;" onclick="form_submit()">저장</div>
		<div id="edit_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;" onclick="edit()">수정</div>
	</div>
	
	<iframe name="submit_frame" style="width: 0px; height: 0px; display: none;"></iframe>
</div>
