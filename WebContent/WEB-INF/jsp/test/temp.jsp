<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %>

<sp:sp var="RESULT" queryPath="notice" action="view" processorList="attach,mybatis" exception="false">
	{
		//rows:10,_start:1,notice_id:72
	}
	
</sp:sp>
 
<script type="text/javascript">
	$(function() {
		//콘트롤 변경시 정합성 체크(미사용시 삭제)
		checkValidOnChange();
	});
	
	
	
	function form_submit(){	
		var form = $('#main_form');
		//폼 정합성 체크
		if(!valid(form)){
			return;
		}
	
		var formData =$(form).serializeArray();		
		var url = form.attr('action');

		$.post(url, formData, function(response, textStatus, xhr){

			var data = $.parseJSON(response);
			
			if(data.success){
				document.location.href='list.jsp';
			}else{
				alert("처리하는 중 오류가 발생하였습니다. \n문제가 지속되면 관리자에게 문의 하세요.\n" + data.message);					
			}
			
		});
	}
</script> 

<div id="main_layer" style="margin: 0 auto; padding:3px; width: 90%; min-width:1000px; border:1px solid #cccccc;">
	<form id="main_form" action="" >
	
		
			<table class="vw" border="0" cellspacing="0" cellpadding="0"  style="margin-bottom: 10px;">
			<colgroup>
				<col width="150">
				<col width="*">
			</colgroup>
		
			<tr>
					<th label="notice_id">notice_id</th>
					<td><span class="field">
<input class="in_control" type="text" name="notice_id"  value="${row.notice_id}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="subject">subject</th>
					<td><span class="field">
<input class="in_control" type="text" name="subject"  value="${row.subject}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="contents">contents</th>
					<td><span class="field">
<input class="in_control" type="text" name="contents"  value="${row.contents}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="stt_dt">stt_dt</th>
					<td><span class="field">
<input class="in_control" type="text" name="stt_dt"  value="${row.stt_dt}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="end_dt">end_dt</th>
					<td><span class="field">
<input class="in_control" type="text" name="end_dt"  value="${row.end_dt}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="use_yn">use_yn</th>
					<td><span class="field">
<input class="in_control" type="text" name="use_yn"  value="${row.use_yn}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="qry_cnt">qry_cnt</th>
					<td><span class="field">
<input class="in_control" type="text" name="qry_cnt"  value="${row.qry_cnt}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="reg_id">reg_id</th>
					<td><span class="field">
<input class="in_control" type="text" name="reg_id"  value="${row.reg_id}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="reg_dt">reg_dt</th>
					<td><span class="field">
<input class="in_control" type="text" name="reg_dt"  value="${row.reg_dt}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="chg_id">chg_id</th>
					<td><span class="field">
<input class="in_control" type="text" name="chg_id"  value="${row.chg_id}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr>
			<tr>
					<th label="chg_dt">chg_dt</th>
					<td><span class="field">
<input class="in_control" type="text" name="chg_dt"  value="${row.chg_dt}" style="width: 90%;" maxlength=""  >
	</span></td>
				</tr></table>
		
	
	</form>
		<div style="clear: both;width: 100%;height: 25px;margin-top: 10px;">
			<div id="save_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;display: none;" onclick="form_submit()">저장</div>
			<div id="edit_btn" class=" ui-widget-header ui-corner-all" style="float: right; cursor: pointer; padding: 3px 10px;margin-left: 10px;" onclick="edit()">수정</div>
		</div>
</div>
<!-- 
{ "stt_dt_type":"text", "chg_dt_label":"chg_dt", "subject_label":"subject", "notice_id_label":"notice_id", "qry_cnt_label":"qry_cnt", "chg_id_type":"text", "reg_dt_label":"reg_dt", "formData":"", "use_yn_type":"text", "action":"view", "subject_type":"text", "_dumy":"1409708260068", "defaultValue":"rows:10,_start:1,notice_id:72", "chg_dt_type":"text", "reg_id_label":"reg_id", "end_dt_type":"text", "qry_cnt_type":"text", "notice_id_type":"text", "chg_id_label":"chg_id", "use_yn_label":"use_yn", "stt_dt_label":"stt_dt", "contents_label":"contents", "queryPath":"notice", "reg_dt_type":"text", "contents_type":"text", "reg_id_type":"text", "end_dt_label":"end_dt"}
-->
