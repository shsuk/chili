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
	//초기 로딩이나 ajx로딩 완료시 콘트롤 초기화
	function ininControl(){
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
		//콘트롤 초기화
		initControl();
	}
	
	$(function() {
		try {
			ininControl();
		} catch (e) {
			// TODO: handle exception
		}
		
		//콘트롤값 변경시 정합성 체크(미사용시 삭제)
		checkValidOnChange();
		
		try {
			
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
				ininControl();
			});
		} catch (e) {
			// TODO: handle exception
		}
		
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
		//로딩 이미지
		//var loading = $('<img alt="loading" src="../jquery/icon/loading.gif" />').appendTo(document.body).hide();
	  //  $(window).ajaxStart(loading.show);
	  //  $(window).ajaxStop(loading.hide);

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
	});
	
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
		
		setInterval(function () {
			$('#mask').hide();
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
				
	}
	
