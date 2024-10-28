<!---Set variable for checking cookie for remember username.--->
<cfset this.userUsername = cookie.AUTHENTICATEUSERNAME EQ '' AND form.userUsername EQ '' ? '': form.userUsername>
<cfset this.userUsername = cookie.AUTHENTICATEUSERNAME NEQ '' ? cookie.AUTHENTICATEUSERNAME : ''>

<cfscript>
//Authenticate the user.
	if (isDefined("form.mcmsAuthenticate")) {

	args = structNew();
	args.userUsername = form.userUsername;
	args.userPassword = form.userPassword;
	args.userRemember = form.userRemember;
	args.authenticationType = application.authenticationType;

	result =  invoke('MCMS.component.cms.Authenticate', 'setAuthentication', {args=args});
	
	}

</cfscript>

<cfif result.message NEQ "">
<div id="mcmsMessage">
<cfoutput>#result.message#</cfoutput>
</div>
</cfif>

<div class="container-fluid mcmsAuthenticateContainer">
<div class="row no-gutter top-buffer">
<form method="post" name="authenticateForm" id="authenticateForm">
<div class="form-group row">
<h1>Sign In</h1>
<div class="col-xs-12">
<cfif url.mcmsDenied NEQ ""> 
<input type="hidden" name="mcmsRedirect" value="<cfoutput>?#URLEncodedFormat(url.mcmsDenied)#</cfoutput>">
</cfif>
</div>
</div>

<div class="form-group row">

<div class="float-label-control">	
<label for="">Username</label>
<input type="text" name="userUsername" id="userUsername" class="form-control input-sm" value="<cfoutput>#Iif(IsDefined('form.userUsername'), Evaluate(DE('form.userUsername')), DE(cookie.AUTHENTICATEUSERNAME))#</cfoutput>" placeholder="Username" tabindex="1" data-error="##userUsernameError"/>
</div>
<span id="userEmailError"></span>

</div>

<div class="form-group row">

<div class="float-label-control">
<label for="">Password</label>
<input type="password" name="userPassword" id="userPassword" class="form-control input-sm" data-error="##userPasswordError" placeholder="Password" pattern="<cfoutput>#application.passwordcomplexityregex#</cfoutput>" tabindex="2"/>
</div>
<span id="userPasswordError"></span>

<span href="#" data-toggle="tooltip" data-placement="top" title="<cfoutput>#application.passwordMessageRequirement#</cfoutput>" class="label label-warning">Password Rules</span>

</div>

<div class="form-group">
<label class="custom-control custom-checkbox">
<input type="checkbox" class="custom-control-input" name="userRemember" id="userRemember" tabindex="3" value="1" <cfoutput>#Iif(cookie.AUTHENTICATEUSERNAME NEQ 'NULL', DE('checked'), DE(''))#</cfoutput> />
<span class="custom-control-indicator"></span>
Remember me
</label>
</div>

<div class="form-group row">

<button name="mcmsSignIn" id="mcmsSignIn" type="submit" class="btn btn-primary">Sign In</button>
<input type="hidden" name="mcmsAuthenticate" id="mcmsAuthenticate">
<cfif StructKeyExists(URL,'mcmsDestination')>
<input type="hidden" name="mcmsDestination" id="mcmsDestination" value="?<cfoutput>#URLEncodedFormat(url.mcmsDestination)#</cfoutput>">
</cfif>

</div>
</form>
</div>
</div>

<!---Set form focus.--->
<cfif cookie.AUTHENTICATEUSERNAME NEQ 'NULL'>
<script>
document.authenticateForm.userPassword.focus();
document.authenticateForm.userRemember.checked = true;
</script>
<cfelseif cookie.AUTHENTICATEUSERNAME EQ '' AND form.userUsername EQ 'NULL'>
<script>
document.authenticateForm.userUsername.focus();
document.authenticateForm.userRemember.checked = false;
</script>
</cfif>