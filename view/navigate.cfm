<div class="mcmsNavigationContainer">

<nav class="navbar navbar-default" role="navigation">

	<div class="container">

		<div class="navbar-header">

			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>

		</div>

	<div class="navbar-collapse collapse">

		<ul class="nav navbar-nav">

		<cfoutput>
			<li><a href="#application.mcmsHomePath#">Main Menu</a></li>
		</cfoutput>

		<cfif nav.recordcount NEQ 0>
			<cfoutput query="nav" group="navID">

			<li class="dropdown">
				<a href="#nav.navPath#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
				#nav.navName# 
				<span class="caret"></span>
				</a>

				<ul class="dropdown-menu">
					<cfoutput>
					<li><a href="#Replace(CGI.SCRIPT_NAME, 'index.cfm', '', 'ALL')##nav.navPath#/#nav.appPath#" target="#nav.anrTarget#">#nav.appName#</a></li>
					</cfoutput>
				</ul>

			</li>

			</cfoutput>

		</cfif>
<!---
		<cfif link.recordcount NEQ 0>
			<li class="dropdown">
				<a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
				Links
				<span class="caret"></span>
				</a>
			
			<ul class="dropdown-menu">
				<cfoutput query="link">
				<li><a href="#link.lURL#" target="#link.lTarget#">#link.lName#</a></li>
				</cfoutput>
			</ul>
			
			</li>
			</cfif>
--->
		</div>

	</div>

</nav>

</div>
