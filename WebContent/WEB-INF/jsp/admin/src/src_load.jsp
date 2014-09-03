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
<sp:sp queryPath="${param.queryPath }" action="${param.action }" processorList="mybatis" exception="false">
	{
		${param.defaultValue }
	}
</sp:sp> 

<table  class="lst" border="0" cellspacing="0" cellpadding="0">
	<colgroup>
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="*">
	</colgroup>
	<c:forEach var="map" items="${RESULT }">
		
		<c:if test="${map.key!='success' }">
			<tr>
				<td class="ui-state-default ui-th-column ui-th-ltr" colspan="10" style="text-align: left;">레코드 아이디 : ${map.key}</td>
			</tr>
			<tr>
				<th class="ui-state-default ui-th-column ui-th-ltr">필드</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">필드명</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">타입</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">옵션</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">정합성</th>
				<th class="ui-state-default ui-th-column ui-th-ltr">key필터</th>
			</tr>
			
			<c:forEach var="info" items="${__META__[map.key]}">
				<tr>
					<td label="${info.key}" title='${info }'><div class="field">${info.key }</div></td>
					<c:set var="label">${info.key}_label</c:set>
					<c:set var="type">${info.key}_type</c:set>
					<c:set var="link">${info.key}_link</c:set>
					<c:set var="valid">${info.key}_valid</c:set>
					<c:set var="keyValid">${info.key}_key_valid</c:set>
					<td><input type="text" name="${label}" style="width: 100%" value="${empty(param[label]) ? info.key : param[label] }"></td>
					<td>
						<c:set var="fieldType" value="${param[type] }"/>
							
						<c:if test="${empty(fieldType) }">
							<c:set var="fieldType">
								<c:choose>
									<c:when test="${info.value == 'INTEGER'}">number</c:when>
									<c:when test="${info.value == 'TIMESTAMP'}">date</c:when>
									<c:otherwise>text</c:otherwise>
								</c:choose>
							</c:set>
						</c:if>
						<c:set var="tmpFieldType">$(info.key)</c:set>
						<tag:select_array codes="text=텍스트,date=날짜,number=숫자,select=콤보,check=체크박스,radio=라디오박스,hidden=Hidden,file=첨부파일,files=첨부파일들,view=---------,label=라벨,date_view=날짜,number_view=숫자,code=name" name="${type }" selected="${fieldType }" style="width: 100%"/>
					</td>
					<td>
						<tag:check_array name="${link}" codes="link=링크"  checked="${param[link] }" />
					</td>
					<td>
						<c:set var="valids">${valid}[]</c:set>
						<tag:check_array name="${valid}" codes="notempty=필수입력,date=날짜,rangedate=기간날짜,ext:jpg:jpeg:png:gif=업로드 ext"  checked="${req[valids] }" />
					</td>
					<td><tag:radio_array name="${keyValid}" codes="alpa=영문,numeric=숫자,alpa_numeric=영숫자"  checked="${param[keyValid] }" /></td>
				</tr>
			</c:forEach>
			
	
			
		</c:if>
	</c:forEach>
</table>

