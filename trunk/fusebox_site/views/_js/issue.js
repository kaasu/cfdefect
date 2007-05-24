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
						var issueDiv = $$("div#issues")[0];
						issueDiv.innerHTML = '';
						issueDiv.innerHTML = resp.responseText;							
					}
				}
		);
	}
}