<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="src_id" type="java.lang.String" description="레코드 아이디"%>
<%@ attribute name="type" type="java.lang.String" description="콘트롤 타입"%>
<%@ attribute name="name" type="java.lang.String" description="필드명"%>
<%@ attribute name="values" type="java.util.Map" description="필드값"%>
<%@ attribute name="link" type="java.lang.String" description="Edit"%>
<%@ attribute name="index" type="java.lang.String" description="${src_id} index"%>
<%@ attribute name="valid" type="java.lang.String" description="필드 정합성 체크 정보"%>
<%@ attribute name="keyValid" type="java.lang.String" description="필드 정합성 체크 정보"%>
<span class="field">
<c:if test="${!empty(link) }">
	<c:set var="linkName">onclick="link_${name }(this)"</c:set>
	<c:set var="linkClass">link</c:set>
</c:if>
<c:if test="${!empty(valid) }"><c:set var="valid">valid="${valid }"</c:set></c:if>
<c:if test="${!empty(keyValid) }"><c:set var="keyValid">key_press="${keyValid }"</c:set></c:if>

<c:if test="${link=='link'}">
	<span name="${name }" value="${values[name]}"  ${linkName } class="${linkClass }" ${src_id}_index="${index }">
</c:if>

<c:choose>
	<c:when test="${type=='text'}">
		<input class="in_control" type="text" name="${name }"  value="${values[name]}" style="width: 90%;" maxlength="" ${valid } ${keyValid } >
	</c:when>
	<c:when test="${type=='label'}">
		<span name="${name }" ${linkName } class="${linkClass }">${values[name]}</span>
	</c:when>
	<c:when test="${type=='date'}">
		<c:set var="name_fmt">${name }@yyyy-MM-dd</c:set>
		<input class="in_control datepicker" type="text" name="${name }" value="${values[name_fmt]}" style="width: 100px;" maxlength="" ${valid } ${keyValid } >
	</c:when>
	<c:when test="${type=='number'}">
		<input class="in_control spinner" type="text" name="${name }" value="${values[name]}" style="width: 100px;" maxlength="" ${valid } ${keyValid } >
	</c:when>
	<c:when test="${type=='select'}">
		&lt;tag:select name="${name }" groupId="${name }" selected="${values[name]}" ${valid }/>
	</c:when>
	<c:when test="${type=='check'}">
		&lt;tag:check name="${name }" groupId="${name }" checked="${values[name]}" ${valid }/>
	</c:when>
	<c:when test="${type=='radio'}">
		&lt;tag:radio name="${name }" groupId="${name }" checked="${values[name]}" ${valid }/>
	</c:when>
	<c:when test="${type=='files'}">
		<tag:files name="${name }" style="width: 90%;"/>
	</c:when>
	<c:when test="${type=='code'}">
		${'$'}{code:name('${name }', ${src_id}['${name}'],null)}
	</c:when>
	<c:when test="${type=='date_view'}">
		<c:set var="name_fmt">${name }@yyyy-MM-dd hh:mm:ss</c:set>
		${values[name_fmt]}
	</c:when>
	<c:when test="${type=='number_view'}">
		<c:set var="name_fmt">${name }@#,##0</c:set>
		${values[name_fmt]}
	</c:when>
	<c:otherwise>
		<input class="in_control" type="${type }" name="${name }" value="${values}" style="width: 90%;" maxlength="" ${valid } ${keyValid } >
	</c:otherwise>
</c:choose>

<c:if test="${link=='link'}">
	</span>
</c:if>
</span>