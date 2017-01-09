$(document).ready(function(){
    $('form').attr('autocomplete', 'off');
    
    initEvent();
	
	fix_css();
});

function initEvent() {
	 /*JQuery 限制文本框只能输入数字*/
	appendKeyupEventNumText();
	
	/*JQuery 限制文本框只能输入数字和小数点*/
	appendKeyupEventNumDecText();

	/*JQuery 限制文本框只能输入英數字和底線*/
	appendKeyupEventWordText();
	
	/*綁定[日期/時間]事件*/
	appendDateTimeEvent();
}

function fix_css(){
	$(".div-button-area .btn-default").each(function(index) {
		$(this).addClass("btn-success");
	});
	$(".div-search .btn-default").each(function(index) {
		$(this).addClass("btn-primary");
	});
	$(".div-result .btn-default").each(function(index) {
		$(this).addClass("btn-info");
	});
	$(".div-edit .btn-default").each(function(index) {
		$(this).addClass("btn-info");
	});
}

/**
 * 綁定keyup事件(只能輸入數字)
 * @param cssName
 * @param keyup str
 */
function appendKeyupEventNumText() {
	//appendKeyupEvent("NumText",/\D|^0/g);
	//修正不能輸入0
	appendKeyupEvent("NumText",/\D/g);
}

/**
 * 綁定keyup事件(只能輸入數字和小數點)
 * @param cssName
 * @param keyup str
 */
function appendKeyupEventNumDecText() {
	appendKeyupEvent("NumDecText",/[^0-9.]/g);   
}

/**
 * 綁定keyup事件(英數字和底線)
 * @param cssName
 * @param keyup str
 */
function appendKeyupEventWordText(cssName,str) {
	appendKeyupEvent("WordText",/\W/g);   
}

/**
 * 綁定keyup事件
 * @param cssName
 * @param keyup str
 */
function appendKeyupEvent(cssName,str) {
	$("."+cssName).keyup(function() {
		$(this).val($(this).val().replace(str, ''));
	}).bind("paste", function() { //CTR+V事件处理    
		$(this).val($(this).val().replace(str, ''));
	}).css("ime-mode", "disabled"); //CSS设置输入法不可用    
}

/**
 * 綁定[日期/時間]事件
 */
function appendDateTimeEvent() {
	
	//預設瀏覽器語系
	var loginLang = $("#temp_loginLang").val();
	if(loginLang!=null && loginLang!=""){
		$.datepicker.setDefaults($.datepicker.regional[loginLang]);
		$.timepicker.setDefaults($.timepicker.regional[loginLang]);
	}	
	
	do_datepicker();		
	
}

function do_datepicker(){
	$.datepicker.regional['zh-TW']={
	   dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
	   dayNamesMin:["日","一","二","三","四","五","六"],
	   monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
	   monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
	   prevText:"上月",
	   nextText:"次月",
	   weekHeader:"週"
	   };
	$.datepicker.setDefaults($.datepicker.regional["zh-TW"]);
	
	$(".DateText").datepicker({
		showMonthAfterYear:true,
		dateFormat:"yy-mm-dd"
	});
	
	$(".DateText").change(function(index) {
		checkObjIsDate($(this).attr("name"));
	});
}

function do_datetimepicker(){
	$(".DateTimeText").datetimepicker({
		lang:'ch',
		timepicker:true,
		format:'Y-m-d H:i',
		formatTime:'H:i',
		formatDate:'Y-m-d',
		defaultTime:'00:00'
	});	
	
	$(".DateText").datetimepicker({
		lang:'ch',
		timepicker:false,
		format:'Y-m-d',
		formatDate:'Y-m-d'
	});
	
	$(".TimeText").datetimepicker({
		datepicker:false,
		format:'H:i',
		step:5
	});
}

function getSelfForm(event, method, lock) {
	var oform;
	$("form:first").each(function(index) {
		oform = this;
		var actionValue = $(oform).attr("action");
		actionValue = actionValue.replace('.do', '');
		var action = actionValue;

		if (actionValue.indexOf(";jsessionid") > 0) {
			actionValue = actionValue.substring(0, actionValue.indexOf(";jsessionid"));
			action = actionValue;
		}
		
		if (actionValue.indexOf("?") > 0) {
			action = actionValue.substring(0, actionValue.indexOf("?"));
		}
		if (action.indexOf("!") > 0) {
			action = action.substring(0, action.indexOf("!"));
		}
		action += ((method != null && method != '')? "!" + method : "") + ".do";
		
		if (actionValue.indexOf("?") > 0) {
			action += actionValue.substring(actionValue.indexOf("?"));
		}
		//alert(action);
		$(oform).attr("action", action);
	});
	return oform;
}

/**
 * 日期檢查
 * @param dateString
 * @returns {Boolean}
 */
function validateDate(dateString){	
	if (dateString == ''){
		return true;
	}
	dateString = dateString.replace(/\-/g,"/");
	
	//重點 如果沒有用^開頭跟結尾$就不會是完全比對,而會是模糊比對了,另外\/要用[]隔起來XD
    if(/^\d{4}[\/]\d{2}[\/]\d{2}$/.test(dateString)){
        var temp = dateString.split("/");
        if(parseInt(temp[1],10)<13 && parseInt(temp[1],10)>0){
            if(/^([0][13578])|([1][12])$/.test(temp[1])){
                if(parseInt(temp[2],10)==0 || parseInt(temp[2],10)>31){
                    return false;
                }
            }else{
                if(/^02$/.test(temp[1])){
                    if(parseInt(temp[0],10)%4==0){
                        if(parseInt(temp[2],10)==0 || parseInt(temp[2],10)>29){
                            return false;
                        }
                    }else {
                        if(parseInt(temp[2],10)==0 || parseInt(temp[2],10)>28){
                            return false;
                        }
                    }
                }else {
                    if(parseInt(temp[2],10)==0 || parseInt(temp[2],10)>30){
                        return false;
                    }
                }
            }
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

/**
 * 時間檢查
 * @param timeString
 * @returns {Boolean}
 */
function validateTime(timeString){	
	if (timeString == ''){
		return true;
	}
	
	//重點 如果沒有用^開頭跟結尾$就不會是完全比對,而會是模糊比對了,另外\/要用[]隔起來XD
    if(/^\d{2}[\:]\d{2}$/.test(timeString)){
        var temp = timeString.split(":");
    	
        if(parseInt(temp[1],10)<60 && parseInt(temp[1],10)>=0){
        	if(parseInt(temp[0],10)>=24 || parseInt(temp[0],10)<0){
        		return false;
        	}
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

/**
 * 日期時間檢查
 * @param datetimeString
 * @returns {Boolean}
 */
function validateDateTime(datetimeString){	
	if (datetimeString == ''){
		return true;
	}
	datetimeString = datetimeString.replace(/\-/g,"/");
	datetimeString = datetimeString.replace(/\s/g,"/");

	//重點 如果沒有用^開頭跟結尾$就不會是完全比對,而會是模糊比對了,另外\/要用[]隔起來XD
	if(/^\d{4}[\/]\d{2}[\/]\d{2}[\/]\d{2}[\:]\d{2}$/.test(datetimeString)){
		datetimeString = datetimeString.replace(/\:/g,"/");
        var temp = datetimeString.split("/");
        var dateString = temp[0] + "/" + temp[1] + "/" + temp[2];
        var timeString = temp[3] + ":" + temp[4];

        if(validateDate(dateString) && validateTime(timeString)){
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

/**
 * 檢查日期欄位(input byName)
 * @param objname
 * @returns {Boolean}
 */
function checkObjIsDate(objname) {
	var msg = 'YYYY-MM-DD';
	var isOK = true;
	$("input[name='" + objname + "']").each(function(index) {
		var dateString = $(this).val();
		//clear...
		clearCheckError($(this));
		
		if (dateString == '') {
			$(this).val("");
		}else if(dateString.split("-").length!=3){
			$(this).val("");
			showCheckError($(this), msg);
		}else{
			dateString = dateString.replace(/\-/g,"/");
			var isDate = validateDate(dateString);
			if(!isDate){
				showCheckError($(this), msg);
			}			
			isOK = (isDate && isOK);
		}
	});	
	return isOK;
}

/**
 * 檢查時間欄位(input byName)
 * @param objname
 * @returns {Boolean}
 */
function checkObjIsTime(objname) {
	var msg = 'hh:mm';
	var isOK = true;
	$("input[name='" + objname + "']").each(function(index) {
		var timeString = $(this).val();
		//clear...
		clearCheckError($(this));
		
		if (timeString == '') {
			$(this).val("");
		}else{
			var isTime = validateTime(timeString);
			if(!isTime){
				showCheckError($(this), msg);
			}			
			isOK = (isTime && isOK);
		}
	});	
	return isOK;
}

/**
 * 檢查日期時間欄位(input byName)
 * @param objname
 * @returns {Boolean}
 */
function checkObjIsDateTime(objname) {
	var msg = 'YYYY-MM-DD hh:mm';
	var isOK = true;
		
	$("input[name='" + objname + "']").each(function(index) {
		var datetimeString = $(this).val();
		//clear...
		clearCheckError($(this));		
		
		if (datetimeString == '') {
			$(this).val("");
		}else{
			var isDateTime = validateDateTime(datetimeString);
			if(!isDateTime){
				showCheckError($(this), msg);
			}			
			isOK = (isDateTime && isOK);
		}
	});	
	return isOK;
}

function showCheckError(obj, errMsg) {
	if (!obj.next(".help-block").length) {
		if(errMsg!=null) {
			obj.after("<span class='help-block'>" + errMsg + "</span>");
		}else{
			obj.parent().addClass("bg-danger" );
		}
		obj.parent().parent().addClass("has-error has-feedback");
	}
}

function clearCheckError(obj) {
	obj.next(".help-block").remove();
	obj.parent().parent().removeClass("has-error has-feedback");
	obj.parent().removeClass("bg-danger" );
}

/**
 * 檢查必要欄位(input+label byName)
 * @param objname
 * @return boolean
 */
function checkObjNotNull(objname) {
	var msg = '';
	var msg_err = $("#temp_notNullMsg").val();
	if (msg_err==null || msg_err == "") {
		msg_err = "not null";
	}
	var labels = document.getElementsByName("label." + objname);
	var objs = document.getElementsByName(objname);

	if (objs.length != labels.length) {
		//msg = "[checkObjNotNull] labelName!=label."+objname+", objs="+objs.length+", labels="+labels.length;			

		$("input[name='" + objname + "']").each(function(index) {
			if($(this).attr("type") == "text"){
				$(this).val(jQuery.trim($(this).val()));
			}			
			if ($(this).val() == '' && $(this).attr('disabled')!='disabled' ) {
				msg = msg_err;
				showCheckError($(this), msg);
				$(this).focus();
			} else {
				//clear...
				clearCheckError($(this));
			}
		});

		$("select[name='" + objname + "']").each(function(index) {
			if ($(this).val() == '') {
				msg = msg_err;
				showCheckError($(this), msg);
				$(this).focus();
			} else {
				//clear...
				clearCheckError($(this));
			}
		});
		
		$("textarea[name='" + objname + "']").each(function(index) {
			if ($(this).val() == '') {
				msg = msg_err;
				showCheckError($(this), msg);
				$(this).focus();
			} else {
				//clear...
				clearCheckError($(this));
			}
		});

	} else {

		//clear...
		for (i = 0; i < labels.length; i++) {
			var elem = labels[i];
			if (elem != null && elem.textContent != undefined) {
				elem.textContent = "";
			}
		}

		//check...	
		for (i = 0; i < objs.length; i++) {
			var obj = objs[i];
			if (obj.value == '') {
				msg = msg_err;
				var elem = labels[i];
				if (elem != null && elem.textContent != undefined) {
					elem.textContent = msg_err;
					obj.focus();
				}
			}
		}
	}

	return (msg == '');
}

/**
 * 檢查必要欄位(input byName)
 * @param objName
 * @return boolean
 */
function checkObjNotNull_checkbox(objName) {
	var isOK = false;

	$("input[name='" + objName + "']:checked").each(function(){   
		isOK = true;    
	});
	
	$("input[name='" + objName + "']").each(function(index) {
		if(!isOK){
			showCheckError($(this), null);
		}else{
			clearCheckError($(this));
		}
	});
	
	if($("input[name='" + objName + "']").length==0) {
		isOK = true;
	}

	return isOK;
}

/**
 * 檢查起迄日期大小是否正確
 * @param objname1 開始日期
 * @param objname2 結束日期
 * @returns {Boolean}
 */
function checkObjDateExceed(objname1, objname2) {
	var msg = '';
	var msg_err = $("#temp_dateExceedMsg").val();
	if (msg_err==null || msg_err == "") {
		msg_err = "date exceed";
	}
	
	var obj1 = $("input[name='"+objname1+"']");
	var obj2 = $("input[name='"+objname2+"']");
	var d1 = $(obj1).val();
	var d2 = $(obj2).val();
	if(d1!=undefined && d2!=undefined && d1!="" && d2!=""){
		d1 = new Date(d1.replace(/\-/g,'/'));
		d2 = new Date(d2.replace(/\-/g,'/'));
		if(d1>d2){
			msg = msg_err;
			showCheckError($(obj1), msg);
			showCheckError($(obj2), msg);
			$(obj1).focus();
		}
	}

	return (msg == '');
}

/**
 * debug顯示訊息用
 * @param msg
 */
function sLog(msg) {
	try {
		$("#divError").html(msg);
		if (msg != null && msg.length > 0) {
			$("#divError").show();
		} else {
			$("#divError").hide();
		}
	} catch (err) {
		alert(err);
	}
}

/**
 * 顯示Info訊息
 * @param msg
 */
function showInfo(msg) {
	try {
		$("#divInfo").html(msg);
		if (msg != null && msg.length > 0) {
			$("#divInfo").show();
		} else {
			$("#divInfo").hide();
		}
	} catch (err) {
		alert(err);
	}
}

/**
 * 顯示Error訊息
 * @param msg
 */
function showError(msg) {
	try {
		$("#divError").html(msg);
		if (msg != null && msg.length > 0) {
			$("#divError").show();
		} else {
			$("#divError").hide();
		}

	} catch (err) {
		alert(err);
	}
}

/**
 * 自動完成關鍵字查詢[使用者群組]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteGroupUsers(obj, hiddenId, tbodyId) {
	autocompleteList(obj, hiddenId, tbodyId, "query!queryGroupUsers.do", null);
}

/**
 * 自動完成關鍵字查詢[部門群組]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteGroupDepts(obj, hiddenId, tbodyId) {
	autocompleteList(obj, hiddenId, tbodyId, "query!queryGroupDepts.do", null);
}

/**
 * 自動完成關鍵字查詢[部門]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteDepts(obj, hiddenId, tbodyId) {
	autocompleteList(obj, hiddenId, tbodyId, "query!queryDepts.do", null);
}

/**
 * 自動完成關鍵字查詢[使用者]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteUsers(obj, hiddenId, tbodyId) {
	autocompleteList(obj, hiddenId, tbodyId, "query!queryUsers.do", null);
}

/**
 * 自動完成關鍵字查詢[使用者]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteUsersByTenant(obj, hiddenId, tenantHash, tbodyId) {
	var optJson = null;
	if (tenantHash != null) {
		optJson = {
			"tenantHash" : tenantHash
		};
	}
	autocompleteList(obj, hiddenId, tbodyId, "query!queryUsersByTenant.do", optJson);
}

/**
 * 自動完成關鍵字查詢[使用者]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteMultiUsersByTenant(obj, hiddenId, tenantHash, repeatMsg, tbodyId) {
	var optJson = null;
	if (tenantHash != null) {
		optJson = {
			"tenantHash" : tenantHash
		};
	}
	autocompleteMultiList(obj, hiddenId, repeatMsg, tbodyId, "query!queryUsersByTenant.do", optJson);
}

/**
 * 自動完成關鍵字查詢[Parent Menu]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param kind 選單種類:前台app(1), 後台web(2)
 * @param tbodyId
 */
function autocompleteParentMenu(obj, hiddenId, kind, tbodyId) {
	var optJson = null;
	if (kind != null) {
		optJson = {
			"kind" : kind
		};
	}
	autocompleteList(obj, hiddenId, tbodyId, "query!queryParentMenus.do", optJson);
}
/**
 * 自動完成關鍵字查詢[Menu]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param kind 選單種類:前台app(1), 後台web(2)
 * @param tbodyId
 */
function autocompleteMenus(obj, hiddenId, kind, tbodyId) {
	var optJson = null;
	if (kind != null) {
		optJson = {
			"kind" : kind
		};
	}
	autocompleteList(obj, hiddenId, tbodyId, "query!queryMenus.do", optJson);
}

/**
 * 自動完成關鍵字查詢[圖檔]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param kind 圖檔種類:小圖示(1), 背景圖(2), LOGO(3)
 * @param tbodyId
 */
function autocompletePhotos(obj, hiddenId, kind, tbodyId) {
	var optJson = null;
	if (kind != null) {
		optJson = {
			"kind" : kind
		};
	}
	autocompleteList(obj, hiddenId, tbodyId, "query!queryPhotos.do", optJson);
}

/**
 * 自動完成關鍵字查詢[個案]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteContentTitles(obj, hiddenId, tbodyId) {
	autocompleteList(obj, hiddenId, tbodyId, "query!queryContentTitles.do", null);
}


/**
 * 自動完成關鍵字查詢[活動]
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId
 */
function autocompleteEventTitles(obj, hiddenId, tbodyId) {
	autocompleteList(obj, hiddenId, tbodyId, "query!queryEventTitles.do", null);
}

/**
 * 自動完成關鍵字查詢
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId (非必要欄位)
 * @param optJson (非必要欄位)
 * @actionName url名稱
 * @returns
 */
function autocompleteList(obj, hiddenId, tbodyId, actionName, optJson) {
	var ajaxAsync = $.ajaxSettings.async;
	$.ajaxSettings.async = false;//同步執行
	var isSelect = false;
	try {

		if (obj == null || obj.id == null)
			return null;
		if (actionName == null || actionName == undefined)
			return null;
		if (tbodyId == null || tbodyId == undefined) {
			tbodyId = "";
		} else {
			tbodyId = "#" + tbodyId;
		}
		tbodyId = tbodyId + " input[id='" + obj.id + "']";
		//多筆物件相同name時.id以-序號區分..
		if (obj != null && obj.id != null && hiddenId != null) {
			var objId = obj.id;
			if (objId.indexOf("-") > 0) {
				hiddenId = hiddenId + "-" + objId.substr(objId.indexOf("-") + 1)
			}
		}
		//sLog("tbodyId="+tbodyId+",obj.id="+obj.id);

		$(tbodyId).autocomplete({
			source : function(request, response) {
				var jsonObj = {
					"name" : encodeURI(request.term)
				};//中文亂碼問題-encodeURI
				if (optJson != null) {
					//sLog("optJson="+JSON.stringify(optJson));
					// Merge object2 into object1
					$.extend(jsonObj, optJson);
					console.log("jsonObj="+JSON.stringify(jsonObj));
				}

				$.getJSON(actionName, jsonObj, function(data) {
					console.log(JSON.stringify(data));
					response(data);
				}).fail(function(err) {
				    console.log( "error:" + JSON.stringify(err) );
				});
			},
			minLength : 1,//最少輸入字元數.才啟動
			select : function(event, ui) {
				isSelect = true;
				//sLog(ui.item ?  "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
				if (hiddenId != null && hiddenId != "") {
					//sLog(hiddenId);
					var elem = document.getElementById(hiddenId);
					if (elem != null && ui.item) {
						elem.value = ui.item.hidden;
					}
					
					elem = document.getElementById(hiddenId + ".extra");
					if (elem != null && ui.item && ui.item.extra) {
						elem.innerHTML = ui.item.extra;
					}
					
					elem = document.getElementById(hiddenId + ".image");
					if (elem != null && ui.item && ui.item.icon) {
						elem.src = ui.item.icon;
					}
				}
			},
			open : function() {
				$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
			},
			close : function() {
				//sLog("close..."+isSelect);
				$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
				//clear...					
				if (!isSelect) {
					obj.value = "";
					autocompleteListClear(obj, hiddenId);
				}
			}
		}).bind("input.autocomplete", function() {
			//註解下列程式:ajax輸入中文被清空
			//sLog("autocomplete-search~"+this.value);
			//$(this).autocomplete("search", this.value);
		}).bind("change", function() {
			//clear...
			autocompleteListClear(obj, hiddenId);
		});
		autocompleteListClear(obj, hiddenId);
	} catch (err) {
		showError(err);
	}
	$.ajaxSettings.async = ajaxAsync;
}

/**
 * 自動完成關鍵字查詢
 * @param obj (id不可有小數點.jquery有ERROR)
 * @param hiddenId 選擇後要設定的物件id
 * @param tbodyId (非必要欄位)
 * @param optJson (非必要欄位)
 * @actionName url名稱
 * @returns
 */
function autocompleteMultiList(obj, hiddenId, repeatMsg, tbodyId, actionName, optJson) {
	var ajaxAsync = $.ajaxSettings.async;
	$.ajaxSettings.async = false;//同步執行
	var isSelect = false;
	var isRepeat = false;
	var oriHiddenIdArry = hiddenId.split(",");
	var hiddenIdArry = hiddenId.split(",");
	try {

		if (obj == null || obj.id == null)
			return null;
		if (actionName == null || actionName == undefined)
			return null;
		if (tbodyId == null || tbodyId == undefined) {
			tbodyId = "";
		} else {
			tbodyId = "#" + tbodyId;
		}
		tbodyId = tbodyId + " input[id='" + obj.id + "']";
		//多筆物件相同name時.id以-序號區分..
		if (obj != null && obj.id != null && hiddenId != null) {
			var objId = obj.id;
			if (objId.indexOf("-") > 0) {
				
				for (var i = 0; i < hiddenIdArry.length; i++) {
					hiddenIdArry[i] = hiddenIdArry[i] + "-" + objId.substr(objId.indexOf("-") + 1);
				}
			}
		}
		//sLog("tbodyId="+tbodyId+",obj.id="+obj.id);

		$(tbodyId).autocomplete({
			source : function(request, response) {
				var jsonObj = {
					"name" : encodeURI(request.term)
				};//中文亂碼問題-encodeURI
				if (optJson != null) {
					//sLog("optJson="+JSON.stringify(optJson));
					// Merge object2 into object1
					$.extend(jsonObj, optJson);
					console.log("jsonObj="+JSON.stringify(jsonObj));
				}

				$.getJSON(actionName, jsonObj, function(data) {
					console.log(JSON.stringify(data));
					response(data);
				}).fail(function(err) {
				    console.log( "error:" + JSON.stringify(err) );
				});
			},
			minLength : 1,//最少輸入字元數.才啟動
			select : function(event, ui) {
				isSelect = true;
				
				if(repeatMsg != null && repeatMsg != ''){
					for(var i = 0; i < hiddenIdArry.length; i++){
						$("input[id^='" + oriHiddenIdArry[i] + "']").each(function(index) {
							if($(this).val() == ui.item.hidden){
								isRepeat = true;
								return;
							}
						});
						if(isRepeat){
							return;
						}
					}
					if(isRepeat){
						return;
					}
				}
				
				//sLog(ui.item ?  "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
				for(var i = 0; i < hiddenIdArry.length; i++){
					
					if (hiddenIdArry[i] != null && hiddenIdArry[i] != "") {
						//sLog(hiddenId);
						var elem = document.getElementById(hiddenIdArry[i]);
						if (elem != null && ui.item) {
							elem.value = ui.item.hidden;
						}
						
						elem = document.getElementById(hiddenIdArry[i] + ".extra");
						if (elem != null && ui.item && ui.item.extra) {
							elem.innerHTML = ui.item.extra;
						}
						
						elem = document.getElementById(hiddenIdArry[i] + ".image");
						if (elem != null && ui.item && ui.item.icon) {
							elem.src = ui.item.icon;
						}
					}
				}
				
			},
			open : function() {
				$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
			},
			close : function() {
				//sLog("close..."+isSelect);
				$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
				//clear...					
				if (!isSelect || isRepeat) {
					
					obj.value = "";
					
					for(var i = 0; i < hiddenIdArry.length; i++){
						autocompleteListClear(obj, hiddenIdArry[i]);
					}
					
					if(isRepeat){
						alert(repeatMsg);
					}
					isRepeat = false;
				}
			}
		}).bind("input.autocomplete", function() {
			//註解下列程式:ajax輸入中文被清空
			//sLog("autocomplete-search~"+this.value);
			//$(this).autocomplete("search", this.value);
		}).bind("change", function() {
			//clear...
			for(var i = 0; i < hiddenIdArry.length; i++){
				autocompleteListClear(obj, hiddenIdArry[i]);
			}
		});
		for(var i = 0; i < hiddenIdArry.length; i++){
			autocompleteListClear(obj, hiddenIdArry[i]);
		}
	} catch (err) {
		showError(err);
	}
	$.ajaxSettings.async = ajaxAsync;
}

/**
 * 清除欄位
 * @param obj
 * @param hiddenId
 */
function autocompleteListClear(obj, hiddenId) {
	if (obj.value == "") {
		var elem = document.getElementById(hiddenId);
		if (elem != null) {
			elem.value = "";
		}
		elem = document.getElementById(hiddenId + ".image");
		if (elem != null) {
			elem.src = "";
		}
	}
}

function fnQuery(event, method) {
	if(method === undefined) {
		method = '';
	} 
	$("#pageElement_currentPage").val('1');
	var oForm = getSelfForm(event, method);	
	oForm.submit();
}
function fnInit(event,objName) {
	var sel = $('input[name="' + objName + '"]').val();
	if(sel==''){
		fnInitAdd(event,sel,objName);
	}else{
		fnInitModify(event,sel,objName);
	}
}
function fnInitAdd(event,sel,objName) {	
	$('input[name="' + objName + '"]').val('');
	var oForm = getSelfForm(event,'initAdd');	
	oForm.submit();
}
function fnInitModify(event,sel,objName) {	
	$('input[name="' + objName + '"]').val(sel);
	var oForm = getSelfForm(event,'initModify');	
	oForm.submit();
}
function fnSave(event,objName) {
	if (fnCheck()) {
		var sel = $('input[name="' + objName + '"]').val();
		if(sel==''){
			fnAdd(event);
		}else{
			fnModify(event);
		}
	}
}
function fnAdd(event) {	
	var oForm = getSelfForm(event,'add');	
	oForm.submit();
}
function fnModify(event) {	
	var oForm = getSelfForm(event,'modify');	
	oForm.submit();
}
function fnRemove(event, confirmMsg) {
	if (confirm(confirmMsg)) {
		var oForm = getSelfForm(event, 'remove');
		oForm.submit();
	}
}
function fnRemoveArray(event, confirmMsg, inputName, requiredCheckboxMsg) {
	try {
		if ($("input[name='" + inputName + "']:checked").length <= 0) {
			alert(requiredCheckboxMsg);
			return false;
		}

		fnRemove(event, confirmMsg);
	} catch (err) {
		alert(err.message);
	}
}
function fnReload(event) {	
	var oForm = getSelfForm(event,'reload');	
	oForm.submit();
}
function fnReset(event) {
	$(".RESET_ITEM").val('');
	$(".RESET_ITEM").prop('selectedIndex',0);
	fnQuery(event);
}

function setCookie(cname, cvalue, exdays) {	
	$.cookie.raw = true;
	
	console.log("setCookie:cvalue=" + cvalue);
	removeCookie(cname);
	
	if(exdays>0) {
		$.cookie(cname, cvalue, { expires: exdays, path: '/'});
	}else{
		$.cookie(cname, cvalue, { path: '/'});
	}	
}

function getCookie(cname) {
	var cvalue = $.cookie(cname);
	return (cvalue==undefined) ? "" : cvalue;
}

function removeCookie(cname) {
	console.log(cname + "--before:" + document.cookie);
	if(cname==null || cname==undefined) {
		cname = "collapse";
	}
	$.removeCookie(cname, { path: '/' });
	$.removeCookie(cname);
    console.log(cname + "--after:" + document.cookie);
}

function setLeftMenuCollapse(menuId) {
	var collapse = menuId;
	setCookie("collapse", collapse, 1);
	
	console.log("getCookie:collapse=" + getCookie("collapse"));
    console.log("document.cookie:" + document.cookie);
}

function initLeftMenuCollapse() {
	var collapse = getCookie("collapse");
	console.log("initLeftMenuCollapse.collapse:" + collapse);
	console.log("document.cookie:" + document.cookie);
	if (collapse.length > 0) {
		$("#li-" + collapse).addClass("active");
		$("#ul-" + collapse).addClass("in");
	}
}
