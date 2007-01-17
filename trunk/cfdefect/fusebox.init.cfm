<cfsilent>
<cfscript>
self = "index.cfm";
myself = self & '?' & myFusebox.getApplication().fuseactionVariable & '=';
Controller = myFusebox.getApplication().getApplicationData().get( COLDSPRING_FACTORY_NAME ).getBean( 'Controller' );
Controller.OnRequestStart( event );
event.setValue( 'myself', myself );
//some global xfa
xfa.home = 'c.home';
xfa.logout = 'c.logout';
xfa.ajax_issues = 'c.ajax_issues';
//reactorFactory =  myFusebox.getApplication().getApplicationData().get( COLDSPRING_FACTORY_NAME ).getBean( 'ReactorFactory' );
</cfscript>
</cfsilent>

