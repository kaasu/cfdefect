function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    }
  }
}

var myrules = {
	'a.delete' : function(el){
		el.onclick = function(){
			var f = $(el.getAttribute('targetform'));
			if (isChecked(f.chkid)){
				var con = confirm("Are you sure you want to delete these records");
				if (con)
					f.submit();
			}
		}
	}
	,'input.cancel': function(el){
		el.onclick = function(){
			document.location.href = el.getAttribute('location');
		}
	}
	,'select.filter': function(el){
		el.onchange = function(){
			issue.getIssues(el.form);
		}
	}
	,'input.filter' : function(el){
		el.onclick = function(){
			//var e = el.form.keyword.value;
			//if (e.trim().length > 0)
				issue.getIssues(el.form);
		}
	}
	,'input.reset' : function(el){
		el.onclick = function(){
			console.log(el.form);
			Form.reset('filterIssueForm');
		}
	}
};

Behaviour.register(myrules);

function isChecked(chk){
	if (chk.length){
		for (var i=0;i<chk.length;i++){
			if (chk[i].checked==true)
				return true;
		}	
	}
	else
		return chk.checked==true;
	
}

String.prototype.trim = function() {
	var a = this.replace(/^\s+/, '');
	return a.replace(/\s+$/, '');
};