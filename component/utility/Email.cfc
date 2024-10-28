<cfcomponent>

	<cffunction name="getEmailResponseCode" access="public" returntype="query" hint="Get Temp data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="excludeID" type="numeric" required="yes" default="0">
		<cfargument name="ercCode" type="string" required="yes" default="">
		<cfargument name="ercStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ercCode">
		
		<cfset var rsEmailResponseCode = "" >
		
		<cftry>
			
			<cfquery name="rsEmailResponseCode" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_email_response_code WHERE 0=0
				
				<cfif ARGUMENTS.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif ARGUMENTS.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif ARGUMENTS.keywords NEQ 'All'>
					
					AND (UPPER(ercCode) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
					OR UPPER(ercDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
					
				</cfif>
				
				<cfif ARGUMENTS.ercCode NEQ "">
					
					AND UPPER(ercCode) = <cfqueryparam value="#UCASE(ARGUMENTS.ercCode)#" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				AND ercStatus IN (<cfqueryparam value="#ARGUMENTS.ercStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #ARGUMENTS.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsEmailResponseCode = StructNew()>
				<cfset rsEmailResponseCode.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsEmailResponseCode>
		
	</cffunction>
	
	<cffunction name="setEmailHeader" access="public" returntype="string" description="Contents of the email header.">
		
		<cfargument name="type" type="string" required="yes" default="admin">
		<cfargument name="emailType" type="string" required="yes" default="html">
		
		<cfsavecontent variable="setEmailHeader">
			
			<cfoutput>
				
			<cfif ARGUMENTS.emailType EQ "html">
				
				<a href="http://#CGI.SERVER_NAME#">
				<img src="http://#CGI.SERVER_NAME#/MCMS/assets/logo/logo.png" alt="#application.companyName#" name="company_logo" vspace="5" border="0" id="company_logo">
				</a>
			
			<cfelse>
			
				#application.companyName# Email Response
			
			</cfif>
			
			<hr>
				
			</cfoutput>
		
		</cfsavecontent>
		
		<cfreturn setEmailHeader>
		
	</cffunction>
	
	<cffunction name="setEmailFooter" access="public" returntype="string" description="Contents of the email footer.">
		
		<cfargument name="type" type="string" required="yes" default="admin">
		<cfargument name="emailType" type="string" required="yes" default="html">
		
		<cfsavecontent variable="emailFooter">
			
			<cfoutput>
				
			<cfif ARGUMENTS.emailType EQ "html">
			
			<cfelse>
			
			</cfif>
			
			<hr>
			&copy; #DateFormat(Now(), 'yyyy')# #application.companyName#
			
			</cfoutput>
		
		</cfsavecontent>
		
		<cfreturn emailFooter>
		
	</cffunction>
	
	<cffunction name="sendEmail" access="public" returntype="struct" output="yes">
		
		<cfargument name="subject" type="string" required="yes" default="#application.companyName# Email">
		<cfargument name="to" type="string" required="yes" default="#TRIM(application.companyEmail)#">
		<cfargument name="from" type="string" required="yes" default="#TRIM(application.companyEmail)#">
		<cfargument name="cc" type="string" required="yes" default="">
		<cfargument name="bcc" type="string" required="yes" default="">
		<cfargument name="body" type="string" required="yes" default="">
		<cfargument name="ID" type="string" required="yes" default="0">
		<cfargument name="emailTemplate" type="string" required="yes" default="">
		<cfargument name="emailType" type="string" required="yes" default="html">
		<cfargument name="type" type="string" required="yes" default="admin">
		
		<cfset result.message = "You have successfully sent your email.">
		
		<!---Get email header.--->
		<cfinvoke 
			component="MCMS.component.utility.Email"
			method="setEmailHeader"
			returnvariable="setEmailHeaderRet">
				<cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
				<cfinvokeargument name="type" value="#ARGUMENTS.type#"/>
		</cfinvoke>
		
		<cfinvoke 
			component="MCMS.component.utility.Email"
			method="setEmailFooter"
			returnvariable="setEmailFooterRet">
				<cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
				<cfinvokeargument name="type" value="#ARGUMENTS.type#"/>
		</cfinvoke>
		
		<cftry>
			
			<cfmail 
				to="#TRIM(ARGUMENTS.to)#"
				from="#TRIM(ARGUMENTS.from)#"
				cc="#ARGUMENTS.cc#"
				bcc="#ARGUMENTS.bcc#"
				subject="#ARGUMENTS.subject#"
				timeout="5"
				type="#ARGUMENTS.emailType#">
			
				<!---Contsruct the email content.--->
				<html>
					
					<head>
					
						<link href="http://#CGI.SERVER_NAME#/MCMS/css/bootstrap.css" rel="stylesheet" type="text/css">
						<link href="http://#CGI.SERVER_NAME#/MCMS/css/main.css" rel="stylesheet" type="text/css">
							
						<style type="text/css">
									
							@font-face {
								
								font-family: 'Open Sans';
								src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Regular.woff');
							
							}
							
							@font-face {
								
								font-family: 'Open Sans Semi Bold';
								src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Semibold.woff');
							
							}
							
							@font-face {
								
								font-family: 'Open Sans Semi Bold Italic';
								src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-SemiboldItalic.woff');
							
							}
							
							@font-face {
								
								font-family: 'Open Sans Bold';
								src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Bold.woff');
							
							}
							
							@font-face {
								
								font-family: 'Open Sans Bold Italic';
								src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-BoldItalic.woff');
								
							}
							
							@font-face {
								
								font-family: 'Open Sans';
								src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Regular.woff');
							
							}
							
							body {
							
								font-family: Open Sans, Arial, Helvetica, sans-serif;
								font-size: 14px;
							
							}
							
							table {
								
								font-family: Open Sans, Arial, Helvetica, sans-serif;
								width:100%;
								border:none;
								border-collapse: collapse;
								border-spacing: 5px;
								margin-left:auto; 
	    						margin-right:auto;							
								
							}
							
							th, td {
								
								padding:5px;
								
							}
							
							h1, h2, h3, h4, h5 {
								
								font-family: Open Sans, Arial, Helvetica, sans-serif;
		
							}
	
							h1 {
								
								font-size: 24px;
							
							}
							
							h2 {
								
								font-size: 21px;
								
							}
							
							h3 {
								
								font-size: 18px;
							
							}
							
							h4 {
								
								font-size: 16px;
							
							}
							
							h5 {
								
								font-size: 14px;
							
							}
	
						</style>
						
					</head>
					
					<body>
						
						<table>
							
							<tr>
								
								<td>#setEmailHeaderRet#</td>
								
							</tr>
							
							<cfif ARGUMENTS.body NEQ ''>
								
								<tr>
									
								<td>#ARGUMENTS.body#</td>
								
								</tr>
							
							</cfif>
							
							<cfif ARGUMENTS.emailTemplate NEQ "">
								
								<tr>
									
								<td><cfinclude template="#ARGUMENTS.emailTemplate#"></td>
								
								</tr>
							
							</cfif>
							
							<tr>
								
								<td>#setEmailFooterRet#</td>
							
							</tr>
							
						</table>
					
					</body>
					
				</html>
				
			</cfmail>

			<cfcatch type="any">
				
				<cfset result.message = "You have not successfully sent your email. We have been notified of the issue.">
				
				<cflog file="emailFailure" text="#CFCATCH#"/>
				
				<cfinvoke 
					component="MCMS.component.utility.Email"
					method="emailFailure"
					returnvariable="emailFailureRet">
						<cfinvokeargument name="subject" value="#ARGUMENTS.subject#"/>
						<cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
						<cfinvokeargument name="type" value="#ARGUMENTS.type#"/>
				</cfinvoke>
			
			</cfcatch>
			
		</cftry>

		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="setEmailForm" access="public" returntype="any" description="Form to use for email.">
		
		<cfargument name="subject" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the subject value equals 'true' then the user must enter a subject.">
		
		<cfargument name="toEmail" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the toEmail value equals 'true' then the user must enter a toEmail.">
		
		<cfargument name="fromEmail" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the fromEmail value equals 'true' then the user must enter a fromEmail.">
		
		<cfargument name="ccEmail" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the ccEmail value equals 'true' then the user must enter a ccEmail.">
		
		<cfargument name="bccEmail" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the fromEmail value equals 'true' then the user must enter a fromEmail.">
		
		<cfargument name="name" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the name value equals 'true' then the user must enter a name.">
		
		<cfargument name="telephone" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the telephone value equals 'true' then the user must enter a telephone.">
		
		<cfargument name="siteNo" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the siteNo value equals 'true' then the user must select a Site No.">
		
		<cfargument name="deptNo" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the deptNo value equals 'true' then the user must select a Dept No.">
		
		<cfargument name="URL" 
			type="string" default="" 
			required="yes" 
			hint="If the URL value equals 'true' then the application must pass the url.">
		
		<cfargument name="captcha" 
			type="string" 
			default="false" 
			required="yes" 
			hint="If the captcha value equals 'true' then the user must enter a captcha code.">
		
		<cfargument name="emailTemplate" 
			type="string" 
			default="/#application.mcmsAppPublicPath#/email_form/view/inc_email_form_template.cfm" 
			required="yes" 
			hint="The emailTemplate value can be a unique include for use by this method.">
		
		<cftry>
			
			<!---Set default FORM parameters.--->
			<cfparam name="form.mcmsSend" default="false">
			<cfparam name="form.ccEmail" default="">
			<cfparam name="form.bccEmail" default="">
			<cfparam name="form.telArea" default="">
			<cfparam name="form.telPrefix" default="">
			<cfparam name="form.telSuffix" default="">
			<cfparam name="form.name" default="">
			<cfparam name="form.telephone" default="(#form.telArea#)#form.telPrefix#-#form.telSuffix#">
			<cfparam name="form.siteNo" default="100">
			<cfparam name="form.deptNo" default="0">
			<cfparam name="form.comment" default="">
			<cfparam name="form.URL" default="#ARGUMENTS.URL#">
			<cfparam name="form.captcha" default="">
			<cfparam name="form.emailTemplate" default="#ARGUMENTS.emailTemplate#">
			
			<cfsavecontent variable="result">
				
				<cfif ARGUMENTS.siteNo NEQ false>
					
					<cfinvoke 
						component="MCMS.component.app.site.Site"
						method="getSite"
						returnvariable="getSiteRet">
							<cfinvokeargument name="stID" value="1,2,3"/>
							<cfinvokeargument name="siteStatus" value="1,3"/>
							<cfinvokeargument name="orderBy" value="siteName"/>
					</cfinvoke>
				
				</cfif>
				
				<cfif ARGUMENTS.deptNo NEQ false>
					
					<cfinvoke 
						component="MCMS.component.app.department.Department"
						method="getDepartment"
						returnvariable="getDepartmentRet">
							<cfinvokeargument name="deptStatus" value="1,3"/>
							<cfinvokeargument name="orderBy" value="deptName"/>
					</cfinvoke>
				
				</cfif>
				
				<cfif form.mcmsSend NEQ false>
					
					<cfinvoke 
						component="MCMS.component.utility.Email"
						method="sendEmail"
						returnvariable="result">
							<cfinvokeargument name="subject" value="#form.subject#"/>
							<cfinvokeargument name="to" value="#form.toEmail#"/>
							<cfinvokeargument name="from" value="#form.fromEmail#"/>
							<cfinvokeargument name="cc" value="#form.ccEmail#"/>
							<cfinvokeargument name="bcc" value="#form.bccEmail#"/>
							<cfinvokeargument name="URL" value="#form.URL#"/>
							<cfinvokeargument name="emailTemplate" value="#form.emailTemplate#"/>
					</cfinvoke>
					
					<!---Create log of emails.--->
					<cflog text="#form.subject# - From: #form.fromEmail# - To: #form.toEmail# - #form.comment#" 
						log="application" 
						type="information" 
						file="emailForm"/>
				
				</cfif>
				
				<h1>Email Form</h1>
				
				<div>Complete the form below to send an email.</div>
				
				<div id="valMessage"></div>
				
				<cfif IsDefined("result.message")>
						
					<div id="mcmsMessage">
						
						<cfoutput>#result.message#</cfoutput>
					
					</div>
					
				</cfif>
				
				<cfform name="emailForm" method="post" action="">
					
					<table id="mainTableAlt">
						
					<tr>
						
						<td class="bold">Subject:</td>
					
						<td>
						<cfif ARGUMENTS.subject EQ false>
							
							<cfinput type="text" name="subject" id="subject" size="32" maxlength="128" required="yes" message="Please include a Subject."><span id="required">*</span>
						
						<cfelse>
						
							<cfoutput><i>#ARGUMENTS.subject#</i></cfoutput>
							<cfinput type="hidden" name="subject" value="#ARGUMENTS.subject#">
						
						</cfif>
						</td>
					
					</tr>
					
					<tr>
						
						<td class="bold">To:</td>
						<td>
							<cfif ARGUMENTS.toEmail EQ false>
								
								<cfinput type="text" name="toEmail" id="toEmail" size="32" maxlength="64" required="yes" message="Please include an 'To' Email in the correct format." validate="email"><span id="required">*</span><br>
								<span class="small">i.e.: user@domain.com</span>
							
							<cfelse>
							
								<cfoutput>#ARGUMENTS.toEmail#</cfoutput>
								<cfinput type="hidden" name="toEmail" value="#ARGUMENTS.toEmail#">
							
							</cfif>
						</td>
					
					</tr>
					
					<tr>
						
						<td class="bold">From:</td>
						<td>
						<cfif ARGUMENTS.fromEmail EQ false>
							
							<cfinput type="text" name="fromEmail" id="fromEmail" size="32" maxlength="64" required="yes" message="Please include an 'From' Email in the correct format." validate="email"><span id="required">*</span><br>
							<span class="small">i.e.: user@domain.com</span>
						
						<cfelse>
						
							<cfoutput>#ARGUMENTS.fromEmail#</cfoutput>
							<cfinput type="hidden" name="fromEmail" value="#ARGUMENTS.fromEmail#">
						
						</cfif>
						</td>
					
					</tr>
					
					<cfif ARGUMENTS.name EQ true>
						
						<tr>
							
							<td class="bold">Name:</td>
							<td><cfinput type="text" name="name" id="name" size="32" maxlength="64" required="yes" message="Please include a Name."><span id="required">*</span>
							</td>
							
						</tr>
							
					</cfif>
										
					<cfif ARGUMENTS.ccEmail NEQ false>
						
						<tr>
							
							<td class="bold">CC:</td>
							<td>
							<cfif ARGUMENTS.ccEmail EQ false>
								
								<cfinput type="text" name="ccEmail" id="ccEmail" size="32" maxlength="64" required="no" message="Please include an 'CC' Email in the correct format." validate="email"><br>
								<span class="small">i.e.: user@domain.com</span>
							
							<cfelse>
							
								<cfoutput>#ARGUMENTS.ccEmail#</cfoutput>
								<cfinput type="hidden" name="ccEmail" value="#ARGUMENTS.ccEmail#">
							
							</cfif>
							</td>
							
						</tr>
					
					</cfif>
					
					<cfif ARGUMENTS.bccEmail NEQ false>
						
						<tr>
							
							<td class="bold">BCC:</td>
							<td>
								<cfif ARGUMENTS.bccEmail EQ false>
									
									<cfinput type="text" name="bccEmail" id="bccEmail" size="32" maxlength="64" required="no" message="Please include an 'BCC' Email in the correct format." validate="email"><br>
									<span class="small">i.e.: user@domain.com</span>
								
								<cfelse>
								
									<cfoutput>#ARGUMENTS.bccEmail#</cfoutput>
									<cfinput type="hidden" name="bccEmail" value="#ARGUMENTS.bccEmail#">
								
								</cfif>
							</td>
						
						</tr>
					
					</cfif>
					
					<cfif ARGUMENTS.telephone EQ true>
						
						<tr>
							
							<td class="bold">Telephone:</td>
							<td>
								<cfinput type="text" name="telArea" id="telArea" maxlength="3" size="2" required="yes" message="Please include a Telephone Area Code." validate="integer"/>- <cfinput type="text" name="telPrefix" id="telPrefix" maxlength="3" size="2" required="yes" message="Please include a Telephone Prefix." validate="integer"/>- <cfinput type="text" name="telSuffix" id="telSuffix" maxlength="4" size="3" required="yes" message="Please include a Telephone Suffix." validate="integer"/><span id="required">*</span>
							</td>
						
						</tr>
					
					</cfif>
					
					<cfif ARGUMENTS.siteNo EQ true>
						
						<tr>
							
							<td class="bold">Site:</td>
							<td>
								<cfselect name="siteNo" id="siteNo" required="yes" message="Please select a Site.">
									<option value="">Select a Site...</option>
									<cfoutput query="getSiteRet">
									<option value="#getSiteRet.siteNo#" <cfif form.siteNo EQ getSiteRet.siteNo>selected</cfif>>#getSiteRet.siteName# (#getSiteRet.siteNo#)</option>
									</cfoutput>
								</cfselect>
								<span id="required">*</span>
							</td>
							
						</tr>
					
					</cfif>
					
					<cfif ARGUMENTS.deptNo EQ true>
						
						<tr>
							
							<td class="bold">Dept.:</td>
							<td>
								<cfselect name="deptNo" id="deptNo" required="yes" message="Please select a Department.">
									<option value="">Select a Dept...</option>
									<cfoutput query="getDepartmentRet">
									<option value="#getDepartmentRet.deptNo#" <cfif form.deptNo EQ getDepartmentRet.deptNo>selected</cfif>>#getDepartmentRet.deptName# (#getDepartmentRet.deptNo#)</option>
									</cfoutput>
								</cfselect>
							
								<span id="required">*</span>
							</td>
						
						</tr>
					
					</cfif>
					
					<tr>
						
					<td class="bold">Comments:</td>
					
						<td>
							<cftextarea name="comment" id="comment" rows="5" cols="100"></cftextarea>
						</td>
					
					</tr>
					
					<cfif ARGUMENTS.captcha EQ true>
						
						<tr>
							
							<td>&nbsp;</td>
							<td>
								<cfsilent>
									
								<cfinvoke 
									component="MCMS.component.utility.Captcha"
									method="makeRandomString"
									returnvariable="makeRandomStringRet">
								</cfinvoke>
								
								</cfsilent>
								
								<cfimage action="captcha" width="200" height="50" text="#makeRandomStringRet#" fonts="arial" fontsize="24" difficulty="medium">
								<cfinput type="hidden" name="captcha" value="#makeRandomStringRet#">
							</td>
						
						</tr>
					
						<tr>
							
							<td class="bold">Security:</td>
							<td>
								<cfinput name="capCode" type="text" class="input" id="capCode" size="5" maxlength="5" autocomplete="false" required="yes" message="Please enter the Security Code matching the image displayed." onkeyup="upperCase(this.id)">
								<span id="required">*</span><br>Please enter the required code from the image shown above.<br>This helps to prevent fraudulent requests. <br><i>Simply refresh this page if you are having difficulty reading the image for a new image to display.</i>
							</td>
						
						</tr>
						
					</cfif>
					
					<tr>
						
						<td>&nbsp;</td>
						<td><cfinput type="submit" name="mcmsSend" value="Send Email" id="mcmsSend"></td>
					
					</tr>
					
					</table>
					
				</cfform>
				
				<!---Set focus to the appropriate field.--->
				<cfif ARGUMENTS.subject EQ false>
					
					<script>document.emailForm.subject.focus();</script>
				
				<cfelseif ARGUMENTS.toEmail EQ false>
				
					<script>document.emailForm.toEmail.focus();</script>
				
				<cfelseif ARGUMENTS.fromEmail EQ false>
				
					<script>document.emailForm.fromEmail.focus();</script>
				
				<cfelseif ARGUMENTS.name EQ true>
				
					<script>document.emailForm.name.focus();</script>
				
				<cfelse>
				
					<script>document.emailForm.comment.focus();</script>
				
				</cfif>
			
			</cfsavecontent>
			
			<cfcatch type="any">
				
				<cfset result = "There was an error with the Email Form.">
				
			</cfcatch>
			
		</cftry>
		
		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="emailFailure" access="public" returntype="void" description="When an email function fails send a message detailing what has happened.">
		
		<cfargument name="subject" type="string" default="#application.companyName#" required="yes">
		<cfargument name="emailType" type="string" required="yes" default="html">
		<cfargument name="type" type="string" required="yes" default="admin">
		
		<!--- Get email header. --->
		<cfinvoke 
			component="MCMS.component.utility.Email"
			method="setEmailHeader"
			returnvariable="setEmailHeaderRet">
				<cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
				<cfinvokeargument name="type" value="#ARGUMENTS.type#"/>
		</cfinvoke>
		
		<cfinvoke 
			component="MCMS.component.utility.Email"
			method="setEmailFooter"
			returnvariable="setEmailFooterRet">
				<cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
				<cfinvokeargument name="type" value="#ARGUMENTS.type#"/>
		</cfinvoke>
		
		<cfmail from="#application.webmasterEmail#" to="#application.webmasterEmail#" subject="#application.companyName# Email Method Failure" type="#ARGUMENTS.emailType#">
				
			<!---Contsruct the email content.--->
			<html>
				
				<head>
					
					<link href="http://#CGI.SERVER_NAME#/MCMS/css/bootstrap.css" rel="stylesheet" type="text/css">
					<link href="http://#CGI.SERVER_NAME#/MCMS/css/main.css" rel="stylesheet" type="text/css">
								
					<style type="text/css">
								
						@font-face {
							
							font-family: 'Open Sans';
							src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Regular.woff');
						
						}
						
						@font-face {
							
							font-family: 'Open Sans Semi Bold';
							src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Semibold.woff');
						
						}
						
						@font-face {
							
							font-family: 'Open Sans Semi Bold Italic';
							src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-SemiboldItalic.woff');
						
						}
						
						@font-face {
							
							font-family: 'Open Sans Bold';
							src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Bold.woff');
						
						}
						
						@font-face {
							
							font-family: 'Open Sans Bold Italic';
							src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-BoldItalic.woff');
							
						}
						
						@font-face {
							
							font-family: 'Open Sans';
							src: url('http://#CGI.SERVER_NAME#/MCMS/css/font/open_sans/OpenSans-Regular.woff');
						
						}
						
						body {
						
							font-family: Open Sans, Arial, Helvetica, sans-serif;
							font-size: 14px;
						
						}
						
						table {
							
							font-family: Open Sans, Arial, Helvetica, sans-serif;
							width:100%;
							border:none;
							border-collapse: collapse;
							border-spacing: 5px;
							margin-left:auto; 
							margin-right:auto;							
							
						}
						
						th, td {
							
							padding:5px;
							
						}
						
						h1, h2, h3, h4, h5 {
							
							font-family: Open Sans, Arial, Helvetica, sans-serif;
	
						}
	
						h1 {
							
							font-size: 24px;
						
						}
						
						h2 {
							
							font-size: 21px;
							
						}
						
						h3 {
							
							font-size: 18px;
						
						}
						
						h4 {
							
							font-size: 16px;
						
						}
						
						h5 {
							
							font-size: 14px;
						
						}
	
					</style>
				
				</head>
				
				<body>
					
					<table>
						
						<tr>
							
							<td>#setEmailHeaderRet#</td>
						
						</tr>
						
						<tr>
							
							<td>
								***THIS REQUIRES IMMEDIATE ATTENTION***
								<br/><br/>
								An error has occured during the response email process of <strong>#ARGUMENTS.subject#</strong>.
								This error was most likely caused by a error in the email content template or the parent function.
								<br/><br/>
								Email responses are failing if you are receiving this message.
							</td>
						
						</tr>
						
						<tr>
							
							<td>#setEmailFooterRet#</td>
						
						</tr>
					
					</table>
					
				</body>
				
			</html>
			
		</cfmail>
		
	</cffunction>
	 
</cfcomponent>