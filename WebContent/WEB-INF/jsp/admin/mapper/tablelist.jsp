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
<sp:sp var="RESULT" queryPath="" action="" processorList="tableInfo" exception="false"/>
<table>
	<c:forEach var="row" items="${list }">
		<tr>
			<td><div style="cursor: pointer;" onclick="loadTableInfo('${row.table_name }')">${row.table_name }</div></td>
		</tr>
	</c:forEach>
</table>
