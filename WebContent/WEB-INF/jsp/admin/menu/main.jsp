<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 

<script type="text/javascript">
	$(function() {
		$('#header_title').text('메뉴');
		$( "#menu" ).menu();
	});

	function openPage(ui_id, tpl_path){
		var form = $('#new_form');
		
		if(form.length<1){
			form = $('<form id="new_form" method="post" style="disply:none;" target="_new"></form>');
			$('body').append(form);
		}
		form.attr('action', '../' + tpl_path + '/-' + ui_id + '.sh');
		form.submit();
	}

</script> 

<div id="auto_generated_uI_main" style="margin: 5px auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc; ">
	<table class="lst">
		<tr>
			<th>메 뉴</th>
			<th>UI 목록</th>
		</tr>
		<tr>
			<td style="width: 150px;; " valign="top">
				<ul id="menu" >
					<li><a target="ui" href="../admin-src/main.sh">UI 생성</a></li>
					<li>
						XML to DB 연동
						<ul>
							<li><a target="mapper" href="../-admin-mapper-main/createtbl.sh">1. 테이블 생성</a></li>
							<li><a target="mapper" href="../-admin-mapper-main/xml2db_mapping.sh">2. XPath에 필드 매핑</a></li>
							<li><a target="mapper" href="../-admin-mapper-main/trigger_mapping.sh">3. XPath에 연동쿼리 매핑</a></li>
						</ul>
					</li>
					<li><a target="mapper" href="../-admin-menu-manual/.sh">메뉴얼</a></li>
				</ul>
			</td>
			<td>
				<src:auto_make_src type="bf"/>
			</td>
		</tr>
	</table>
</div>