<%@tag import="java.util.List"%>
<%@tag import="java.util.Map"%>
<%@tag import="java.util.HashMap"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ attribute name="list" type="java.util.List" required="true"  %>
<%@ attribute name="key_field" type="java.lang.String" required="true"  %>
<%@ attribute name="var" type="java.lang.String" required="true"  %>
<%
	Map<String,Map<String,Object>> map = new HashMap<String,Map<String,Object>>();
	
	for(Object obj : list){
		Map<String,Object> row = (Map<String,Object>)obj;
		map.put((String)row.get(key_field), row);
	}
	
	request.getSession().setAttribute(var, map);
%>