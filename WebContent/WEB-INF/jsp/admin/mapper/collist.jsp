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
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<sp:sp var="RESULT" queryPath="" action="" processorList="tableInfo" exception="false">
	{
		table_name : '${param.table_name }'
	}
</sp:sp>

<table class="lst">
	<colgroup>
		<col width="120">
		<col width="80">
		<col width="60">
		<col width="30">
		<col width="*">
		<col width="100">
	</colgroup>
	<thead>
		<tr>
			<th>이름</th>
			<th>타입</th>
			<th>길이</th>
			<th>Key</th>
			<th>노드경로</th>
			<th>노드값1</th>
		</tr>
	</thead>
	<tbody id="field_list" >
		<c:forEach var="row" items="${list }">
			<tr class="droppable fld_${row.column_name }">
				<td><input type="text" class="col_name" readonly="readonly" name="col_name" value="${row.column_name }" style="width: 99%;"></td>
				<td>${row.type_name }</td>
				<td>${row.column_size }, ${row.decimal_digits }</td>
				<td><input type="checkbox" class="key_fld" name="key_fld" value="${row.column_name }"></td>
				<td><input class="xml_path" name="xml_path" style="width: 99%;"></textarea></td>
				<td class="node_value"></td>
			</tr>
		</c:forEach>
	</tbody>
</table>