// a JS class.
function AjaxHelper(elem){
	var _element = elem;
	var self = this;
	this.disabedZone = "AjaxDisabledZone";
	this.messageZone = "AjaxMessageZone";
	this.createLoadingDiv = function(){
		var d = document.createElement("div");
		d.setAttribute('id',MyAjaxHelper.disabedZone);
		document.body.appendChild(d);
		
		var m = document.createElement('div');
		m.setAttribute('id', MyAjaxHelper.messageZone);
    	d.appendChild(m);
    	var t = document.createTextNode('Please wait');
    	m.appendChild(t);
    	this.hideLoadingDiv();
	}
	this.showLoadingDiv = function(){
		_element.show(this.disabedZone);
	}
	this.hideLoadingDiv = function(){
		_element.hide(this.disabedZone);
	}
}

var MyAjaxHelper = new AjaxHelper(Element);

addLoadEvent( function(){
	MyAjaxHelper.createLoadingDiv();
});

var myGlobalHandlers = {
	onCreate: function(){
		MyAjaxHelper.showLoadingDiv();
		$("message").className="hide";
		
	},
	onComplete: function() {
		if(Ajax.activeRequestCount == 0){
			MyAjaxHelper.hideLoadingDiv();
		}
	}
};
// these are handlers that will occur on start and completion of each Ajax request.
Ajax.Responders.register(myGlobalHandlers);