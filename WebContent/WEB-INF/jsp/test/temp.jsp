<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %>
<%response.sendRedirect("http://loc.com/-admin-menu-main/-menuList.sh"); %>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<script src="../jquery/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<meta http - equiv = "p3p" content = 'CP="CAO DSP AND SO " policyref="/w3c/p3p.xml"' >

<title>Chili 프로젝트</title>

<script type="text/javascript">
$.ajax({
    url : "http://loc.com/-admin-menu-main/-menuList.sh",
    type : "get",
    beforeSend : function(xhr)
    {
        //xhr.setRequestHeader('Rantest', 'GGGGGGG');
    },
    dataType : "json",
    success : function(data)
    {
    }
 
});
</script> 
</head>
<body >
</body>
</html>