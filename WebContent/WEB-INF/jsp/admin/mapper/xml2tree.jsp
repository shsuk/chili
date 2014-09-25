<%@page import="kr.or.voj.webapp.utils.XmlUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %>
<script type="text/javascript">
	//<c:catch var="errormsg" >
		treeData = ${sp:xml2Tree(param.xml) };
	//</c:catch>
	//<c:if test = "${errormsg != null}">
		[];
		alert("${errormsg}");
	//</c:if>
</script> 
	