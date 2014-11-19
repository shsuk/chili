<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/tag"%>
<%@ taglib prefix="src" tagdir="/WEB-INF/tags/src"%>
<tag:portlet width="33%">
	<tag:portletItem height="250px"><src:auto_make_src uiId="group_list" type="bf"/></tag:portletItem>
	<tag:portletItem height="250px"><src:auto_make_src uiId="code_tree" type="bf"/></tag:portletItem>
</tag:portlet>
<tag:portlet width="34%">
	<tag:portletItem height="250px"><c:import url="at/portlet/sample/chart1.jsp"/></tag:portletItem>
</tag:portlet>
<tag:portlet width="33%">
	<tag:portletItem height="250px"><c:import url="at/portlet/sample/chart2.jsp"/></tag:portletItem>
	<tag:portletItem height="250px"><c:import url="at/portlet/sample/chart3.jsp"/></tag:portletItem>
</tag:portlet>
<tag:portlet width="100%">
	<tag:portletItem height="250px"><c:import url="at/portlet/sample/chart2.jsp"/></tag:portletItem>
</tag:portlet>