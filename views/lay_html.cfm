<cfsilent>
<cfparam name="content.sidebar" default="" type="string">
</cfsilent>
<cfcontent reset="true" />
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>#event.getValue( 'ApplicationTitle' )#</title>
	<link rel="stylesheet" type="text/css" href="views/_styles/cfdefect.css" media="screen" />
	
	<script type="text/javascript" src="views/_js/prototype.js"></script>
	<script type="text/javascript" src="views/_js/behaviour.js"></script>
	<script type="text/javascript" src="views/_js/common.js"></script>
	<cfif myFusebox.originalfuseaction eq 'issues'>
		<script type="text/javascript" src="views/_js/ajaxhelper.js"></script>
		<script type="text/javascript" src="views/_js/issue.js"></script>
		<script>
		issue = new Issue("<cfoutput>#event.getValue( 'myself' )##xfa.ajax_issues#</cfoutput>");	
		</script>
		<script type="text/javascript">
			addLoadEvent( function(){
				issue.getIssues($("filterIssueForm"));
			});
		</script>
	</cfif>
</head>
<cfoutput>
<body>
	<!--- Header --->
	<div id="header">
    	<h1 class="headerTitle">
        	<a href="#event.getValue( 'myself' )##xfa.home#">#event.getValue( 'ApplicationTitle' )#</a>
      	</h1>
		<cfif event.getValue( 'isLoggedIn' )>
	      	<div class="headerLinks">
	        	<span class="doNotDisplay">Useful Links: </span>
	        	<a href="#event.getValue( 'myself' )##xfa.home#">Home</a> |
	        	<a href="#event.getValue( 'myself' )##xfa.preferences#">Preference</a> |
	        	<a href="#event.getValue( 'myself' )##xfa.logout#">Logout</a> 
	      	</div>
		</cfif>
    </div>
	
	<!--- Side Bar --->
	<div id="side-bar">
		#content.sidebar.trim()#
    </div>
	
	<!--- Main Content --->
	<div id="main-copy">
		#content.pageContent.trim()#	
    	<!--- <div class="darkerBox">
        	<h1>Introduction</h1>
        	<p>This is version two of <span lang="es">Tierra Verde</span>, a revision of the
           		<a href="http://www.oswd.org/userinfo.phtml?user=haran">original design</a> I submitted to
           		<a href="http://www.oswd.org"><acronym title="Open Source Web Design">OSWD</acronym></a>
           		in February 2003. Following is a summary of the major differences between this version and
           		the original.
			</p>
      	</div> --->
	</div>
	
	<!--- Footer --->
	<div id="footer">
      	<div class="right">
        	Designer: <a href="http://www.oswd.org/email.phtml?user=haran" title="Email designer">haran</a>
      	</div>
      	<br class="doNotDisplay doNotPrint" />
    </div>
    <div class="subFooter">
    	CFDefect version #event.getValue( 'ApplicationConfig' ).getVersion()# Copyright &copy; 2007, Qasim Rasheed<br class="doNotPrint" />
    </div>
</body>
</cfoutput>
</html>
</cfoutput>
