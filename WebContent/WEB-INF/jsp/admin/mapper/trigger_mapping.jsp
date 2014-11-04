<%@page import="kr.or.voj.webapp.utils.XmlUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sp" uri="/WEB-INF/tlds/sp.tld"%>
<%@ taglib prefix="tag"  tagdir="/WEB-INF/tags/tag" %> 
<%@ taglib prefix="src"  tagdir="/WEB-INF/tags/src" %> 
<script type="text/javascript">
$(function(){

   	//load Sample
    loadTree();
   	//수정모드
    edit();
});

var treeData = [];

function loadTree(){
	$('#tree_data').load('../admin-mapper/xml2tree.sh',{xml:$('#in_xml').val(), hideCheckbox:'N'},function(){
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
        persist: false,
        children: treeData
    });
    

}

function selectNode(tree){
    // Display list of selected nodes
    var selNodes = tree.getSelectedNodes();
    var nameMap = {};
    var list = $("tbody", $("#field_list"));
    $('tr.node', list).attr('remove','Y');
    
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
    		fld.attr('remove','N');
    	}else{
    		fld = $('tr',$('#tpl_trigger')).clone();
    		fld.attr('id',pathName);
    		$('[name=xpath]', fld).val(node.data.path);
    		$('.node_val', fld).text(node.data.value.substring(0,20));
    		
        	list.append(fld);
    	}
    }
    
    $("[remove=Y]", $("#field_list")).remove();

    ininControl();
   // $( "#field_list" ).disableSelection();    	
}

</script> 

<div class="ui-state-default" style="text-align: center; padding: 4px; ">
	XML to DB 연동 - 연동 설정
	<a class="button" icons_primary="ui-icon-carat-1-w" href="xml2db_mapping.sh">이전</a>
</div>
XML에 대한 연동정보를 설정합니다.
<form method="post">
	<input type="hidden" name="ui_id" value="mapper_info">
	<input type="hidden" name="action_type" value="U">
	<input type="hidden" name="loop_field_name" value="xpath">
	<src:auto_make_src uiId="mapper_info" type="nf"/>
	<table class="lst">
		<tr>
			<td  valign="top" style=" width: 250px; min-width:200px;">
				<div class="ui-state-default" style="text-align: center; padding: 4px; ">
					<span class="button" icons_primary="ui-icon-folder-open" onclick="$('#xml_data').show()" >XML 열기</span>
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
			</td>
			<td valign="top">
				<div id="center_content" style=" height:500px; overflow-y: auto; ">
					<table  id="field_list" class="lst">
						<colgroup>
							<col width="200"/>
							<col width="100"/>
							<col width="100"/>
							<col width="80"/>
							<col width="*"/>
							<col width="40"/>
						</colgroup>
						<src:auto_make_src uiId="mapperTrigEdit" type="trh"/>
					</table>
					<div class="ui-widget-header ui-corner-all btn_right" style="margin-top: 5px; " onclick="form_submit()">저장</div>
					○ XML열기를 클릭하고 처리할 XML을 입력하세요.<br>
					○ 이벤트를 발생시킬 노드를 선택하고 해당 궈리를 설정하세요.<br>
					○ 설정한 이벤트 노드를 만나면 연결된 쿼리가 실행됩니다.
				</div>
			</td>
		</tr>
	</table>
</form>
<%//트리거 입력 tr 템플릿 %>
<table id="tpl_trigger" style="display:none;">
	<tr class="node">
    	<td><input type="text" name="xpath" value="" style="width:99%;"></td>
    	<td colspan="2"><tag:select_query_name name="trigger_query"/></td>
    	<td><input type="text" name="delete_value" value="" style="width:99%;"></td>
    	<td><input type="text" name="trigger_desc" value="" style="width:99%;"></td>
    	<td></td>
    </tr>
</table>
