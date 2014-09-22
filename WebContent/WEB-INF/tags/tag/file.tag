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
<sp:sp var="RESULT" queryPath="attach" action="file" processorList="mybatis" exception="false">
	{
		file_ref_id: '${value }'
	}
</sp:sp>

<c:if test="${!empty(valid)}">
	<c:set var="valid">valid="${valid }"</c:set>
</c:if>
<div>
	<!-- 이전파일 목록 -->
	<!-- 조회용 -->
	<div class="${className }" name="${name }" style="display: none;">
		<div style=""><a href="../dl.sh?file_id=${file.file_id}">
				<c:if test="${type=='file_img' }">
					<img src="../dl.sh?file_id=${file.file_id}"  height="100">
				</c:if>
				<c:if test="${type!='files_img' }">
					${row.file_name }
				</c:if>
		</a></div>
	</div>
	<!-- 수정용 -->
	<div style="clear:both; margin: 2px;" class="${file.file_id}">
		<div style="float: left; width: 90%;">${file.file_name }<input type="hidden" name="del_file_id" id="${file.file_id}" value=""></div>
		<div style="float: right;   padding-right: 20px; cursor: pointer;" title="첨부파일 삭제"  onclick="delFile('${file.file_id}')">
			<img src="../images/icon/close.png">
		</div>
	</div>
	<input type="file" name="${name }" style="width: 90%;" onchange="delFile('${file.file_id}')" class="">
	
</div>