<%@tag import="org.apache.poi.util.SystemOutLogger"%>
<%@tag import="java.util.Map"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="uiId" type="java.lang.String" description="UI ID"%>
<%@ attribute name="type" required="true" type="java.lang.String" description="bf=버튼&폼, f=폼, nf=폼없음, t=테이블, trh=헤더포함tr단위, tr=tr단위"%>
<%@ attribute name="ui_type" required="false" type="java.lang.String" description="uiType을 동적으로 설정한다. unuse,use,tree,chart_.."%>
<c:set var="UI_ID" value="${empty(uiId) ? UI_ID : uiId}"/>

<sp:sp var="ui_info" queryPath="ui" action="design" processorList="mybatis" exception="false">{ui_id:'${UI_ID}'}</sp:sp>
<c:set var="page_id" value="${sp:uuid()}"/>
<c:set scope="request" var="ui_design" value="${ui.UI_DESIGN }"/>
<c:set scope="request" var="ui_field" value="${sp:str2jsonObj(ui.UI_FIELD) }"/>

<sp:sp var="RESULT" queryPath="${fn:substringBefore(ui.query_path,'.') }" action="${fn:substringAfter(ui.query_path,'.' ) }" processorList="mybatis" exception="true"/>

<%//소스생성 %>
<c:forEach var="map" items="${RESULT }">
	<c:set var="use_set" value="use_${map.key}"/>
	
	<c:if test="${map.key!='success' && map.key!='JSON'}">
		<c:set scope="request" var="title" value=""/>
		<c:set var="isList" value="${sp:isType(map.value,'list') }"/>
		<c:set var="uiType" value="${empty(ui_type) ? ui_field[use_set] : ui_type }"/>
		<c:set var="src"><%// 타입별 ui생성 %>
			<c:choose>
				<c:when test="${uiType=='unuse'}">
					<src:mk_view rcd_key="${map.key }" rcd_value="${map.value }"/>
				</c:when>
				<c:when test="${uiType=='tree'}"><%//TREE인 경우 %>
					<c:set var="ui_title"><tag:el source="${ui.ui_title}" param="${map.value[0]}"/></c:set>
					<src:mk_tree rcd_value="${map.value }"/>
				</c:when>
				<c:when test="${isList}"><%//리스트인 경우 %>
					<c:set var="ui_title"><tag:el source="${ui.ui_title}" param="${map.value[0]}"/></c:set>
					<src:mk_list rcd_key="${map.key }" rcd_value="${map.value }"/>
				</c:when>
				<c:otherwise><%//상세페이지인 경우%>
					<c:set var="ui_title"><tag:el source="${ui.ui_title}" param="${map.value}"/></c:set>
					<src:mk_view rcd_key="${map.key }" rcd_value="${map.value }"/>
				</c:otherwise>
			</c:choose>
		</c:set>

		<c:if test="${fn:startsWith(uiType,'chart_')}"><%//그래프인 경우 그래프 생성(그래프는 그래프와 표를 둘다 생성한다.)%>
			<c:set var="graph">
				<c:set var="type">etc</c:set>
				<c:set var="ui_title"><tag:el source="${ui.ui_title}" param="${map.value[0]}"/></c:set>
				
				<src:mk_chart chartType="${uiType}" rcd_value="${map.value }" />
			</c:set>
		</c:if>
	
		<c:set var="html">
			${html }

			<c:if test="${uiType=='tree'}"><%//TREE인 경우 %>
				${src }
			</c:if>
			<c:if test="${uiType!='tree' && uiType!='unuse'}"><%//TREE가 아닌 경우 %>
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

<c:set var="buton_Html">
	<div style="clear: both; height: 25px; margin-top: 10px;padding:3px; ">
		<c:if test="${!empty(ui.add_param) }">
			<div class="add_btn ui-widget-header ui-corner-all btn_right" style="" onclick="${ui.add_type}(${ui.add_param})">등록</div>
		</c:if>
		<c:forEach var="btn" items="${fn:split(ui.use_btn,',') }">
			<c:choose>
				<c:when test="${btn=='L' }">
					<div class="close_btn ui-widget-header ui-corner-all btn_right" style=" " onclick="closePop('#auto_generated_uI_${page_id}')">닫기</div>
				</c:when>
				<c:when test="${btn=='C' }">
					<div class="cancel_btn ui-widget-header ui-corner-all btn_right" style=" display: none;" onclick="cancel('#auto_generated_uI_${page_id}')">취소</div>
				</c:when>
				<c:when test="${!empty(add_param) }">
					<div class="add_btn ui-widget-header ui-corner-all btn_right" style="" onclick="${ui.add_type}(${ui.add_param})">등록</div>
				</c:when>
				<c:when test="${btn=='U' }">
					<div class="edit_btn ui-widget-header ui-corner-all btn_right" style="" onclick="edit('#auto_generated_uI_${page_id}')">수정</div>
				</c:when>
				<c:when test="${btn=='D' }">
					<div class="del_btn ui-widget-header ui-corner-all btn_right" style="" onclick="del('#auto_generated_uI_${page_id}')">삭제</div>
				</c:when>
				<c:when test="${btn=='S' }">
					<div class="save_btn ui-widget-header ui-corner-all btn_right" style=" display: none;" onclick="form_submit('#form_${page_id}')">저장</div>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
</c:set>

<c:set var="script">
<script type="text/javascript">
	$(function() {
		if('${empty(ui_design)}' == 'true'){
			sowDefaultUi("${page_id}");
		}else{
			showRelocationUi("#auto_generated_uI_${page_id}");
		}
		
		var auto_generated_uI = $('#auto_generated_uI_${page_id}');
		$('.tpl', auto_generated_uI).css({width:'100%'});
		$('td', auto_generated_uI).css({width:''});
		$('.th', auto_generated_uI).css({width:'150px'});
		
		setTitle('#auto_generated_uI_${page_id}','${ui_title}');
	});

	${links}
</script> 
</c:set>

<%-- 페이지 출력 --%>
<c:choose>
	<c:when test="${type == 'etc'}"><%//그래프인 경우%>
		<div id="auto_generated_uI_${page_id}"  style="height: 100%; width: 100%;">	
			${graph }
			<div class="sheet" style="margin: 10px auto; display: none;"><br>${html }</div>		
		</div>
		${script }
	</c:when>
	<c:when test="${empty(type) || type=='f' || type=='bf' }">
		${script }
		<div id="auto_generated_uI_${page_id}" type="page" style=" display: none;">
			<form id="form_${page_id}" action="" method="post" enctype="multipart/form-data">
			
			${ui_design }
			<div id="default_auto_generated_uI_${page_id}" style=" display: none;">
				<input type="hidden" name="ui_id" value="${UI_ID }">
				<input type="hidden" name="action_type" value="">
				${html }
			</div>
			
			</form>
			${type=='bf' ? buton_Html : '' }
			<iframe name="submit_frame" style="width: 0px; height: 0px; display: none;"></iframe>
			
		</div>
	</c:when>
	<c:when test="${type=='nf' }">
		<div id="auto_generated_uI_${page_id}" type="page" style=" display: none;">			
			${ui_design }
			<div id="default_auto_generated_uI_${page_id}" style=" display: none;">
				${html }
			</div>			
		</div>
		${script }
	</c:when>
	<c:when test="${type=='t' }">
		<table id="auto_generated_uI_${page_id}" class="${isList ? 'lst' : 'vw' }" border="0" cellspacing="0" cellpadding="0"  style="margin-bottom: 10px;">
			<thead>
				${title }
			</thead>
			<tbody>
				${src }
			</tbody>
		</table>
	</c:when>
	<c:when test="${type=='trh' }">
		<thead>
			${title }
		</thead>
		<tbody>
			${src }
		</tbody>
	</c:when>
	<c:when test="${type=='tr' }">
		${src }
	</c:when>
</c:choose>



