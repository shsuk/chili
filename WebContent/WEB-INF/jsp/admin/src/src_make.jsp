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
생성일 : <%=new Date() %> (WebContent/WEB-INF/jsp/layout.jsp 참조)
<!-- ************* -->
<!-- 소스 생성-->
<!-- ************* -->
<c:forEach var="map" items="${RESULT }">
	<c:if test="${map.key!='success' }">
	<c:set var="src">
		<c:forEach var="temp" items="${map.value}">
			<c:set var="isList" value="${empty(temp['value']) }"/>
		</c:forEach>
		
		<c:if test="${isList}"><%//리스트인 경우 %>
			${'<' }c:forEach var="row" items="${'$'}{${map.key } }" varStatus="status">
				<tr class="row_${'$' }{status.index + 1}">
					<c:forEach var="info" items="${map.value[0] }" >
						<c:set var="label">${info.key}_label</c:set>
						<c:set var="type">${info.key}_type</c:set>
						<c:set var="link">${info.key}_link</c:set>
						<c:set var="valid">${info.key}_valid</c:set>
						<c:set var="keyValid">${info.key}_key_valid</c:set>
						<c:set var="title">${title }<th label="${info.key}">${param[label] }</th></c:set>
						<c:if test="${!empty(param[link]) }">
							<c:set var="links">
${links }
function link_${info.key }(obj){
	var ${info.key} = getVal('${info.key}', obj);
	alert(${info.key});
}
							</c:set>
						</c:if>
						<td ${param[type]=='date' ? 'align="center"' : (param[type]=='number' ? 'align="right"' : '') }><tag:fild src_id="row" name="${info.key }" type="${param[type] }" link="${param[link] }" index="row_${'$' }{status.index + 1}" valid="${param[valid] }"  keyValid="${param[keyValid] }" /> </td>
					</c:forEach>
				</tr>
			${'<' }/c:forEach>
			<c:set var="title"><tr>${title }</tr></c:set>
		</c:if>
		<c:if test="${!isList}">	<%//상세페이지인 경우%>
			<colgroup>
				<col width="150">
				<col width="*">
			</colgroup>
		
			<c:forEach var="info" items="${map.value}">
				<c:set var="label">${info.key}_label</c:set>
				<c:set var="type">${info.key}_type</c:set>
				<c:set var="link">${info.key}_link</c:set>
				<c:set var="valid">${info.key}_valid</c:set>
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
				<tr>
					<th label="${info.key}">${param[label] }</th>
					<td><tag:fild src_id="${map.key }" name="${info.key }" type="${param[type] }" link="${param[link] }" valid="${param[valid] }"  keyValid="${param[keyValid] }" /> </td>
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



<!-- ************* -->
<!--   소스  출력  -->
<!-- ************* -->

<form id="src_form">
<textarea style="width:100%; height:400px; " name="src">
&lt;%@ page contentType="text/html; charset=utf-8"%>
&lt;%@ page language="java" pageEncoding="UTF-8"%>
&lt;%@ page trimDirectiveWhitespaces="true" %>
&lt;%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
&lt;%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
&lt;%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
&lt;%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
&lt;%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %>

&lt;sp:sp queryPath="${param.queryPath }" action="${param.action }" processorList="attach,mybatis" exception="false">
	{
		//${param.defaultValue }
	}
	
&lt;/sp:sp>
 
<script type="text/javascript">
	$(function() {
		//콘트롤 변경시 정합성 체크(미사용시 삭제)
		checkValidOnChange();
	});
	
	${links}
	
	function form_submit(){	
		var form = $('#main_form');
		//폼 정합성 체크
		if(!valid(form)){
			return;
		}
	
		var formData =$(form).serializeArray();		
		var url = form.attr('action');

		$.post(url, formData, function(response, textStatus, xhr){

			var data = $.parseJSON(response);
			
			if(data.success){
				document.location.href='list.jsp';
			}else{
				alert("처리하는 중 오류가 발생하였습니다. \n문제가 지속되면 관리자에게 문의 하세요.\n" + data.message);					
			}
			
		});
	}
</script> 

<div id="main_layer" style="margin: 0 auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc;">
	&lt;form id="main_form" action="" >
	
		
			${html }
		
	
	&lt;/form>
		<div style="clear: both;width: 100%;height: 25px;margin-top: 10px;">
			<div id="save_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;display: none;" onclick="form_submit()">저장</div>
			<div id="edit_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;" onclick="edit()">수정</div>
		</div>
</div>
<c:forEach var="data" items="${param }">
	<c:set var="paramData">${paramData }, "${data.key }":"${data.value }"</c:set>
</c:forEach>
<!-- 
{${fn:substring(paramData, 1, fn:length(paramData))}}
-->
</textarea>
</form>
</div>
