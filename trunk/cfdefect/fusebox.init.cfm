<cfsilent>
<cfscript>
Controller = myFusebox.getApplication().getApplicationData().get( COLDSPRING_FACTORY_NAME ).getBean( 'Controller' );
Controller.OnRequestStart( event );
SecurityController = myFusebox.getApplication().getApplicationData().get( COLDSPRING_FACTORY_NAME ).getBean( 'SecurityController' );
SecurityController.OnRequestStart( event );
myself = myFusebox.getMyself();
event.setValue( 'myself', myFusebox.getMyself() );
//event.setValue( 'myFusebox', myFusebox );

//some global xfa
xfa.home = 'c.home';
xfa.logout = 'c.logout';
xfa.ajax_issues = 'c.ajax_issues';
</cfscript>
</cfsilent>

