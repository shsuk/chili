<%@page import="kr.or.voj.webapp.processor.ProcessorServiceFactory"%>
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

	//load Sample
	loadTree();


});

var treeData = [];

function loadTree(){
	$('#tree_data').load('../admin-mapper/xml2tree.sh',{xml:$('#in_xml').val()},function(){
		viewTree() ;
	    $('#xml_data').hide();
	    $('[name=table_name]').val(treeData[0].id.toLowerCase() + '_tbl');
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
    var trs = $('tr', list);
    trs.hide();
    $('[name=col_name]', list).attr('view','N');
    
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
    	    $('[name=col_name]', fld).attr('view','Y');
    	}else{
    		fld = $('<tr style="cursor: move;" id="' + pathName + '" class="sortable">'
        		+ '<td><input type="text" name="col_name" value="' + name + '" style="width:99%;" view="Y"></td>'
        		+ '<td>' + $('#col_type').html() + '</td>'
        		+ '<td><input type="text" name="col_length1" value="" style="width:30px;height:12px;" class="spinner" maxlength="4" key_press="numeric"> <input type="text" name="col_length2" value="" style="width:15px;height:12px;" class="spinner" maxlength="2" key_press="numeric"></td>'
    			+ '<td><input type="checkbox" name="pk" value="' + node.data.path + '"></td>'
    			+ '<td><input type="checkbox" name="isnull" value="' + node.data.path + '"></td>'
        		+ '<td><input type="text" name="default" value="" style="width:99%;"></td>'
    			+ '<td>' + node.data.path + '</td>'
    			+ '<td>' + node.data.value.substring(0,20) + '</td></tr>');
        	list.append(fld);
    	}
    }
    //table의 필드를 동적으로 생성후 콘트롤 초기화
    initLoadingPage();
  	
}

function createTable(){
	var fields = '';
	var pkflds = '';
	var table_name = $('[name=table_name]').val();
	var field_list = $('#field_list');
	var flds = $('[name=col_name]', field_list);
	var col_types = $('[name=col_type]', field_list);
	var col_length1s = $('[name=col_length1]', field_list);
	var col_length2s = $('[name=col_length2]', field_list);
	var pks = $('[name=pk]', field_list);
	var isnulls = $('[name=isnull]', field_list);
	var defaults = $('[name=default]', field_list);
	
	for(var i=0;i<flds.length; i++){
		if($(flds[i]).attr('view')=='N'){
			continue;
		}
		var name = $(flds[i]).val();
		var col_type = $(col_types[i]).val();
		var l1 = $(col_length1s[i]).val();
		var l2 = $(col_length2s[i]).val();
		var pk = $(pks[i]).prop( "checked" );
		var isnull = $(isnulls[i]).prop( "checked" );
		var def = $(defaults[i]).val().trim();
		
		if(col_type == 'AUTO_INCREMENT'){
			fields += name + ' int AUTO_INCREMENT';
			fields += ' NOT NULL ';
			pkflds += ',' + name;
		}else{
			fields += name + ' ' + col_type;
			
			if(col_type=='varchar'){
				if(l1==''){
					alert('길이를 입력하세요.');
					return;
				}
				fields += '(' + l1 + ')';
				
			}else if(col_type=='number'){
				if(l1==''){
					alert('길이를 입력하세요.');
					return;
				}
				if(l2==''){
					l2 = '0';
				}
				fields += '(' + l1 + ',' + l2 + ')';								
			}
			
			if(def!='' && (col_type=='number' || col_type=='int')){
				def = " '" + def + "' ";				
			}
			
			if(pk){
				fields += ' NOT NULL ';
				pkflds += ',' + name;
			}else{
				if(def==''){
					fields += isnull ? ' NULL ' : ' NOT NULL ';				
				}else{
					fields += " DEFAULT " + def;				
				}
			}
		}
		fields += ',\n\t';
	}
	pkflds = pkflds.substr(1);
	if(pkflds==''){
		alert('PK필드가 한개 이상 존재해야 합니다.');
		return;
	}
	var query = 'CREATE TABLE ' + table_name + ' ( \n\t' + fields + 'PRIMARY KEY (' + pkflds + ')\n)';
	alert(query);
}
</script> 

<div class="ui-state-default" style="height1:23px;text-align: center; padding: 4px; ">
	XML to DB 연동 - 연동 테이블 작성
	<a class="button" icons_primary="ui-icon-carat-1-e" href="xml2db_mapping.sh">다음</a>
	<div class="button" icons_primary="ui-icon-shuffle" style="float: right;" onclick="createTable()" >테이블 생성</div>
</div>

<table class="lst">
	<tr>
		<td  valign="top" style=" width: 250px; min-width:200px;">
			<div class="ui-state-default" style="text-align: center; padding: 4px; ">
				<span class="button" icons_primary="ui-icon-folder-open"onclick="$('#xml_data').show()" >XML 열기</span>
				<div id="xml_data" style="display: none;position: absolute; width: 800px; height: 500px;z-index: 100;background: #cccccc;">
					<div id="tree_data" style="display: none;"></div>
					<textarea id="in_xml" style="width: 800px; max-width:800px; min-width:800px; height: 450px;margin-bottom:10px; "><?xml version="1.0" encoding="UTF-8"?>
						<Sample>
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
						</Sample>
					</textarea>
					<div class="button" style="float: right; margin-right: 10px;" onclick="$('#xml_data').hide()" >닫기</div>
					<div class="button" style="float: right; margin-right: 10px;" onclick="loadTree()" >적용</div>
				</div>
			</div>
			
			<div id="left_content" style=" height:500px; width: 250px; overflow: auto; ">
				<div id="tree_"></div>
			</div>
			<span id="col_type" style="display: none;">
				<c:set var="dbType"><%=ProcessorServiceFactory.getDbType(null) %></c:set>
				<c:choose>
					<c:when test="${dbType=='mysql' }">
						<c:set var="code">AUTO_INCREMENT=자동증가,int=Int,number=Number,varchar=VarChar,mediumtext=Text,dateTime=Date</c:set>
					</c:when>
					<c:when test="${dbType=='oracle' }">
						<c:set var="code">NUMBER=Number,VARCHAR2=Varchar2,DATE=Date</c:set>
					</c:when>
				</c:choose>
				<tag:select_array name="col_type" codes="${code }" selected="varchar"/>
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
						<col width="30"/>
						<col width="100"/>
						<col width="250"/>
						<col width="*"/>
					</colgroup>
					<thead>
						<tr>
							<th>테이블명</th>
							<td colspan="7">
								<input type="text" name="table_name"/>
								(${dbType })
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<th>타입</th>
							<th>길이</th>
							<th>PK</th>
							<th>NULL</th>
							<th>기본값</th>
							<th>노드경로</th>
							<th>노드값</th>
						</tr>
					</thead>
					<tbody id="field_list" >
					</tbody>
				</table>
				○ 트리의 체크박스를 선택하여 테이블의 필드를 추가하거나 삭제할 수 있습니다.<br>
				○ 필드를 드래그하여 순서를 조절할 수 있습니다.
			</div>
		</td>
	</tr>
</table>
