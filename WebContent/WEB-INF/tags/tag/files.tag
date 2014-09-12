<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ attribute name="name" type="java.lang.String" required="true"%>
<%@ attribute name="value" type="java.lang.String" required="true"%>
<%@ attribute name="className" type="java.lang.String"%>
<%@ attribute name="style" type="java.lang.String" %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="valid" type="java.lang.String" %>
<%@ attribute name="attr" type="java.lang.String" %>
<sp:sp queryPath="attach" action="list" processorList="mybatis" exception="false">
	{
		files_ref_id: ${value }
	}
</sp:sp>
<script type="text/javascript">
	$(function() {
		addAttach('${name }');
	});

</script>
<c:if test="${!empty(valid)}">
	<c:set var="valid">valid="${valid }"</c:set>
</c:if>
<div>
	<!-- 이전파일 목록 -->
	<!-- 조회용 -->
	<div class="${className }" name="${name }" style="display: none;">
		<c:forEach var="row" items="${files }">
			<div style="display: ${type=='files_img' ? 'inline' : '' };"><a href="../../dl.sh?file_id=${row.file_id}">
				<c:if test="${type=='files_img' }">
					<img src="../../dl.sh?file_id=${row.file_id}" height="100">
				</c:if>
				<c:if test="${type!='files_img' }">
					${row.file_name }
				</c:if>
			</a></div>
		</c:forEach>
	</div>
	<!-- 수정용 -->
	<div style="clear:both; float: right; cursor: pointer; padding-right: 20px;" title="첨부항목 추가" onclick="addAttach('${name }')">
		<img src="../../images/icon/add-icon.png">
	</div>

	<c:forEach var="row" items="${files }">
		<div style="clear:both; margin: 2px;" class="${row.file_id}">
			<div style="float: left; width: 90%;">${row.file_name }<input type="hidden" name="del_file_id" id="${row.file_id}" value=""></div>
			<div style="float: right;   padding-right: 20px; cursor: pointer;" title="첨부파일 삭제"  onclick="delFile('${row.file_id}')">
				<img src="../../images/icon/close-icon.png">
			</div>
		</div>
	</c:forEach>

	<div id="attachs_${name }" style="clear:both; width: 100%;"></div>

</div>

<div class="attachTpl_${name }" style="display: none; padding: 1px;">
	<input type="file" name="${name }" style="width: 90%;" class="">
	<div style="float: right; padding-right: 17px; cursor: pointer; margin: 2px;" title="첨부항목 삭제" onclick="$($(this).parent()).remove()">
		<img src="../../images/icon/close-icon.png">
	</div>
</div>
