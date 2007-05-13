function Issue(link){
	var self = this;
	var _link = link;
	this.getIssues = function(f){
		//var url = link;
		var pars = Form.serialize(f);
		pars+= '&AjaxUniqueID=' + new Date().getTime();
		var myAjax = new Ajax.Request(
				_link, 
				{
					method: 'get', 
					parameters: pars, 
					onComplete : function(resp,jsonObj){
						var tbody = $('issueTable').getElementsByTagName('tbody')[0];
						tbody.innerHTML = '';
						tbody.innerHTML = resp.responseText.trim();							
					}
				}
		);
	}
}