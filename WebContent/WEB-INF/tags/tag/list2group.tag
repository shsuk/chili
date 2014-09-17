<%@tag import="java.util.ArrayList"%>
<%@tag import="java.util.List"%>
<%@tag import="java.util.Map"%>
<%@tag import="java.util.HashMap"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ attribute name="list" type="java.util.List" required="true"  %>
<%@ attribute name="group_field" type="java.lang.String" required="true"  %>
<%@ attribute name="var" type="java.lang.String" required="true"  %>
<%
try{
	Map<String,List<Map<String,Object>>> map = new HashMap<String,List<Map<String,Object>>>();
	for(Object obj : list){
		Map<String,Object> row = (Map<String,Object>)obj;
		String group_ld = (String)row.get(group_field);

		List<Map<String,Object>> rows = (List<Map<String,Object>>)map.get(group_ld);
		
		if(rows==null){
			rows = new ArrayList();
		}
		rows.add(row);
		
		map.put(group_ld, rows);
	}
	
	request.getSession().setAttribute(var, map);
}catch(Exception e){
	e.printStackTrace();
}
%>