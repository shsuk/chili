<%@page import="org.bouncycastle.asn1.x509.qualified.TypeOfBiometricData"%>
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

<c:set var="isInit" value="${!empty(param.isInit)}"/>

<span  style="float: right;"> 
	<span style="float: left;"><b>Unit of width : </b></span><tag:check_array name="wUnit" codes="wUnit=%"  checked="${param['wUnit'] }" />
</span>

<table  style="clear: both;"><tr><td valign="top">
<table style="width: ;" class="lst" border="0" cellspacing="0" cellpadding="0" >
	<colgroup>
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="70">
		<col width="250">
		<col width="130">
		<col width="50">
	</colgroup>
	<c:forEach var="map" items="${RESULT }">
		
		<c:if test="${map.key!='success' }">
			<tr>
				<td colspan="10" style="text-align: left; background: #D9E5FF;">
					<span  style="float: left;"><b>레코드 아이디</b> : ${map.key}</span>
					<c:set var="use_set" value="use_${map.key}"/>
					<span  style="float: right;"><tag:check_array name="${use_set}" codes="use=사용"  checked="${isInit ? param[use_set] : 'use' }" /></span>
				</td>
			</tr>
			<tr>
				<th class="ui-state-default ui-th-column ui-th-ltr">필드</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">필드명</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">타입</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">옵션</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">정합성</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">key필터</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">Width</th>
			</tr>
			
			<c:forEach var="info" items="${__META__[map.key]}">
				<tr>
					<td class="label" label="${info.key}" title='${info }'>
						<div class="field_name" title="필드명" type="field_name">${info.key }</div>
						<div class="field" title="필드값" type="field" style="border: 1px solid #c5dbec; height: 20px;">${info.key }</div>
					</td>
					<c:set var="label">${info.key}_label</c:set>
					<c:set var="type">${info.key}_type</c:set>
					<c:set var="link">${info.key}_link</c:set>
					<c:set var="valid">${info.key}_valid</c:set>
					<c:set var="keyValid">${info.key}_key_valid</c:set>
					<c:set var="width">${info.key}_width</c:set>
					
					<c:set var="isInit" value="${!empty(param[label])}"/>

					<td><input class="field_label" type="text" name="${label}" style="width: 100%" value="${isInit ?  param[label] : info.key }"></td>
					<td title="${info.value }">
						<c:set var="fieldType" value="${param[type] }"/>
						<c:if test="${!isInit}">
							<c:set var="fieldType">
								<c:choose>
									<c:when test="${info.value == 'INTEGER' || info.value == 'BIGINT'}">number</c:when>
									<c:when test="${info.value == 'TIMESTAMP'}">date</c:when>
									<c:otherwise>text</c:otherwise>
								</c:choose>
							</c:set>
						</c:if>
						
						<c:set var="tmpFieldType">$(info.key)</c:set>
						<tag:select_array codes="text=텍스트,date=날짜,number=숫자,select=콤보,check=체크박스,radio=라디오박스,hidden=Hidden,file=첨부파일,files=첨부파일들,view=---------,label=라벨,date_view=날짜,datetime_view=날짜시간,number_view=숫자,code=name" name="${type }" selected="${fieldType }" style="width: 100%"/>
					</td>
					<td>
						<tag:check_array name="${link}" codes="link=링크"  checked="${param[link] }" />
					</td>
					<td>
						<c:set var="valids">${valid}[]</c:set>
						<c:set var="validValue">notempty${fieldType=='date' ? ',date' : '' }</c:set>
						<tag:check_array name="${valid}" codes="notempty=필수입력,date=날짜,rangedate=기간날짜,ext:jpg:jpeg:png:gif=업로드 ext"  checked="${isInit ? req[valids] : validValue}" />
					</td>
					<td><tag:radio_array name="${keyValid}" codes="alpa=영문,numeric=숫자,alpa_numeric=영숫자"  checked="${isInit ? param[keyValid] : (fieldType=='number' ? 'numeric' : '') }" /></td>
					<td><input type="text" name="${width}" style="width: 100%" value="${isInit ? param[width] : 10 }"></td>
				</tr>
			</c:forEach>

		</c:if>
	</c:forEach>
</table>
</td><td valign="top">
<table  class="vw" style=" width: 770px;">
	<c:forEach begin="1" end="30" step="1">
		<tr>
			<c:forEach begin="1" end="6" step="1">
				<td><div class="to_field" style="height: 20px; margin: 0px ;"></div></td>
			</c:forEach>
		</tr>
	</c:forEach>
</table>
</td></table>