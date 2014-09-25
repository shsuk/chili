<%@page import="kr.or.voj.webapp.utils.XmlUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %>
<script type="text/javascript">
$(function(){
    $("#trg_path_list").droppable({
        hoverClass: "ui-state-default",
        addClasses: true,
//        tolerance: "pointer",
        over: function(event, ui) {
          logMsg("droppable.over, %o, %o", event, ui);
        },
        drop: function(event, ui) {
        	var path = ui.helper.data("dtSourceNode").data.path;
        	addTrgNode(path);
        }
     });

});
var treeData = [];

function addTrgNode(path){
	var idPath = path.split('/').join('__').split('@').join('_a_');
	var target = $('#trg_path_list');
	var obj = $('#_'+idPath, target);
	
	if(obj.length>0){
		return;
	}
	
	if($('.trg_node', target).length<1){
		target.html('');
	}
	obj = $('<div id="_'+ idPath + '" class="trg_node" value="' +path + '">' +path + '<img src="../images/icon/close.png" onclick="delTrgNode(\'#_'+ idPath + '\')"></div>');
	target.append(obj);
}
function delTrgNode(id){
	$(id).remove();
}
function loadTree(){
	$('#tree_data').load('../admin_mapper/xml2tree.sh',{xml:$('#in_xml').val()},function(){
		viewTree() ;
	    $('#xml_data').hide();
	});
}
function viewTree(){
	var parent = $("#tree_").parent();
	$("#tree_").remove();
	var tree = $('<div id="tree_"></div>');
	parent.append(tree);
	
    tree.dynatree({
    	checkbox: true,
    	onActivate: function(node) {
   	      $("#echoActive").text(node.data.title + "(" + node.data.key + ")");
   	    },
   	 	onDblClick: function(node){
   	 		addTrgNode(node.data.path);
   	 	},
   	    onDeactivate: function(node) {
   	      $("#echoActive").text("-");
   	    },
        onPostInit: function() {
        	var width = $('.dynatree-container',tree)[0].scrollWidth+20;
        	tree.css('width', width);
        },
    	dnd: {
    	      revert: false, // true: slide helper back to source if drop is rejected
    	      onDragStart: function(node) {
    	        return true;
    	      },
    	      onDragStop: function(node) {
    	        //logMsg("tree.onDragStop(%o)", node);
    	      }
    	},
        children: treeData
    });
    
}
function makeQuery(){
	var form = $('#center_content');
	$('.table_name').text($('[name=table_name]', form).val());
	var fields = $('.col_name', form);
	var xpaths = $('.xml_path', form);
	var col_name = "";
	var col_value = "";
	var set_col_name = '';
	
	for(var i=0; i<fields.length; i++){
		var val = $(xpaths[i]).val().trim();
		
		if(val==''){
			continue;
		}
		
		if(val.indexOf(',')>0){
			val = 'concat(' + val + ')';
		}

		var comma = (i==(fields.length-1)) ? '' : ',';

		col_value += '<li>' + val + comma + '</li>';
		col_name += '<li>' + $(fields[i]).val() + comma + '</li>';
		set_col_name += '<li>' + $(fields[i]).val() + '=' + val + comma + '</li>';
	}
	
	$('#col_name').html(col_name);
	$('#col_value').html(col_value);
	$('#set_col_name').html(set_col_name);
	//조건절 처리
	var where_value = '';
	var key_flds = $(':checked[name=key_fld]',form);
	
	for(var i=0; i<key_flds.length; i++){
		var val = $(key_flds[i]).val();
		
		var path = $('.xml_path',$('.fld_' + val)).val();
		
		if(path.indexOf(',')>0){
			path = 'concat(' + path + ')';
		}
		
		where_value += '<li>' + (i==0 ? '' : ' and ') + val + ' = ' + path +'</li>';
	}
	$('#where_value').html(where_value);
	
}

function loadTableInfo(tableName){
	$('#table_info').load('../admin_mapper/collist.sh',{table_name:tableName}, function(){
	    $(".droppable").droppable({
	        hoverClass: "ui-state-default",
	        addClasses: true,
//	        tolerance: "pointer",
	        over: function(event, ui) {
	          logMsg("droppable.over, %o, %o", event, ui);
	        },
	        drop: function(event, ui) {
	        	var path = '#{' + ui.helper.data("dtSourceNode").data.path + '}';
	        	var value = ui.helper.data("dtSourceNode").data.value;
				var fld = $(this).addClass("ui-state-highlight").find(".xml_path");
				fld.val(fld.val() + (fld.val()=='' ? '' : ',\n') + path);
	          
				fld = $(this).find(".node_value");
				fld.text(fld.text() + (fld.text()=='' ? '' : ', ') + value);
	        }
	     });
	    $('[name=table_name]').val(tableName);
	});
}
</script> 
<style type="text/css">
    #query li {
      list-style: none outside none;
    }
</style>

<div class="ui-state-default" style="height:23px;text-align: center; padding-top: 8px; ">XML연동 매퍼</div>

<table class="lst">
	<tr>
		<td  valign="top" style=" width: 250px;">
			<div class="ui-state-default" style="height:23px;text-align: center; padding-top: 8px; ">
				<span class="link" onclick="$('#xml_data').show()" >XML 열기</span>
				<div id="xml_data" style="position: absolute; width: 805px; height: 500px;z-index: 100;background: #cccccc;">
					<div id="tree_data" style="display: none;"></div>
					<textarea id="in_xml" style="width: 800px; max-width:800px; min-width:800px; height: 450px;margin-bottom:10px; "><?xml version="1.0" encoding="UTF-8"?>
						<Employees>
						    <Employee id="1" num="333">
						        <age>29</age>
						        <name>Pankaj</name>
						        <gender>Male</gender>
						        <role>Java Developer</role>
						    </Employee>
						    <Employee id="2">
						        <age>35</age>
						        <name>Lisa</name>
						        <gender>Female</gender>
						        <role>CEO</role>
						    </Employee>
						    <Employee img="3">
						        <age>40</age>
						        <name>Tom</name>
						        <gender>Male</gender>
						        <role>Manager</role>
						    </Employee>
						</Employees>
					</textarea>
					<div class=" ui-widget-header ui-corner-all p_3 link " style="display:inline;width: 100px; margin-right : 10px;" onclick="$('#xml_data').hide()" >닫기</div><div class=" ui-widget-header ui-corner-all p_3 link" style="display:inline; width: 100px;" onclick="loadTree()" >적용</div>
				</div>
			</div>
			
			<div id="left_content" style=" height:400px; width: 250px; overflow: auto; ">
				<div id="tree_"></div>
			</div>
			<div class="ui-state-default" style="height:20px;text-align: center; padding-top: 4px; ">쿼리 생행 트리거 노드</div>
			<div id="trg_path_list" style=" height:70px; width:99%; overflow-y: auto;min-width: 250px; ">이곳에 트리의 노드를 끌어 놓거나 더블클릭하여 트리거링 할 노드를 추가하세요.<br>노드의 텍스트가 긴 경우 중앙이 이곳에 위치해야 끌어 놓을 수 있습니다.</div>
		</td>
		<td valign="top">
			<div id="center_content" style=" height:500px; overflow-y: auto; ">
				
				<table class="lst">
					<colgroup>
						<col width="150">
						<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th>테이블명</th>
							<td colspan="5">
								<input style="float: left;margin-right: 10px;" type="text" name="table_name"> 테이블 선택후 아래 필드에 체크박스가 있는 트리의 노드를 끌어 매핑하세요.
								<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 5px; padding: 3px;" onclick="makeQuery()" >쿼리 생성</div>
							</td>
						</tr>
					</thead>
				</table>
				<div id="table_info">
				</div>
     		 </div>
		</td>
		<td align="center" valign="top" style=" width: 170px;">
			<div class="ui-state-default" style="height:23px;text-align: center; padding-top: 8px; ">테이블 선택</div>
			<div style="height: 470px; overflow-y: auto;">
				<c:import url="tablelist.jsp"/>
			</div>
		</td>
	</tr>
</table>
<table class="lst">
	<tr>
		<th width="50%">등록 쿼리문</th>
		<th width="50%">수정 쿼리문</th>
	</tr>
	<tr>
		<td valign="top">
			<div id="query">
				INSERT INTO <span class="table_name"></span>(<br>
					 <ul id="col_name"></ul>
				)VALUES(<br>
					<ul id="col_value"></ul>
				)
			</div>
		</td>
		<td valign="top">
			<div id="query" >
				UPDATE FROM <span class="table_name"></span><br>
				SET (
					 <ul id="set_col_name"></ul>
				)
				WHERE <ul id="where_value"></ul>
			</div>
		</td>
	</tr>
</table>
