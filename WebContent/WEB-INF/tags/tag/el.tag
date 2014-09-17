<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="source" type="java.lang.String" required="true"%>
<%@ attribute name="param" type="java.util.Map" %>
<%
	if(param!=null){
		for(Object key : param.keySet()){
			Object data = param.get(key);
			
			jspContext.setAttribute(((String)key).toLowerCase(), data);
		}		
	}

	Object obj = jspContext.getExpressionEvaluator().evaluate(source, String.class, jspContext.getVariableResolver(), null);
	out.print(obj);
%>