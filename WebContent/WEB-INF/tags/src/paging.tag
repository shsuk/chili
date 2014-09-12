<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<%@ attribute name="rows" type="java.lang.String" required="true" description="조회한 현재 페이지"%>
<%@ attribute name="_start" type="java.lang.String" required="true" description="페이지에 표시될 레코드의 갯수"%>
<%@ attribute name="totCount" type="java.lang.Integer" required="true" description="전체 레코드수"%>
<div class="page_nevi" style="text-align: center; font-size: 14px;">
<c:choose>
	<c:when test="${totCount==null}">
			
	</c:when>
	<c:otherwise><!-- 데이타가 있는 경우 -->
		<c:set var="nevSize" value="10"/>
		<c:set var="_rows" value="${empty(_rows) ? 20 : _rows}"/>
		<c:set var="_start" value="${empty(_start) ? (empty(pageNo) ? 0 : (pageNo-1)*rows) : _start}"/>
		<c:set var="pageNo" value="${_start/rows + 1}"/>
		<c:set var="totPage" value="${sp:round(sp:ceil(totCount/_rows))}"/>
		<c:set var="startPage" value="${sp:double2long(sp:ceil(pageNo/nevSize)-1)*nevSize+1}"/>
		<c:set var="endPage" value="${startPage + nevSize-1 }"/>
		<c:set var="endPage" value="${endPage > totPage ? totPage : endPage }"/>
		<!-- 이전 페이지 -->
		<c:choose>
			<c:when test="${startPage == 1}">
				<img src="../../images/btn_prev.gif" alt="이전"  style="vertical-align: middle;;" />&nbsp;
			</c:when>
			<c:otherwise>
				<a href="javascript:${empty(functionName) ? 'goPage' : functionName}(${startPage-1},'${loadingLayerSelector}')" style="cursor:pointer;" ><img src="../../images/btn_prev.gif" alt="이전"  style="vertical-align: middle;;" /></a>
			</c:otherwise>
		</c:choose>
		<!-- 페이지 네비게이션 -->
		<c:forEach var="page" begin="${startPage}" end="${endPage}" step="1" varStatus="status">
			
				<c:choose>
					<c:when test="${page!=pageNo}"><a href="javascript:${empty(functionName) ? 'goPage' : functionName}(${page},'${loadingLayerSelector}')">${page }</a></c:when>
					<c:otherwise>[${page }]</c:otherwise>
				</c:choose>
				${status.last ? "" : '<span style="padding:0px 5px 0px 5px;">.</span>'}
		</c:forEach>
		<!-- 다음 페이지 -->&nbsp;
		<c:choose>
			<c:when test="${endPage<totPage}">
				<a href="javascript:${empty(functionName) ? 'goPage' : functionName}(${endPage+1},'${loadingLayerSelector}')" style="cursor:pointer;"><img src="images/btn_next.gif" alt="다음"  style="vertical-align: middle;;" /></a>
			</c:when>
			<c:otherwise>
				<img src="../../images/btn_next.gif" alt="다음" style="vertical-align: middle;;"/>
			</c:otherwise>
		</c:choose>
		(${totCount }건)
	</c:otherwise>
</c:choose>
</div>