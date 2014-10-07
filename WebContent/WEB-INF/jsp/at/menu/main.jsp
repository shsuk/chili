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
	<src:auto_make_src isForm="false"/>
	<table class="lst">
		<tr>
			<td><a target="ui" href="../admin-src/main.sh">UI 생성</a></td>
		</tr>
		<tr>
			<td><a target="mapper" href="../-admin-mapper-main/createtbl.sh">XML연동 테이블 생성</a><br></td>
		</tr>
		<tr>
			<td><a target="mapper" href="../-admin-mapper-main/mappingxml.sh">XML연동 매퍼</a></td>
		</tr>
		<tr>
			<td><a target="mapper" href="../-at-menu-manual/.sh">메뉴얼</a></td>
		</tr>
	</table>
</div>