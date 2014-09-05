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

<c:set var="isInit" value="${!empty(param.col_count)}"/>
<c:set var="col_count" value="${empty(param.col_count) ? 4 : param.col_count}"/>

<span  style="float: right;"> 
	<span style="float: left;"><b>Col Count : </b></span><input type="text" name="col_count" value="${col_count }"  class="spinner" style="width: 20px;"/>
	<span style="float: left;"><b>Unit of width : </b><tag:check_array name="wUnit" codes="wUnit=%"  checked="${param['wUnit'] }" /></span>
</span>

<table id="resizable_container"  style="clear: both;"><tr><td valign="top">
	<table style="width:800px ;" class="lst" border="0" cellspacing="0" cellpadding="0" >
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
				<c:forEach var="temp" items="${map.value}">
					<c:set var="isList" value="${empty(temp['value']) ? 'Y' : '' }"/>
				</c:forEach>
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
						<c:set var="label">${info.key}_label</c:set>
						<c:set var="type">${info.key}_type</c:set>
						<c:set var="link">${info.key}_link</c:set>
						<c:set var="valid">${info.key}_valid</c:set>
						<c:set var="keyValid">${info.key}_key_valid</c:set>
						<c:set var="width">${info.key}_width</c:set>
						
						<c:set var="isInit" value="${!empty(param[label])}"/>
	
						<td class="label" label="${info.key}" title='${info }'>
							${info.key }
						</td>
						<td>
							<div class="field_name${isList } drg${isList } th${isList }" type="field_name" title="${info.key }" style="border${isList }: 1px solid #c5dbec; height: 20px;cursor${isList }: move;">
								${isList=='Y' ? '' : '☺' }<input class="field_label" type="text" name="${label}" style="width: 70px;" value="${isInit ?  param[label] : info.key }">
							</div>
						</td>
						<td>
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
							
							<div class="field${isList } drg${isList }" type="field"  title="${info.key }" style="border${isList }: 1px solid #c5dbec; height: 20px;cursor${isList }: move;">
								${isList=='Y' ? '' : '☺' }<tag:select_array codes="text=텍스트,date=날짜,number=숫자,select=콤보,check=체크박스,radio=라디오박스,hidden=Hidden,file=첨부파일,files=첨부파일들,view=---------,label=라벨,date_view=날짜,datetime_view=날짜시간,number_view=숫자,code=name" name="${type }" selected="${fieldType }" style="width: 70px;" attr=" title='${info.value }'"/>
							</div>
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
</td><td valign="top"  >
	<table class="tpl">
		<tr>
			<td colspan="100" style="text-align: center; background: #D9E5FF;">
				<b>UI 디자인</b><br>☺아이콘을 드래그하여 배치하세요.
				<br>빈공간은 삭제되니 콘트롤 사이즈를 조절하여 영역을 확보하세요.
			</td>
		</tr>
		<c:forEach begin="1" end="10" step="1">
			<tr >
				<c:forEach begin="1" end="${col_count }" step="1">
					<td class="to_field_td" style="width: 100px;"><div class="to_field" style="height: 20px; margin: 0px ;"></div></td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	<div style="clear: both;width: 100%;height: 25px;margin-top: 10px;">
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="makeUi()" >미리보기</div>
		<div class=" ui-widget-header ui-corner-all  m_3" style="float: left; cursor:pointer;  margin-left: 10px; padding: 3px;" onclick="editUi()" >디자인</div>
		<div class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;" onclick="edit()">수정</div>
	</div>
</td></table>