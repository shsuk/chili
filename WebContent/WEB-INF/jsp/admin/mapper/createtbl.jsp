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
    $( "#field_list" ).sortable({ cursor: "move" });

});

var treeData = [];

function loadTree(){
	$('#tree_data').load('../admin-mapper/xml2tree.sh',{xml:$('#in_xml').val()},function(){
		viewTree() ;
	    $('#xml_data').hide();
	});
}

function viewTree(){
	var parent = $("#tree_").parent();
	$("#tree_").remove();
	var tree = $('<div id="tree_"></div>');
	parent.append(tree);
	
    var dlist = [];
	for(var i=0; i<10; i++){
		var val = 'field' + i;
		dlist[i] = {id:val,title:val,path:val,value:val};
	}
	treeData[treeData.length]={title:'더미필드', hideCheckbox:true, children:dlist};
	
	tree.dynatree({
    	checkbox: true,
        onActivate: function(node) {
            ${link_value};
        },
        onSelect: function(select, node) {
        	selectNode(node.tree);
        },
        onPostInit: function() {
        	var width = $('.dynatree-container',tree)[0].scrollWidth+20;
        	tree.css('width', width);
        },
        onCreate: function(node, nodeSpan) {
        	selectNode(node.tree);
        },
        persist: true,
        children: treeData
    });
    

}

function selectNode(tree){
    // Display list of selected nodes
    var selNodes = tree.getSelectedNodes();
    var nameMap = {};
    var list = $("#field_list");
    $('tr', list).hide();
    
    for(var i=0; i<selNodes.length; i++){
    	var node = selNodes[i];
    	var name = node.data.id;
    	var path = node.data.path;
    	var pathName = path.split('/').join('_').replace('@','_');
    	
    	if(nameMap[name]){
    		name = pathName;
    		if(nameMap[name]){
    			continue;
    		}
    	}
		
    	nameMap[name] = path;
    	var fld = $("#"+pathName, list);
    	if(fld.length>0){
    		fld.show();
    	}else{
    		fld = $('<tr style="cursor: move;" id="' + pathName + '" class="sortable">'
        		+ '<td><input type="text" name="col_name" value="' + name + '" style="width:99%;"></td>'
        		+ '<td>' + $('#col_type').html() + '</td>'
        		+ '<td><input type="text" name="col_length" value="" style="width:30px;height:12px;" class="spinner" maxlength="4" key_press="numeric"> <input type="text" name="col_length" value="" style="width:15px;height:12px;" class="spinner" maxlength="2" key_press="numeric"></td>'
    			+ '<td><input type="checkbox" name="pk" value="' + node.data.path + '"><input type="hidden" name="path" value="' + node.data.path + '"></td>'
    			+ '<td>' + node.data.path + '</td>'
    			+ '<td>' + node.data.value.substring(0,20) + '</td></tr>');
        	list.append(fld);
    	}
    }
    ininControl();
   // $( "#field_list" ).disableSelection();    	
}

</script> 

<div class="ui-state-default" style="height:23px;text-align: center; padding-top: 8px; ">XML to DB 연동 - 테이블 생성</div>

<table class="lst">
	<tr>
		<td  valign="top" style=" width: 250px; min-width:200px;">
			<div class="ui-state-default" style="height:23px;text-align: center; padding-top: 8px; ">
				<span class="link" onclick="$('#xml_data').show()" >XML 열기</span>
				<div id="xml_data" style="position: absolute; width: 800px; height: 500px;z-index: 100;background: #cccccc;">
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
			
			<div id="left_content" style=" height:500px; width: 250px; overflow: auto; ">
				<div id="tree_"></div>
			</div>
			<span id="col_type" style="display: none;">
				<tag:select_array name="col_type" codes="autoint=자동증가,int=Int,number=Number,varchar=VarChar,mediumtext=Text,dateTime=Date" selected="varchar"/>
			</span>
		</td>
		<td valign="top">
			<div id="center_content" style=" height:500px; overflow-y: auto; ">
				<table class="lst">
					<colgroup>
						<col width="150"/>
						<col width="100"/>
						<col width="120"/>
						<col width="30"/>
						<col width="250"/>
						<col width="*"/>
					</colgroup>
					<thead>
						<tr>
							<th>테이블명</th>
							<td colspan="5">
								<input type="text" name="table_name"/>
								트리의 체크박스를 클릭하면 테이블의 필드를 추가하거나 삭제할 수 있습니다.
								<div class=" ui-widget-header ui-corner-all  m_3" style="float: right; cursor:pointer;  margin-left: 5px; padding: 3px;" onclick="createTable()" >테이블 생성</div>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<th>타입</th>
							<th>길이</th>
							<th>PK</th>
							<th>노드경로</th>
							<th>노드값</th>
						</tr>
					</thead>
					<tbody id="field_list" >
					</tbody>
				
				</table>
			</div>
		</td>
	</tr>
</table>
