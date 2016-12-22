window.defaultStatus = document.title;

String.prototype.trim=trim;
function trim(){
	re = /(^\s*)|(\s*$)/g;
	return this.replace(re,"");
}

String.prototype.replaceAll = strReplace;
function strReplace(findText, replaceText) {
   var str = new String(this);
   while (str.indexOf(findText)!=-1) {
      str = str.replace(findText, replaceText);
   }
   return str;
}

function getToday() {
	var date = new Date();
	var year = new String(date.getFullYear());
	var month = new String(date.getMonth() + 1);
	var day = new String(date.getDate());
	if(month.length < 2){
		month = "0" + month;
	}
	if(day.length < 2){
		day = "0" + day;
	}
	return year + "/" + month + "/" + day;
}

function isDate(s) {
	var re_date = /^\s*(\d{2,4})\/(\d{1,2})\/(\d{1,2})\s*$/;
	if (!re_date.exec(s)) {
		//alert ("日期格式錯誤: '" + s + "'.\n請輸入 yyyy/mm/dd.");
		return false;
	}
	var n_day = Number(RegExp.$3),
		n_month = Number(RegExp.$2),
		n_year = Number(RegExp.$1);
	
	if (n_year < 100)
		n_year += (n_year < this.a_tpl.centyear ? 2000 : 1900);
	if (n_month < 1 || n_month > 12) {
		//alert ("月份請輸入 01-12");
		return false;
	}
	var d_numdays = new Date(n_year, n_month, 0);
	if (n_day > d_numdays.getDate()) {
		//alert(n_month + "月份日期應介於 01-" + d_numdays.getDate());
		return false;
	}

	return true;
}

function isInt(theNum) {
	return ((theNum + '').match(/^(-)?\d+$/) != null);
}

function isDecimal(theNum) {
	return ((theNum + '').match(/^(((-)?\d+(\.\d*)?)|((-)?(\d*\.)?\d+))$/) != null);
}
    
//function isNum(s){
//	return isCharsInBag(s, "0123456789");
//}

function convertNum(obj) {
	var charCodeDash = 65123; // 全形﹣
	var charCodeDot  = 65294; // 全形．: 46+65248
	var charCode0    = 65296; // 全形０: 48+65248
	var charCode9    = 65305; // 全形９: 57+65248
	var tmp =  new Array();
	var a = obj.value;
	var b = "";
	for(var i = 0; i < a.length; i++) {
		if ((a.charCodeAt(i) <= charCode9 && a.charCodeAt(i) >= charCode0) || a.charCodeAt(i) == charCodeDot){
			tmp[i] = a.charCodeAt(i) - 65248; //轉半形 (unicode-65248)
		} else if (a.charCodeAt(i) == charCodeDash) {
			tmp[i] = 45;
		} else {
			tmp[i] = a.charCodeAt(i);
		}
		b += String.fromCharCode(tmp[i]);
	}
	obj.value = b;
}

