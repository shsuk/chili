	var oEditors = [];
	var option = {
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월' ],
		dayNamesMin: ["일","월","화","수","목","금","토"],
		//showOn: "button",
		buttonImage: '/images/calendar.gif',
		buttonImageOnly: true,
		dateFormat: 'yy-mm-dd',
		changeYear: true,
		changeMonth: true

	};
	
	$(function() {
		try {
			initDefControl();
		} catch (e) {
			// TODO: handle exception
		}
		
		//콘트롤값 변경시 정합성 체크(미사용시 삭제)
		checkValidOnChange();
		
		try {
			//캐시를 무시하기 위해 더미 파라메터 추가
			$.ajaxPrefilter(function( options, originalOptions, jqXHR ) {
				mask();
				if(options.url.indexOf('?')>0){
					options.url += '&_dumy=' + (new Date()).getTime();
				}else{
					options.url += '?_dumy=' + (new Date()).getTime();
				}
			});

			$( document ).ajaxComplete(function() {
				mask_off();
				initDefControl();
			});
		} catch (e) {
			// TODO: handle exception
		}
		//UI구성을 위한 jquery함수 추가
		appendQueryFun();

		//영문 숫자 입력 제한 처리
		$(document).on('keypress', '[key_press=alpa]', function(event){
			return alpa(event);
		});
		$(document).on('keypress', '[key_press=numeric]', function(event){
			return numeric(event);
		});
		$(document).on('keypress', '[key_press=alpa_numeric]', function(event){
			return alpa_numeric(event);
		});
		$(document).on('change', '[key_press]', function(event){
			var str = $(event.target).val();
			
			for (var i = 0; i < str.length; i++) {
				var code = str.charCodeAt(i);
				
				code = parseInt(code);

				if (code > 255 || code < 0){
					$(event.target).val('');
					alert('한글은 입력할 수 없습니다.');
					return;
				}
			}
		});
		
		
		function getFixHeight(){
			var fixHeights = $(".fix_height");
			var fh = 60;
			
			for(var i=0; i<fixHeights.length; i++){
				fh += fixHeights[i].clientHeight;
			}
			return fh;
		}
		//윈도우 리사이즈
		$( window ).resize(function(e,e1) {
			var h = window.innerHeight - getFixHeight();
			var height = h + 'px';
			var obj = $(".auto_height");
			obj.css('height', height);
			var sizeSyncs = $('[size_sync]');
			for(var i=0; i<sizeSyncs.length ; i++){
				var syncObj = $($(sizeSyncs[i]).attr('size_sync')).get(0);
				$(sizeSyncs[i]).css('height', syncObj.clientHeight + 'px');
				$(sizeSyncs[i]).css('width', (syncObj.clientWidth-5) + 'px');
			}
		}).resize();

	});

	//UI구성을 위한 jquery함수 추가
	function appendQueryFun(){
		//임시 레이어를 생성하여 페이지를 로드한 후 원하는 위치에 삽입한다.
		$['append'] = function (selector, url, data, callback){
			var temp_div = $('#temp_div');
			if(temp_div.length==0){
				temp_div = $('<div id="temp_div" style="disply:none;"></div>');
				$('body').append(temp_div);
			}
			
			temp_div.load(url, data, function(){
				if(callback){
					callback();
				}
				$(selector).append(temp_div.children());
			});
		};
		$['before'] = function (selector, url, data, callback){
			var temp_div = $('#temp_div');
			if(temp_div.length==0){
				temp_div = $('<div id="temp_div" style="disply:none;"></div>');
				$('body').append(temp_div);
			}
			
			temp_div.load(url, data, function(){
				if(callback){
					callback();
				}
				$(selector).before(temp_div.children());
			});
		};
		$['prepend'] = function (selector, url, data, callback){
			var temp_div = $('#temp_div');
			if(temp_div.length==0){
				temp_div = $('<div id="temp_div" style="disply:none;"></div>');
				$('body').append(temp_div);
			}
			
			temp_div.load(url, data, function(){
				if(callback){
					callback();
				}
				$(selector).prepend(temp_div.children());
			});
		};
		
	}
	//초기 로딩이나 ajx로딩 완료시 콘트롤 초기화
	function initDefControl(){
		$('.datepicker').datepicker(option);
		$('.spinner').spinner({ min: 1 });
		
		$('[key_press=]').removeAttr('key_press');
		$('[valid=]').removeAttr('valid');
		
		var btns = $( ".button" );
		for(var i=0; i<btns.length;i++){
			var btn = $(btns[i]);
			btn.button({
				icons: {
					primary: btn.attr('icons_primary')
				}
			});
		}
		
		
		//수직분할
		$( ".hsplit" ).resizable({
			handles: "e",
			containment: ".split_containment",
			create: function( event, ui ) {
				$('.ui-resizable-e',$(this)).css({right: '0px', background: '#eeeeee', 'z-index':100});
			},
			stop: function(){
				$( window ).resize();
			}
		});
		//모바일에서 처리
		$( ".split_tab" ).tabs({
			load: function( event, ui ) {
				alert(1);
			}});
		
		//수평분할
		$( ".vsplit" ).resizable({
			handles: "s",
			containment: ".split_containment",
			create: function( event, ui ) {
				$('.ui-resizable-s',$(this)).css({bottom: '0px', background: '#eeeeee'});
			},
			stop: function(){
				$( window ).resize();
			}
		});
		//콘트롤 초기화
		initControl();
		//포틀릿 초기화
		initPortlet();
		//메뉴 초기화
		initMenu();
	}
	//포틀릿 초기화
	function initPortlet(){
		$(".portlet-column").sortable({
			connectWith : ".portlet-column",
			handle : ".portlet-header",
			cancel : ".portlet-toggle",
			placeholder : "portlet-placeholder ui-corner-all",
			
		});
		
		$( ".portlet-column" ).on( "sortstop", function( event, ui ) {
			var portletColumn = $( ".portlet-column" );
			
			for(var n=0; n<portletColumn.length; n++){
				var ids = "";
				var items = $(portletColumn[n]).children();
				
				for(var i=0; i<items.length; i++){
					ids += ',' + $(items[i]).attr('id');
				}
				
				$.cookie('portlet_'+n, ids.substring(1), {expires:60});
			}
		});
		
		var header = $(".portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all").find(".portlet-header").addClass("ui-widget-header ui-corner-all");
		header.prepend("<span class='ui-icon ui-icon-minusthick portlet-toggle' title='접기'></span>")
		header.prepend("<span class='ui-icon ui-icon-arrow-4-diag portlet-toggle-full' title='전체화면'></span>");
		header.prepend("<span class='ui-icon ui-icon-document portlet-toggle-sheet' title='시트보기'></span>");
		
		$(".portlet-toggle").click(function() {
			var icon = $(this);
			icon.toggleClass("ui-icon-minusthick ui-icon-plusthick");
			
			icon.closest(".portlet-item").find(".portlet-content").slideToggle();
		});
		//표 보이기
		$(".portlet-toggle-sheet").click(function() {
			var icon = $(this);
			icon.toggleClass("portlet-toggle-sheet-view");
			
			icon.closest(".portlet-item").find('.sheet').slideToggle();
		});
		//전체화면
		$(".portlet-toggle-full").click(function() {
			fullScreen($(this));
		});
		//전체화면
		$(".portlet-header").dblclick(function() {
			var portletItem = $(this).closest(".portlet-item");
			fullScreen(portletItem.find(".portlet-toggle-full"));
		});
		//전체화면
		function fullScreen(icon){
			
			icon.toggleClass("ui-icon-arrow-4-diag ui-icon-newwin");
			
			var portletItem = icon.closest(".portlet-item");
			var portletCol = $('.portlet-column');
			var portlet = portletItem.parent();
			
			portletCol.toggle();

			if(portlet.hasClass('portlet')){
				portlet.addClass('move');
				var portletContent = portletItem.find(".portlet-content");
				$(portletCol.get(0)).parent().append(portletItem);
				portlet.attr('height', portletContent.css('height'));
				portletContent.addClass('auto_height');
				portletContent.css({height: '97%'});
				$( window ).resize();
			}else{
				portlet = $('.move');
				portlet.removeClass('move');
				portlet.append(portletItem);
				var portletContent = portletItem.find(".portlet-content");
				portletContent.removeClass('auto_height');
				portletContent.css({height: portlet.attr('height')});
			}
			
			$( window  ).resize();
		}
		//쿠키에 의한 위치 재조정
		var portletColumn = $( ".portlet-column" );
		
		for(var n=0; n<portletColumn.length; n++){
			var pCol = $(portletColumn[n]);
			var ids = $.cookie('portlet_'+n).split(',');
			
			for(var i=0; i<ids.length; i++){
				pCol.append($('#'+ids[i]));
			}
		}

	}
	//메뉴 초기화
	function initMenu(){
		
		var menu = $('.menu');
		menu.menu({
		      items: '> :not(.ui-widget-header)'
	    });
		
		if(menu.length<1 || $.cookie('isMobile') != 'Y'){
			return;
		}
		
		var body = $('body');
		body.append('<div id="menu_left_div" class="hide_web"  style="position: fixed;left: 0; top: 0; height: 100%;width: 10px;"></div>');
		body.append('<div id="menu_div" style="position: fixed;left: 0; top: 0; height: 100%;background: #eeeeee; border:1px solid #cccccc;"></div>');
		body.append('<div id="menu-btn" class="hide_web" style="position: fixed;left: 0; bottom: 0;opacity: 0.8;filter: alpha(opacity=80);background: #ffffff;;"><img src="../images/icon/menu-icon.png"></div>');

		//메뉴버튼 생성
		$('#menu-btn').button().click(function( event ) {
			showMenu();
		});
		//모바일인 경우 메뉴를 바디로 옮기고 숨김
		$('#menu_div').hide( 'slide', {}, 500 );
		$('#menu_div').append(menu);
		
		function showMenu(){
			$('#menu_div').show( 'slide', {}, 500 );
		}

		var mc1 = new Hammer(document.getElementById('menu_div'));

		mc1.on("panleft", function(ev) {
			$('#menu_div').hide( 'slide', {}, 500 );
		});
		
		var mc2 = new Hammer(document.getElementById('menu_left_div'));

		mc2.on("panright", function(ev) {
			showMenu();
		});
	}
	
	function getVal(name, obj) {
		if (obj) {
			var $row = $('.' + $(obj).attr('row_index'));
			return $('[name=' + name + ']', $row).attr('value');
		} else {
			return $('[name=' + name + ']').attr('value');
		}
	}
	
	function addObject(target, source){

		if(source) {
			$.each(source, function(key, value){
				target[key] = value;
			});
		}

		return target;
	}

	//tags/tag/check_array.tag 에서 호출
	function changeCheck(ctls, name){
		var vals = "";
		for(var i=0; i<ctls.length; i++){
			var val = $(ctls[i]).val();
			vals += "," + val;
		}

		vals = vals.substring(1);

		$('.check_hidden[name='+name+']').val(vals);
	}

	function checkValidOnChange(){
		$(document).on('change', '[valid]', function(e){
			validItem(e.target);;
		});
	}
	
	function valid(formId){
		var ctls = $('[valid]',$(formId));
		
		for(var i=0; i<ctls.length ; i++){
			
			if(!validItem(ctls[i])){
				return false;
			};
		}
		//if($('#subject').val().indexOf('<')>-1){
		//	alert("'<' 문자는 사용할수 없습니다.");
		//	$('#subject').focus();
		//	return false;
		//}
		return true;
	}	
	function validItem(obj){
		var ctl =$(obj);
		var valids = ctl.attr('valid').split(',');
		
		for(var n=0; n<valids.length; n++){
			var opt = valids[n].split(':');
			var fnc = opt[0].trim();
			
			var isValid = $.valid_fnc[fnc](ctl, opt);
			if(!isValid){
				return false;
			}
		}
		return true;
	}
	
	
	
	//영문
	function alpa(event){
		if(event.charCode == 0 || (event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122)) {
			return true;
		}
		return false;	
	}

	//숫자
	function numeric(event){
		if(event.charCode == 0 ||  event.charCode >= 48 && event.charCode <= 57){ 
			return true;
		}
		return false;	
	}
	//영숫자
	function alpa_numeric(event){
		if(event.charCode == 0 ||  (event.charCode >= 48 && event.charCode <= 57) || (event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122)){ 
			return true;
		}
		return false;	
	}
	
	function mask(){
		//Get the screen height and width
		var maskHeight = $(window).height();
		var maskWidth = $(window).width();
		//Set height and width to mask to fill up the whole screen
		var mask = $('#mask');

		if(mask.length<1){
			$('body').append($('<div style="background: #cccccc; position:fixed;top: 0px;left: 0px;z-index: 9; text-align: center;padding-top: 200px;" id="mask"><img alt="loading" src="../jquery/icon/loading.gif" /></div>'));
			mask = $('#mask');
		}
		mask.css({'width':maskWidth,'height':maskHeight});
		
		//$('#mask').fadeIn(100);	//여기가 중요해요!!!1초동안 검은 화면이나오고
		$('#mask').fadeTo("slow",0.3);   //80%의 불투명도로 유지한다 입니다. ㅋ

	}
	function mask_off(){
		
		setTimeout(function () {
			$('#mask').hide();
			//alert(22);
		}, 1000);		
	}
	//정합성 체크함수 구현
	$.valid_fnc = {
		notempty : function(ctl){
			if(ctl.val().trim()=='' || ctl.val().trim()=='<br>'){
				alert($('[label='+ctl.attr('name')+']').text() + '에 값이 없습니다.');
				ctl.focus();
				return false;
			}
			return true;
		},
		date : function(ctl){
			if(ctl.val().trim()==''){
				return true;
			}

			try{
				$.datepicker.parseDate( option.dateFormat, ctl.val());
			}catch(e){
				alert($('[label='+ctl.attr('name')+']').text() + '의 값이 올바른 날짜의 값이 아닙니다. 날짜를 입력하세요.');
				ctl.focus();
				return false;
			}

			return true;
		},
		rangedate : function(ctl, opt){
			if($('#'+opt[1]).val() > $('#'+opt[2]).val()){
				alert($('[label='+ctl.attr('name')+']').text() + "의 시작일이 종료일보다 클 수 없습니다.");
				ctl.focus();
				return false;
			}
			return true;
		},
		ext : function(ctl, opt){
			var val = ctl.val().toLowerCase();
			if(val=='') {
				return true;
			}
			for(var i=1; i<opt.length; i++){
				if(val.endsWith('.'+opt[i])){
					return true;
				}
			}
			
			alert($('[label='+ctl.attr('name')+']').text() + "에 첨부한 문서 종류는 등록 할 수 없습니다.");
			ctl.focus();
			return false;
			
		}
				
	};
	
