<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="id" type="java.lang.String" required="true" description="메세지 아이디"%>
<%@ attribute name="lang" type="java.lang.String" description="언어코드"%>
<c:if test="${empty(_lang) }">
	<sp:sp queryPath="ui" action="lang" processorList="mybatis" exception="false"/>
	<tag:list2map var="_lang" key_field="message_id" list="${rows }"/>
</c:if>
${empty(_lang[id]) ? id : _lang[id]['message']}
