<cfoutput>
<div class="mcmsHeader">
	
	<div class="page-header" id="page-header-bg">

		<div class="row">

			<div class="col-sm-12">
				
				<a href="#application.mcmsHomePath#" id="mcmsHeaderLogo"/></a>

						<span id="mcmsHeaderContent">

						<span id="mcmsHeaderIP">IP: #request.remoteIP#</span>
						<span id="mcmsHeaderHelp"><a href="##" target="_blank" class="mcmsmcmsHeaderLink">Help?</a><br /></span>
						
						
						<cfif session.urID NEQ ''>
						<cfif session.signedIn EQ false>

							<a href="/">Sign In</a>

						<cfelse>

						<span id="mcmsHeaderUsername">
							Welcome #session.userName# (<a href="?mcmsSignOut=true" class="mcmsmcmsHeaderLink">Not #session.userName#?</a>)
						</span>
						
							<a href="?mcmsSignOut=true" class="mcmsmcmsHeaderLink"><span class="glyphicon glyphicon-lock"></span>Sign Out</a>

						</cfif>
						</cfif>

						</span>

			</div>

			</div>

	</div>

</div>
</cfoutput>