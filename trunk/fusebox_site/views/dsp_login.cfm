<cfsilent>
</cfsilent>
<cfoutput>
<div class="lighterBox">
	<h1>Login</h1>
	<cfif event.valueExists( 'message' )>
			<br />
		<span class="error">#event.getValue( 'message' ).trim()#</span>
	</cfif>
	<br />
	<form id="loginForm" method="post" action="#myself##xfa.dologin#" class="data">
		<label for="Username">Username:</label>
		<input id="Username" name="Username" value="#event.getValue( 'username', '' )#"><br>
	
		<label for="password">Password:</label>
		<input type="password" id="password" name="password" value="#event.getValue( 'password', '' )#"><br>
		
		<label for="submit">&nbsp;</label>
		<input id="submit" type="submit" value="Login" name="submit" class="button" /> <br />
	</form>
</div>
</cfoutput>