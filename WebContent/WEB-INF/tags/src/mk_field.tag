<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ attribute name="src_id" type="java.lang.String" description="레코드 아이디"%>
<%@ attribute name="type" type="java.lang.String" description="콘트롤 타입"%>
<%@ attribute name="name" type="java.lang.String" description="필드명"%>
<%@ attribute name="values" type="java.util.Map" description="필드값"%>
<%@ attribute name="maxlength" type="java.lang.String" description="입력길이"%>
<%@ attribute name="link" type="java.lang.String" description="link파리메터"%>
<%@ attribute name="link_type" type="java.lang.String" description="link타입"%>
<%@ attribute name="index" type="java.lang.String" description="${src_id} index"%>
<%@ attribute name="valid" type="java.lang.String" description="필드 정합성 체크 정보"%>
<%@ attribute name="keyValid" type="java.lang.String" description="필드 정합성 체크 정보"%>
<c:if test="${!empty(valid) }"><c:set var="valid">valid="${valid }"</c:set></c:if>
<c:if test="${!empty(keyValid) }"><c:set var="keyValid">key_press="${keyValid }"</c:set></c:if>

<c:set var="ctl">
	<c:choose>
		<c:when test="${type=='text'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<input class="control" type="text" name="${name }"  value="${values[name]}" style="width: 90%;" maxlength="${maxlength }" ${valid } ${keyValid } >
		</c:when>
		<c:when test="${type=='textarea'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<textarea class="control" name="${name }" style="width: 98%;height: 150px;" maxlength="${maxlength }" ${valid } ${keyValid } >${values[name]}</textarea>
		</c:when>
		<c:when test="${type=='date'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<c:set var="name_fmt">${name }@yyyy-MM-dd</c:set>
			<input class="control datepicker" type="text" name="${name }" value="${values[name_fmt]}" style="min-width: 100px;" ${valid } ${keyValid } >
		</c:when>
		<c:when test="${type=='number'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<input class="control spinner" type="text" name="${name }" value="${values[name]}" style="min-width: 30px;" maxlength="${maxlength }" ${valid } ${keyValid } >
		</c:when>
		<c:when test="${type=='file' || type=='file_img'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<tag:file className="control" name="${name }"  value="${values[name]}" type="${type }" style="width: 90%;"/>
		</c:when>
		<c:when test="${type=='files' || type=='files_img'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<tag:files className="control" name="${name }"  value="${values[name]}" type="${type }" style="width: 90%;"/>
		</c:when>
		<c:when test="${type=='select'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<tag:select name="${name }" groupId="${name }" selected="${values[name]}" className="control" valid="${valid }" />
		</c:when>
		<c:when test="${type=='check'}">
			<c:set var="isInputColtrol" value="${true}"/>
			&lt;tag:check name="${name }" groupId="${name }" checked="${values[name]}" ${valid }/>
		</c:when>
		<c:when test="${type=='radio'}">
			<c:set var="isInputColtrol" value="${true}"/>
			<tag:radio name="${name }" groupId="${name }" checked="${values[name]}" className="control"  valid="${valid }" />
		</c:when>
		<c:when test="${type=='code'}">
			<tag:code groupId="${name }" value="${values[name]}" />
		</c:when>
		<c:when test="${type=='label'}">
			<span name="${name }">${values[name]}</span>
		</c:when>
		<c:when test="${type=='datetime_view'}">
			<c:set var="name_fmt">${name }@yyyy-MM-dd hh:mm:ss</c:set>
			${values[name_fmt]}
		</c:when>
		<c:when test="${type=='date_view'}">
			<c:set var="name_fmt">${name }@yyyy-MM-dd</c:set>
			${values[name_fmt]}
		</c:when>
		<c:when test="${type=='number_view'}">
			<c:set var="name_fmt">${name }@#,##0</c:set>
			${values[name_fmt]}
		</c:when>
		<c:otherwise>
			<c:set var="isInputColtrol" value="${true}"/>
			<input class="control" type="${type }" name="${name }" value="${values[name]}" style="width: 90%;" maxlength="${maxlength }" ${valid } ${keyValid } >
		</c:otherwise>
	</c:choose>
</c:set>
<c:if test="${!empty(link) }">
	<c:set var="link_value">onclick="${link_type }(<tag:el source="${link }" param="${values }"/>)" class="link"</c:set>
	<c:set var="link_class">link</c:set>
</c:if>

<span class="field ${link_class}" ${link_value }>
	<span ${isInputColtrol ? 'class="in_control"' : '' } type="${type}">
		<c:if test="${link!='link'}">
			${ctl }
		</c:if>
	</span>
</span>