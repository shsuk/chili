<%@tag import="kr.or.voj.webapp.utils.XmlUtil"%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="rcd_value" required="true" type="java.util.List" description="리스트 레코드(key value set))"%>

<c:set var="uuid" value="${sp:uuid()}"/>

<c:forEach var="info" items="${rcd_value[0] }" >
	<c:set var="key">${info.key}</c:set>
	<c:set var="label">${key}_label</c:set>
	<c:set var="type">${key}_type</c:set>
	<c:set var="link">${key}_link</c:set>
	<c:set var="link_type">${key}_link_type</c:set>
	<c:set var="valid">${key}_valid</c:set>
	<c:set var="keyValid">${key}_key_valid</c:set>
	<c:set var="width">${key}_width</c:set>
	<c:set var="maxlength">${key}_maxlength</c:set>
	
	<c:choose>
		<c:when test="${ui_field[type]=='upperFld' }">
			<c:set var="upperFld">${key}</c:set>
			<c:set var="rootId">${ui_field[label]}</c:set>
		</c:when>
		<c:when test="${ui_field[type]=='codeFld' }">
			<c:set var="codeFld">${key}</c:set>
		</c:when>
		<c:when test="${ui_field[type]=='titleFld' }">
			<c:set var="titleFld">${key}</c:set>
		</c:when>
		<c:when test="${ui_field[type]=='idFld' }">
			<c:set var="idFld">${key}</c:set>
		</c:when>
	</c:choose>
	
	<c:if test="${!empty(ui_field[link]) }">
		<c:set var="link_value">${ui_field[link_type] }('#tree_${uuid }', <tag:el source="${ui_field[link] }" param="${rcd_value[0] }"/>)</c:set>
	</c:if>
</c:forEach>
<script type="text/javascript">
$(function(){

	var treeData = ${sp:list2tree(rcd_value, upperFld, codeFld, titleFld, idFld, rootId) };
	
    $("#tree_${uuid }").dynatree({
        onActivate: function(node) {
            ${link_value};
        },
        persist: true,
        children: treeData
    });
    
    $('.dynatree-container').css('overflow', 'visible');
});
	
</script> 
<div id="tree_${uuid }"></div>
