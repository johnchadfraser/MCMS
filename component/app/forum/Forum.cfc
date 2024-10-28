<cfcomponent output="false">
    <cffunction name="getForum" hint="Gets Forum records" access="public" returnType="query" output="false">
    <cfargument name="keywords" type="string" required="yes" default="All"/> 
    <cfargument name="ID" type="numeric" required="yes" default="0"/>
    <cfargument name="fStatus" type="string" required="yes" default="0"/>
    <cfargument name="orderBy" type="string" required="yes" default="fSort, fName"/>
    <cfset var rsForum = "" >
    <cfquery name="rsForum" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.tbl_forum WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ "All">
    AND (fName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR fDescription LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND fStatus IN (<cfqueryparam value="#ARGUMENTS.fStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsForum>
    </cffunction>
    
    <cffunction name="getTopic" hint="Gets Topic records" access="public" returnType="query" output="false">
    <cfargument name="keywords" type="string" required="yes" default="All"/> 
    <cfargument name="ID" type="numeric" required="yes" default="0"/>
    <cfargument name="fID" type="numeric" required="yes" default="0"/>
    <cfargument name="ftopDate" type="string" required="yes" default=""/>
    <cfargument name="fStatus" type="numeric" required="yes" default="0"/>
    <cfargument name="ftopStatus" type="string" required="yes" default="0"/>
    <cfargument name="orderBy" type="string" required="yes" default="ftopName"/>
    <cfset var rsTopic = "" >
    <cfquery name="rsTopic" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.v_forum_topic WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ "All">
    AND (ftopName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR ftopDescription LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftopDate NEQ "">
    AND ftopDate >= <cfqueryparam value="#DateFormat(ARGUMENTS.ftopDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.fStatus NEQ 0>
    AND fStatus = <cfqueryparam value="#ARGUMENTS.fStatus#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ftopStatus IN (<cfqueryparam value="#ARGUMENTS.ftopStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsTopic>
    </cffunction>
    
    <cffunction name="getMessage" hint="Gets Message records" access="public" returnType="query" output="false">
    <cfargument name="keywords" type="string" required="yes" default="All"/> 
    <cfargument name="ID" type="numeric" required="yes" default="0"/>
    <cfargument name="fID" type="numeric" required="yes" default="0"/>
    <cfargument name="ftopID" type="numeric" required="yes" default="0"/>
    <cfargument name="fmStatus" type="string" required="yes" default="0"/>
    <cfargument name="orderBy" type="string" required="yes" default="ftopName"/>
    <cfset var rsMessage = "" >
    <cfquery name="rsMessage" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.v_forum_message WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ "All">
    AND (fmName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR fmDescription LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftopID NEQ 0>
    AND ftopID = <cfqueryparam value="#ARGUMENTS.ftopID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND fmStatus IN (<cfqueryparam value="#ARGUMENTS.fmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsMessage>
    </cffunction>
    
    <cffunction name="getTopicSubscription" hint="Gets Topic Subscription records" access="public" returnType="query" output="false">
    <cfargument name="ID" type="numeric" required="yes" default="0"/>
    <cfargument name="fID" type="numeric" required="yes" default="0"/>
    <cfargument name="ftopID" type="numeric" required="yes" default="0"/>
    <cfargument name="fuID" type="numeric" required="yes" default="0"/>
    <cfargument name="fsDate" type="string" required="yes" default=""/>
    <cfargument name="fsStatus" type="numeric" required="yes" default="0"/>
    <cfargument name="orderBy" type="string" required="yes" default="fsDate"/>
    <cfset var rsTopicSubscription = "" >
    <cfquery name="rsTopicSubscription" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.v_forum_topic_subscribe WHERE 0=0
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftopID NEQ 0>
    AND ftopID = <cfqueryparam value="#ARGUMENTS.ftopID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fuID NEQ 0>
    AND fuID = <cfqueryparam value="#ARGUMENTS.fuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fsDate NEQ "">
    AND fsDate >= <cfqueryparam value="#DateFormat(ARGUMENTS.fsDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date">
    </cfif>
    AND fsStatus IN (<cfqueryparam value="#ARGUMENTS.fsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsTopicSubscription>
    </cffunction>
    
    <cffunction name="getUser" hint="Gets User detail records" access="public" returnType="query" output="false">
    <cfargument name="keywords" type="string" required="yes" default="All"/> 
    <cfargument name="ID" type="numeric" required="yes" default="0"/>
    <cfargument name="uUsername" type="string" required="yes" default=""/>
    <cfargument name="uEmail" type="string" required="yes" default=""/>
    <cfargument name="uStatus" type="string" required="yes" default="0"/>
    <cfargument name="orderBy" type="string" required="yes" default="uLName"/>
    <cfset var rsUser = "" >
    <cfquery name="rsUser" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.tbl_forum_user WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ "All">
    AND (uFName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR uFLName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.uUsername NEQ "">
    AND uUsername = <cfqueryparam value="#ARGUMENTS.uUsername#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.uEmail NEQ "">
    AND uEmail = <cfqueryparam value="#ARGUMENTS.uEmail#" cfsqltype="cf_sql_varchar">
    </cfif>
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND uStatus IN (<cfqueryparam value="#ARGUMENTS.uStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsUser>
    </cffunction>
    
    <cffunction name="getAvatar" hint="Gets Avatar records" access="public" returnType="query" output="false">
    <cfargument name="keywords" type="string" required="yes" default="All"/> 
    <cfargument name="ID" type="numeric" required="yes" default="0"/>
    <cfargument name="aStatus" type="string" required="yes" default="0"/>
    <cfargument name="orderBy" type="string" required="yes" default="aName"/>
    <cfset var rsAvatar = "" >
    <cfquery name="rsAvatar" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.tbl_forum_avatar WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ "All">
    AND aName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND aStatus IN (<cfqueryparam value="#ARGUMENTS.aStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsAvatar>
    </cffunction>
    
    <cffunction name="getLogIn" hint="Login a user." access="public" returnType="struct" output="true">
    <cfargument name="uUsername" type="string" required="yes"/>
    <cfargument name="uPassword" type="string" required="yes"/>
    <cfargument name="rememberUser" type="string" required="yes" default="false"/>
    <cfargument name="redirect" type="string" required="yes" default=""/>
    <cfset result.message = "The username and password you have entered does not match our records. Please try again.">
    <cfquery name="rsLogIn" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.tbl_forum_user WHERE 0=0
	AND uUsername = <cfqueryparam value="#ARGUMENTS.uUsername#" cfsqltype="cf_sql_varchar">
    AND uPassword = <cfqueryparam value="#ARGUMENTS.uPassword#" cfsqltype="cf_sql_varchar">
    AND uStatus = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint">
    </cfquery>
    <cfif rsLogIn.recordcount NEQ 0>
    <cftry>
    <cflock timeout="5" throwontimeout="no" type="exclusive">
    <!--- Set the user session vars --->
    <cfset session.logIn = true>
    <cfset session.uID=rsLogIn.ID>
    <cfset session.uUsername=rsLogIn.uUsername>
    <cfset session.uName=rsLogIn.uFName & ' ' & rsLogIn.uLName>
    <cfset session.uEmail=rsLogIn.uEmail>
    <!---Force the user to reset their password.--->
    <cfif rsLogIn.uPassword EQ rsLogIn.uTempPassword>
    <cfset session.resetPassword = true>
    </cfif>
    </cflock>
    <!--- Store username inside a cookie if required --->
    <cfif ARGUMENTS.rememberUser EQ true>
    <cfcookie name="forumUser" value="#session.uUsername#" expires="never">
    <!--- Else, clean any existing cookie --->
    <cfelse>
    <cfcookie name="forumUser" value="" expires="now">
    </cfif>
    <!--- If the user requested a specific page, redirect there --->
    <cfif ARGUMENTS.redirect NEQ "">
    <cflocation addtoken="no" url="#URLDecode(ARGUMENTS.redirect)#">
    </cfif>
    <cfset result.message = "Welcome #session.uName#, you have successfully Logged In.">
    <cfcatch type="any">
    <cfset result.message = "An error occured.">
    </cfcatch>
    </cftry>
    </cfif>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="generatePassword" hint="Generates a random password from a list of distinct characters." returntype="string" access="public" output="false">
    <cfargument name="length" type="numeric" required="yes" hint="The length of the password to be returned." default="6" />
    <!--- Set Local Scope --->
    <cfset var local = StructNew()> 
    <cfset local.CharSet = "QWERTYUPASDFGHJKLZXCVBNM23456789">
    <cfset local.CurChar = "">
    <cfset local.password = "">
    <cfloop from="1" to="#ARGUMENTS.length#" index="local.Cnt">
    <cfset local.CurChar = MID(local.CharSet, RandRange(1, LEN(local.CharSet)), 1)>
    <cfset local.password = local.password & local.CurChar>
    </cfloop>
    <!--- Return the password --->
    <cfreturn local.password>
    </cffunction>
    
    <cffunction name="getForgotLogIn" hint="Get username and password and send to user." access="public" returnType="struct" output="false">
    <cfargument name="uEmail" type="string" required="yes"/>
    <cfset result.message = "The email you have entered does not match our records. Please try again.">
    <cfquery name="rsGetUserInfo" datasource="#application.mcmsDSN_old#">
    SELECT * FROM dbo.tbl_forum_user WHERE 0=0
	AND uEmail = <cfqueryparam value="#ARGUMENTS.uEmail#" cfsqltype="cf_sql_varchar">
    AND uStatus = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint">
    </cfquery>
    <cfif rsGetUserInfo.recordcount NEQ 0>
    <!---Generate a new password.--->
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="generatePassword"
    returnvariable="password">
    <cfinvokeargument name="length" value="6"/>
    </cfinvoke>
    <cftry>
    <cftransaction>
    <cfquery name="updateUser" datasource="#application.mcmsDSN_old#">
    UPDATE dbo.tbl_forum_user SET
    uPassword = <cfqueryparam value="#password#" cfsqltype="cf_sql_varchar">,
    uTempPassword = <cfqueryparam value="#password#" cfsqltype="cf_sql_varchar">
    WHERE ID = <cfqueryparam value="#rsGetUserInfo.ID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <!---Send email.--->
    <cfset emailContent = '#rsGetUserInfo.uFName# #rsGetUserInfo.uLName#, you have requested your user information and during this process your password has been reset. You <br><br>
	Your username and password are: <br> 
	#rsGetUserInfo.uUsername#<br>
	#password#<br><br>
	<a href="#application.websiteURL#forum/?mcmsID=log_in">Log In Now!</a>
	'>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="emailNotification">
    <cfinvokeargument name="emailSubject" value="Forum Forgot Log In"/>
    <cfinvokeargument name="emailContent" value="#emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="emailName" value=""/>
    <cfinvokeargument name="emailTo" value="#ARGUMENTS.uEmail#"/>
    <cfinvokeargument name="emailFrom" value="#application.forumEmail#"/>
    </cfinvoke>
    <cfset result.message = "Your user information has been sent to your email and your password has been reset.">
    <cfcatch type="any">
    <cfset result.message = "An error occured.">
    </cfcatch>
    </cftry>
    </cfif>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getForumTopicsCount" hint="Gets Forum Topics recordcount" access="public" returnType="string" output="false">
    <cfargument name="fID" type="numeric" required="yes" default="0"/>
    <cfargument name="ftopStatus" type="string" required="yes" default="0"/>
    <cfset var rsForumTopicsCount = "" >
    <cfquery name="rsForumTopicsCount" datasource="#application.mcmsDSN_old#">
    SELECT ID FROM dbo.tbl_forum_topic WHERE 0=0
	<cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ftopStatus IN (<cfqueryparam value="#ARGUMENTS.ftopStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <cfreturn rsForumTopicsCount.recordcount>
    </cffunction>
    
    <cffunction name="getTopicMessageCount" hint="Gets Topic Message recordcount" access="public" returnType="string" output="false">
    <cfargument name="fID" type="numeric" required="yes" default="0"/>
    <cfargument name="fuID" type="numeric" required="yes" default="0"/>
    <cfargument name="ftopID" type="numeric" required="yes" default="0"/>
    <cfargument name="fmDate" type="string" required="yes" default=""/>
    <cfargument name="fmStatus" type="string" required="yes" default="0"/>
    <cfset var rsTopicMessageCount = "" >
    <cfquery name="rsTopicMessageCount" datasource="#application.mcmsDSN_old#">
    SELECT ID FROM dbo.tbl_forum_message WHERE 0=0
	<cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fuID NEQ 0>
    AND fuID = <cfqueryparam value="#ARGUMENTS.fuID#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.ftopID NEQ 0>
    AND ftopID = <cfqueryparam value="#ARGUMENTS.ftopID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fmDate NEQ "">
    AND fmDate >= <cfqueryparam value="#DateFormat(ARGUMENTS.fmDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date">
    </cfif>
    AND fmStatus IN (<cfqueryparam value="#ARGUMENTS.fmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <cfreturn rsTopicMessageCount.recordcount>
    </cffunction>
    
    <cffunction name="textLength" hint="Display a block of text to length with expandable features." access="public" returnType="any" output="true">
    <cfargument name="ID" type="numeric" required="yes" default="0"/>
    <cfargument name="text" type="string" required="yes" default=""/>
    <cfargument name="textLength" type="string" required="yes" default=""/>
    <cfsavecontent variable="text">
    <div id="mainDescription">
    <div id="shortDescription#ID#" style="display:block; margin-top:5px;">
    #LEFT(text, textLength)#
    <cfif LEN(text) GT textLength>...
    <br /><br />
    <a href="##thisText#ID#" onClick="ShowContent('longDescription#ID#'); HideContent('shortDescription#ID#');">(+) Expand</a><br />
	<a href="##top"><span class="glyphicon glyphicon-chevron-up"></span>Top</a>
    </cfif>
    </div>
    <div id="longDescription#ID#" style="display:none; background-color:##E5E5E5; padding-left:8px; padding-right:8px; padding-bottom:8px; padding-top:4px; margin-top:5px;">
    #text#
    <br /><br />
    <a href="##thisText#ID#" onClick="ShowContent('shortDescription#ID#'); HideContent('longDescription#ID#');">(-) Collapse</a></div>
    </div>
    </cfsavecontent>
    <cfreturn text>
    </cffunction>
    
    <cffunction name="reportAbuse" hint="Send report of a abuse to the facilitator(s)." returntype="string" output="true">
    <cfargument name="emailSubject" type="string" required="yes">
    <cfargument name="emailType" type="string" required="yes" default="html">
    <cfargument name="emailCC" type="string" required="yes" default="">
    <cfargument name="emailBCC" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mcmsID" type="string" required="yes">
    <cfargument name="formName" type="string" required="yes">
    <cfargument name="currentRow" type="string" required="yes">
    <cfsavecontent variable="abuseForm">
    <!---Construct the abuse comments.--->
    <cfsilent>
    <cfset result.message = "">
    <cfif IsDefined("form.taskAbuse#ARGUMENTS.currentRow#")>
    <cftry>
    <cfset abuseContent = '#form.abuseComments# <br><br> Review this report of abuse - <a href="#application.websiteURL#forum/?mcmsID=#ARGUMENTS.mcmsID#&ID=#ARGUMENTS.ID####ARGUMENTS.formName#=#ARGUMENTS.currentRow#">click here.</a>'>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="emailNotification">
    <cfinvokeargument name="emailSubject" value="#ARGUMENTS.emailSubject#"/>
    <cfinvokeargument name="emailContent" value="#abuseContent#"/>
    <cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
    <cfinvokeargument name="emailName" value="#form.abuseName#"/>
    <cfinvokeargument name="emailTo" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="emailFrom" value="#form.abuseEmail#"/>
    <cfinvokeargument name="emailCC" value="#ARGUMENTS.emailCC#"/>
    <cfinvokeargument name="emailBCC" value="#ARGUMENTS.emailBCC#"/>
    </cfinvoke>
    <cfset result.message = "Thank you for reporting the abuse of this comment. The proper authorities have been notified.">
    <cfcatch type="any">
    <cfset result.message = "An error occcured.">
    </cfcatch>
    </cftry>
    </cfif>
    </cfsilent>
    <div id="this#ARGUMENTS.formName##CurrentRow#" style="display:none;">
    <div id="mainPageSubTitle">Report Abuse <span id="hidetaskMenuList#CurrentRow#" style="float:right; text-align:right; font-size:10px;"><a href="###ARGUMENTS.formName##ARGUMENTS.currentRow#" onClick="HideContent('this#ARGUMENTS.formName##ARGUMENTS.currentRow#'); ShowContent('taskMenuList#ARGUMENTS.currentRow#');">(-) Report Abuse</a></span></div>
    <cfif result.message NEQ "">
    <div id="mcmsMessage">
    <p>
	#result.message#
    </p>
    </div>
    <cfelse>
    <div id="mainText">
    <p>
    We apologize if this content has offended you. We would like to assure you that your report of abuse will be taken seriously! Please complete the form below to submit your report of abuse.
    </p>
    <cfform method="post" name="taskAbuseReport" preloader="no" action="">
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
    <tr>
    <td class="pubBoldSmall">Name:</td>
    <td class="pubNote"><label>
    <cfinput type="text" name="abuseName" required="yes" id="abuseName" maxlength="50" message="Please include your Name.">
    *</label></td>
    </tr>
    <tr>
    <td class="pubBoldSmall">Email:</td>
    <td class="pubNote">
    <cfinput type="text" name="abuseEmail" validate="email" required="yes" id="abuseEmail" size="35" maxlength="100" message="Please include your Email Address in the correct format.">
    *</td>
    </tr>
    <tr>
    <tdclass="pubBoldSmall">Comments:</td>
    <td valign="top"><cftextarea name="abuseComments" cols="50" rows="3" id="abuseComments"></cftextarea></td>
    </tr>
    <tr>
    <td valign="top">&nbsp;</td>
    <td valign="top">
    <cfinput type="hidden" name="taskAbuse#ARGUMENTS.currentRow#" value="true">
    <cfinput type="submit" name="submitAbuse" class="pubButton" id="submitAbuse" value="Report Abuse"></td>
    </tr>
    </table>
    </cfform>
    </div>
    </cfif>
    </div>
    <cfif IsDefined("taskAbuse#ARGUMENTS.currentRow#")>
    <script>
    document.getElementById('this#ARGUMENTS.formName##ARGUMENTS.currentRow#').style.display = "block";
	</script>
    </cfif>
    </cfsavecontent>
    <cfreturn abuseForm>
    </cffunction>
    
    <cffunction name="subscribeUser" hint="Subscribe a user to a Topic." returntype="string" output="true">
    <cfargument name="emailType" type="string" required="yes" default="html">
    <cfargument name="emailCC" type="string" required="yes" default="">
    <cfargument name="emailBCC" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fID" type="numeric" required="yes">
    <cfargument name="mcmsID" type="string" required="yes">
    <cfargument name="formName" type="string" required="yes">
    <cfargument name="subName" type="string" required="yes">
    <cfargument name="currentRow" type="string" required="yes">
    <cfsavecontent variable="subscribeForm">
    <!---Construct the subscribe content.--->
    <cfsilent>
    <cfset result.message = "">
    <cfset subscriptionCheck = 0>
    <!---Insert the subscriber.--->
    <cfif IsDefined("form.taskSubscribe#ARGUMENTS.currentRow#")>
    <cftry>
    <!---Check to see the user is logged in.--->
    <cfif session.logIn EQ false>
    <cfset result.message = 'You must be logged in to subscribe. <a href="#application.websiteURL#forum/?mcmsID=log_in&accessdenied=#URLEncodedFormat('?mcmsID=#url.mcmsID#&ID=#url.ID#')#">Log In Now!</a>'>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="insertSubscribeRecord"
    returnvariable="result">
    <cfinvokeargument name="fID" value="#ARGUMENTS.fID#"/>
    <cfinvokeargument name="ftopID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fuID" value="#session.uID#"/>
    </cfinvoke>
    <cfif result.message EQ "">
    <cfset subscribeContent = '#session.uName#, you have subscribed successfully to "#ARGUMENTS.subName#". You will now recieve email notifications when updates are made. You can remove yourself from this subscription at anytime by clicking the "Unsubscribe" link in your user account page or from any email notification you recieve.  <br><br> Review updates to #ARGUMENTS.subName# now - <a href="#application.websiteURL#forum/?mcmsID=#ARGUMENTS.mcmsID#&ID=#ARGUMENTS.ID####ARGUMENTS.formName#=#ARGUMENTS.currentRow#">click here.</a>'>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="emailNotification">
    <cfinvokeargument name="emailSubject" value="Forum Topic Subscription - #ARGUMENTS.subName#"/>
    <cfinvokeargument name="emailContent" value="#subscribeContent#"/>
    <cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
    <cfinvokeargument name="emailName" value="#ARGUMENTS.subName#"/>
    <cfinvokeargument name="emailTo" value="#session.uEmail#"/>
    <cfinvokeargument name="emailFrom" value="#application.forumEmail#"/>
    <cfinvokeargument name="emailCC" value="#ARGUMENTS.emailCC#"/>
    <cfinvokeargument name="emailBCC" value="#ARGUMENTS.emailBCC#"/>
    </cfinvoke>
    <cfset result.message = "You have successfully subscribed to this Topic.">
    </cfif>
	</cfif>
    <cfcatch type="any">
    <cfset result.message = "An error occcured.">
    </cfcatch>
    </cftry>
    </cfif>
    <!---Unsubscribe the user.--->
    <cfif IsDefined("form.taskUnsubscribe#ARGUMENTS.currentRow#")>
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="deleteSubscribeRecord"
    returnvariable="result">
    <cfinvokeargument name="fID" value="#ARGUMENTS.fID#"/>
    <cfinvokeargument name="ftopID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fuID" value="#session.uID#"/>
    </cfinvoke>
    <cfif result.message EQ "">
    <cfset subscribeContent = '#session.uName#, you have unsubscribed successfully from "#ARGUMENTS.subName#". You will no longer recieve email notifications when updates are made to this Topic.'>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="emailNotification">
    <cfinvokeargument name="emailSubject" value="Forum Topic Unsubscribe - #ARGUMENTS.subName#"/>
    <cfinvokeargument name="emailContent" value="#subscribeContent#"/>
    <cfinvokeargument name="emailType" value="#ARGUMENTS.emailType#"/>
    <cfinvokeargument name="emailName" value="#ARGUMENTS.subName#"/>
    <cfinvokeargument name="emailTo" value="#session.uEmail#"/>
    <cfinvokeargument name="emailFrom" value="#application.forumEmail#"/>
    <cfinvokeargument name="emailCC" value="#ARGUMENTS.emailCC#"/>
    <cfinvokeargument name="emailBCC" value="#ARGUMENTS.emailBCC#"/>
    </cfinvoke>
    <cfset result.message = "You have successfully unsubscribed from this Topic.">
	</cfif>
    <cfcatch type="any">
    <cfset result.message = "An error occcured.">
    </cfcatch>
    </cftry>
    </cfif>
    <cfif session.logIn EQ true>
    <!---Check for an excisting subscription if the user is logged in.--->
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="getTopicSubscription"
    returnvariable="subscriptionCheck">
    <cfinvokeargument name="ftopID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fID" value="#ARGUMENTS.fID#"/>
    <cfinvokeargument name="fuID" value="#session.uID#"/>
    <cfinvokeargument name="fsStatus" value="1"/>
    </cfinvoke>
    <cfset subscriptionCheck = subscriptionCheck.recordcount>
    </cfif>
    </cfsilent>
    <div id="#ARGUMENTS.formName##CurrentRow#">
    <cfif result.message NEQ "">
    <div id="mcmsMessage">
    <p>
	#result.message#
    </p>
    </div>
    </cfif>
    <cfform method="post" name="taskSubscribeForm" preloader="no" action="">
    <!---Switch the submit type when a subscription excists.--->
    <cfif subscriptionCheck EQ 0>
    <cfinput type="hidden" name="taskSubscribe#ARGUMENTS.currentRow#" value="true">
    <cfinput type="submit" name="submitSubscribe" class="pubButton" id="submitSubscribe" value="Subscribe">
    <cfelse>
    <cfif result.message EQ "">
    <p>You are subscribed to this Topic. To unsubscribe click the "Unsubscribe" button.</p>
    </cfif>
    <cfinput type="hidden" name="taskUnsubscribe#ARGUMENTS.currentRow#" value="true">
    <cfinput type="submit" name="submitUnsubscribe" class="pubButton" id="submitUnsubscribe" value="Unsubscribe">
    </cfif>
    </cfform>
    </div>
    </div>
    <cfif IsDefined("taskSubscribe#ARGUMENTS.currentRow#")>
    <script>
    document.getElementById('#ARGUMENTS.formName##ARGUMENTS.currentRow#').style.display = "block";
	</script>
    </cfif>
    </cfsavecontent>
    <cfreturn subscribeForm>
    </cffunction>
    
    <cffunction name="emailNotification" hint="Send an email confirmation as requested." output="false">
    <cfargument name="emailSubject" type="string" required="yes">
    <cfargument name="emailContent" type="string" required="yes">
    <cfargument name="emailType" type="string" required="yes" default="html">
    <cfargument name="emailName" type="string" required="yes">
    <cfargument name="emailTo" type="string" required="yes">
    <cfargument name="emailFrom" type="string" required="yes">
    <cfargument name="emailCC" type="string" required="yes" default="">
    <cfargument name="emailBCC" type="string" required="yes" default="">
    <cfmail
    subject="#ARGUMENTS.emailSubject#"
    from="#ARGUMENTS.emailFrom#"
    to="#ARGUMENTS.emailTo#"
    type="#ARGUMENTS.emailType#"
    cc="#ARGUMENTS.emailCC#"
    bcc="#ARGUMENTS.emailBCC#"
    timeout="30"
    >
    <cfinclude template="/forum/inc/email/inc_cfmail_content.cfm">
    </cfmail>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="emailTopicSubscriber" hint="Send an email to users that have subscribed." returntype="struct" output="false">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uName" type="string" required="yes">
    <cfargument name="fmName" type="string" required="yes">
    <cfargument name="fmMessage" type="string" required="yes">
    <cfargument name="emailType" type="string" required="yes" default="html">
    <cfset result.message = "">
    <cftry>
    <!---Get the subscribers for this Topic.--->
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="getTopicSubscription"
    returnvariable="getTopicSubscriptionRet">
    <cfinvokeargument name="ftopID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fsStatus" value="1"/>
    </cfinvoke>
    <!---Create ARGUMENTS to pass to the email template.--->
    <cfset ARGUMENTS.emailSubject = 'Forum Topic Update - #getTopicSubscriptionRet.ftopName#'>
    <cfset ARGUMENTS.emailContent = '
	<p>#ARGUMENTS.uName# has posted a reply to #getTopicSubscriptionRet.ftopName#.<br/><br/>
	<a href="#application.websiteURL#forum/?mcmsID=topic&ID=#ARGUMENTS.ID#" class="emailBold">#ARGUMENTS.fmName#</a><br/>
	#LEFT(ARGUMENTS.fmMessage, 255)#<cfif LEN(ARGUMENTS.fmMessage) GT 255>...</cfif><br/><br/>
	<a href="#application.websiteURL#forum/?mcmsID=topic&ID=#ARGUMENTS.ID#">Read More...</a>
	</p>
	'>
    <!---Now generate the thread to process the emails.
    <cfthread action="run" name="#getTopicSubscriptionRet.ftopName##RandRange(100, 10000)#" sleep="10">--->
    <cfoutput query="getTopicSubscriptionRet">
    <cfmail
    subject="Forum Topic Update - #getTopicSubscriptionRet.ftopName#"
    from="#application.forumEmail#"
    to="#getTopicSubscriptionRet.uEmail#"
    type="#ARGUMENTS.emailType#"
    timeout="5"
    >
    <cfinclude template="/forum/inc/email/inc_cfmail_content.cfm">
    </cfmail>
    </cfoutput>
    <!---</cfthread> --->
    <cfcatch type="any">
    <cfset result.message = "An error occcured.">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

    <cffunction name="insertRecord" hint="Insert Forum data." output="false">
    <cfargument name="fName" type="numeric" required="yes">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    INSERT INTO dbo.tbl_forum (fName) 
    VALUES (
    <cfqueryparam value="#ARGUMENTS.fName#" cfsqltype="cf_sql_integer">
    )
    </cfquery>
    </cftransaction>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="insertUserRecord" hint="Insert User data." returntype="struct" output="false">
    <cfargument name="uFName" type="string" required="yes">
    <cfargument name="uLName" type="string" required="yes">   
    <cfargument name="uUsername" type="string" required="yes">
    <cfargument name="uPassword" type="string" required="yes"> 
    <cfargument name="uEmail" type="string" required="yes">
    <cfargument name="uStateProv" type="string" required="yes">
    <cfargument name="uZipCode" type="string" required="yes">
    <cfargument name="uProfile" type="string" required="yes" default="">
    <cfargument name="uAvatar" type="string" required="yes" default="default.jpg">
    <cfargument name="uType" type="numeric" required="yes" default="1">
    <cfargument name="uStatus" type="numeric" required="yes" default="1">
    <cfargument name="forceLogIn" type="string" required="yes" default="false">
    <cfset result.message = "">
    <cftry>
    <!---Check if the Username excists.--->
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="getUser"
    returnvariable="checkUsernameRet">
    <cfinvokeargument name="uUsername" value="#ARGUMENTS.uUsername#"/>
    <cfinvokeargument name="uStatus" value="1,2"/>
    </cfinvoke>
    <cfif checkUsernameRet.recordcount NEQ 0>
    <cfset result.message = 'The Username you have chosen already excists. We would suggest adding a number to the end like "#ARGUMENTS.uUsername##RandRange(1,100)#".'>
    </cfif>
    <cfif result.message EQ "">
    <!---Check if the User Email excists.--->
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="getUser"
    returnvariable="checkUserEmailRet">
    <cfinvokeargument name="uEmail" value="#ARGUMENTS.uEmail#"/>
    <cfinvokeargument name="uStatus" value="1,2"/>
    </cfinvoke>
    <cfif checkUserEmailRet.recordcount NEQ 0>
    <cfset result.message = 'The Email you have entered already excists, please try a different Email. <a href="?mcmsID=log_in&taskAltID=forgot_log_in">Click here</a> if you have forgotten your Username & Password.'>
    </cfif>
    </cfif>
    <cfif result.message EQ "">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    INSERT INTO dbo.tbl_forum_user (uFName, uLName, uUsername, uPassword, uEmail, uStateProv, uZipCode, uProfile, uAvatar, uType, uStatus) 
    VALUES (
    <cfqueryparam value="#ARGUMENTS.uFName#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uLName#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uUsername#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uPassword#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uEmail#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uStateProv#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uZipCode#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uProfile#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uAvatar#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.uType#" cfsqltype="cf_sql_smallint">,
    <cfqueryparam value="#ARGUMENTS.uStatus#" cfsqltype="cf_sql_tinyint">
    )
    </cfquery>
    </cftransaction>
    <cftry>
    <cfset emailContent = 'Congratulations #ARGUMENTS.uFName# #ARGUMENTS.uLName#, you have created your account successfully. <br><br>
	Your username and password are: <br> 
	#ARGUMENTS.uUsername#<br>
	#ARGUMENTS.uPassword#<br>
	'>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="emailNotification">
    <cfinvokeargument name="emailSubject" value="Forum Account Created"/>
    <cfinvokeargument name="emailContent" value="#emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="emailName" value="#ARGUMENTS.uFName# #ARGUMENTS.uLName#"/>
    <cfinvokeargument name="emailTo" value="#ARGUMENTS.uEmail#"/>
    <cfinvokeargument name="emailFrom" value="#application.forumEmail#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "An error occured during the Email Notification process.">
    </cfcatch>
    </cftry>
    <cfif ARGUMENTS.forceLogIn EQ 'true'>
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="getLogIn"
    returnvariable="getLogInRet">
    <cfinvokeargument name="uUsername" value="#ARGUMENTS.uUsername#"/>
    <cfinvokeargument name="uPassword" value="#ARGUMENTS.uPassword#"/>
    </cfinvoke>
    <cfset result.message = "Congratulations #ARGUMENTS.uFName# #ARGUMENTS.uLName#, you have created your account successfully. You are now Logged In and you can begin posting to our forum(s).">
    <cfelse>
    <cfset result.message = application.insertPassed>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTopicRecord" hint="Insert Topic data." returntype="struct" output="false">
    <cfargument name="fID" type="numeric" required="yes">
    <cfargument name="fuID" type="numeric" required="yes">
    <cfargument name="ftopName" type="string" required="yes">
    <cfargument name="ftopDescription" type="string" required="yes">
    <cftry>
    <!---First, filter the ftopName submission.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ftopName#"/>
    <cfinvokeargument name="regexString" value="#application.regexString#"/>
    </cfinvoke>
	<cfset ftopName = regexProfanityRet>
    <cfif ftopName CONTAINS '$%&*!'>
    <cfset result.message = "Some profanity was detected in your Topic Name, please refrain from using profanity, bad words, or poor language.">
    </cfif>
    <!---Second, filter the ftopDescription submission.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ftopDescription#"/>
    <cfinvokeargument name="regexString" value="#application.regexString#"/>
    </cfinvoke>
	<cfset ftopDescription = regexProfanityRet>
    <cfif ftopDescription CONTAINS '$%&*!'>
    <cfset result.message = "Some profanity was detected in your Topic Description, please refrain from using profanity, bad words, or poor language.">
    </cfif>
    <cfif NOT IsDefined("result.message")>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    INSERT INTO dbo.tbl_forum_topic (fID, fuID, ftopName, ftopDescription) 
    VALUES (
    <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">,
    <cfqueryparam value="#ARGUMENTS.fuID#" cfsqltype="cf_sql_integer">,
    <cfqueryparam value="#ftopName#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ftopDescription#" cfsqltype="cf_sql_varchar">
    )
    </cfquery>
    </cftransaction>
    <cfset result.taskOK = true>
    <cfset result.message = application.insertPassed>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = application.insertFailed>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertMessageRecord" hint="Insert Message data." returntype="struct" output="false">
    <cfargument name="fID" type="numeric" required="yes">
    <cfargument name="ftopID" type="numeric" required="yes">
    <cfargument name="fuID" type="numeric" required="yes">
    <cfargument name="fmName" type="string" required="yes">
    <cfargument name="fmMessage" type="string" required="yes">
    <cfset result.message = "">
    <cfset result.taskOK = false>
    <cftry>
    <!---First, filter the fmName submission.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fmName#"/>
    <cfinvokeargument name="regexString" value="#application.regexString#"/>
    </cfinvoke>
	<cfset fmName = regexProfanityRet>
    <cfif fmName CONTAINS '$%&*!'>
    <cfset result.message = "Some profanity was detected in your Message Name, please refrain from using profanity, bad words, or poor language.">
    </cfif>
    <!---Second, filter the fmMessage submission.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fmMessage#"/>
    <cfinvokeargument name="regexString" value="#application.regexString#"/>
    </cfinvoke>
	<cfset fmMessage = regexProfanityRet>
    <cfif fmMessage CONTAINS '$%&*!'>
    <cfset result.message = "Some profanity was detected in your Message, please refrain from using profanity, bad words, or poor language.">
    </cfif>
    <cfif result.message EQ "">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    INSERT INTO dbo.tbl_forum_message (fID, ftopID, fuID, fmName, fmMessage) 
    VALUES (
    <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">,
    <cfqueryparam value="#ARGUMENTS.ftopID#" cfsqltype="cf_sql_integer">,
    <cfqueryparam value="#ARGUMENTS.fuID#" cfsqltype="cf_sql_integer">,
    <cfqueryparam value="#fmName#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#fmMessage#" cfsqltype="cf_sql_varchar">
    )
    </cfquery>
    </cftransaction>
    <!---Now send an email to any topic subscribers.--->
    <cfinvoke 
    component="MCMS.component.app.forum.Forum"
    method="emailTopicSubscriber"
    returnvariable="result">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ftopID#"/>
    <cfinvokeargument name="uName" value="#session.uName#"/>
    <cfinvokeargument name="fmName" value="#fmName#"/>
    <cfinvokeargument name="fmMessage" value="#fmMessage#"/>
    <cfinvokeargument name="emailType" value="html"/>
    </cfinvoke>
    <cfset result.taskOK = true>
    <cfset result.message = result.message>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = application.insertFailed>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSubscribeRecord" hint="Subscribe to a Topic." returntype="struct" output="false">
    <cfargument name="fID" type="numeric" required="yes">
    <cfargument name="ftopID" type="numeric" required="yes">
    <cfargument name="fuID" type="numeric" required="yes">
    <cfset result.message = "">
    <cftry>
    <cfquery name="rsSubscribedUser" datasource="#application.mcmsDSN_old#">
    SELECT ID FROM dbo.tbl_forum_topic_subscribe WHERE 
    fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    AND ftopID = <cfqueryparam value="#ARGUMENTS.ftopID#" cfsqltype="cf_sql_integer">
    AND fuID = <cfqueryparam value="#ARGUMENTS.fuID#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif rsSubscribedUser.recordcount NEQ 0>
    <cfset result.message="You have already subscribed to this Topic."> 
    </cfif>
    <cfif result.message EQ "">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    INSERT INTO dbo.tbl_forum_topic_subscribe (fID, ftopID, fuID) 
    VALUES (
    <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">,
    <cfqueryparam value="#ARGUMENTS.ftopID#" cfsqltype="cf_sql_integer">,
    <cfqueryparam value="#ARGUMENTS.fuID#" cfsqltype="cf_sql_integer">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = application.insertFailed>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserRecord" hint="Update User data." returntype="struct" output="false">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uFName" type="string" required="yes" default="">
    <cfargument name="uLName" type="string" required="yes" default="">   
    <cfargument name="uUsername" type="string" required="yes" default="">
    <cfargument name="uPassword" type="string" required="yes" default="">
    <cfargument name="uTempPassword" type="string" required="yes" default=""> 
    <cfargument name="uEmail" type="string" required="yes" default="">
    <cfargument name="uStateProv" type="string" required="yes" default="">
    <cfargument name="uZipCode" type="string" required="yes" default="">
    <cfargument name="uProfile" type="string" required="yes" default="">
    <cfargument name="uAvatar" type="string" required="yes" default="">
    <cfargument name="uAbusePoint" type="numeric" required="yes" default="0">
    <cfargument name="uRank" type="numeric" required="yes" default="0">
    <cfargument name="uType" type="numeric" required="yes" default="0">
    <cfargument name="uStatus" type="numeric" required="yes">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    UPDATE dbo.tbl_forum_user SET
    <cfif ARGUMENTS.uFName NEQ "">
    uFName = <cfqueryparam value="#ARGUMENTS.uFName#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uLName NEQ "">
    uLName = <cfqueryparam value="#ARGUMENTS.uLName#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uUsername NEQ "">
    uUsername = <cfqueryparam value="#ARGUMENTS.uUsername#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uPassword NEQ "">
    uPassword = <cfqueryparam value="#ARGUMENTS.uPassword#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uTempPassword NEQ "">
    uTempPassword = <cfqueryparam value="#ARGUMENTS.uTempPassword#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uEmail NEQ "">
    uEmail = <cfqueryparam value="#ARGUMENTS.uEmail#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uStateProv NEQ "">
    uStateProv = <cfqueryparam value="#ARGUMENTS.uStateProv#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uZipCode NEQ "">
    uZipCode = <cfqueryparam value="#ARGUMENTS.uZipCode#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uProfile NEQ "">
    uProfile = <cfqueryparam value="#ARGUMENTS.uProfile#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uAvatar NEQ "">
    uAvatar = <cfqueryparam value="#ARGUMENTS.uAvatar#" cfsqltype="cf_sql_varchar">,
    </cfif>
    <cfif ARGUMENTS.uAbusePoint NEQ "">
    uAbusePoint = <cfqueryparam value="#ARGUMENTS.uAbusePoint#" cfsqltype="cf_sql_integer">,
    </cfif>
    <cfif ARGUMENTS.uRank NEQ "">
    uRank = <cfqueryparam value="#ARGUMENTS.uRank#" cfsqltype="cf_sql_integer">,
    </cfif>
    <cfif ARGUMENTS.uType NEQ "">
    uType = <cfqueryparam value="#ARGUMENTS.uType#" cfsqltype="cf_sql_smallint">,
    </cfif>
    uStatus = <cfqueryparam value="#ARGUMENTS.uStatus#" cfsqltype="cf_sql_tinyint">
    WHERE ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <!---Update any SESSION variables.--->
    <cfset session.uName=ARGUMENTS.uFName & ' ' & ARGUMENTS.uLName>
    <cfset session.uEmail=ARGUMENTS.uEmail>
    <cfset result.message = application.updatePassed>
    <cfcatch type="any">
    <cfset result.message = application.updateFailed>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserPasswordRecord" hint="Update User password data." returntype="struct" output="false">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uPassword" type="string" required="yes">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    UPDATE dbo.tbl_forum_user SET
    uPassword = <cfqueryparam value="#ARGUMENTS.uPassword#" cfsqltype="cf_sql_varchar">
    WHERE ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfset session.resetPassword = false>
    <cfset result.message = "You have successfully reset your password.">
    <cfcatch type="any">
    <cfset result.message = application.updateFailed>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteRecord" hint="Delete Forum data." output="false">
    <cfargument name="ID" type="numeric" required="yes">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    DELETE FROM dbo.tbl_forum
    WHERE ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="deleteSubscribeRecord" hint="Delete Subscription data." returntype="struct" output="false">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="fID" type="numeric" required="yes" default="0">
    <cfargument name="ftopID" type="numeric" required="yes" default="0">
    <cfargument name="fuID" type="numeric" required="yes" default="0">
    <cfset result.message = "">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN_old#">
    DELETE FROM dbo.tbl_forum_topic_subscribe
    WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0> 
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fID NEQ 0> 
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftopID NEQ 0> 
    AND ftopID = <cfqueryparam value="#ARGUMENTS.ftopID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fuID NEQ 0> 
    AND fuID = <cfqueryparam value="#ARGUMENTS.fuID#" cfsqltype="cf_sql_integer">
    </cfif>
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = application.deleteFailed>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="imageUpload" hint="Upload images." returntype="struct" output="false">
    <cfargument name="tempPath" type="string" required="yes" hint="Temporary path to store original images.">
    <cfargument name="imgPath" type="string" required="yes" hint="Path to place the modified image.">
    <cfargument name="imgThumbPath" type="string" required="yes" default="" hint="Path to place the modified thumb image.">
    <cfargument name="fileField" type="string" required="yes" default="" hint="Name of form field used to uploaded the file.">
    <cfargument name="imgSize" type="numeric" required="yes" hint="Max value for size of image (width px.)">
    <cfargument name="imgThumbSize" type="numeric" required="yes" default="0" hint="Max value for size of image (width px.)">
    <cfargument name="nameConflict" type="string" required="yes" default="overwrite" hint="CFML Action to take if uploaded image's name is already on the server.">
    <cfargument name="acceptFileType" type="string" required="yes" default="image/jpg,image/jpeg,image/pjpg,image/pjpeg" hint="Mime-types to allow.">
    <cfargument name="acceptFileTypeMessage" type="string" required="yes" default="Only JPEG files permitted." hint="Mime-types to allow message.">
    <cfset result.message = "">
    <!---Begin with upload of image to a temp directory.--->
    <cftry>
    <cffile action="upload" 
    nameconflict="#ARGUMENTS.nameConflict#" 
    filefield="#ARGUMENTS.fileField#" 
    destination="#ARGUMENTS.tempPath#" 
    accept="#ARGUMENTS.acceptFileType#"> 
    <cfcatch type="any">
    <cfset result.message = ARGUMENTS.acceptFileTypeMessage>
    </cfcatch>
    </cftry>
    
    <cfif result.message EQ "">
    <!---Create file source--->
    <cfset result.imgFile = CFFILE.ServerFileName & "." & CFFILE.ServerFileExt>
    <cfset fileSource = "#ARGUMENTS.tempPath##result.imgFile#">
    
    <!---If thumbnail is requested.--->
    <cfif ARGUMENTS.imgThumbSize NEQ 0 AND ARGUMENTS.imgThumbPath NEQ "">	
    <cftry>
    <!---Generate thumbnail if applicable.--->
    <cfimage action="resize" 
    width="#ARGUMENTS.imgThumbSize#"
    height="" 
    source="#fileSource#" 
    destination="#ARGUMENTS.imgThumbPath##result.imgFile#" 
    overwrite="yes">
    <cfcatch type="any">
    <cfset result.message = "Thumbnail rezise error occured. Check your size values.">
    </cfcatch>
    </cftry>		
    </cfif>
    </cfif>
    
    <cfif result.message EQ "">
    <!---Create image file.--->
    <cftry>
    <cfimage action="resize" 
    width="#ARGUMENTS.imgSize#" 
    height="" 
    source="#fileSource#" 
    destination="#ARGUMENTS.imgPath##result.imgFile#" 
    overwrite="yes">
    <cfcatch type="any">
    <cfset result.message = "Image rezise error occured. Check your size values.">
    </cfcatch>
    </cftry>
    </cfif>
    <cfreturn result>
    </cffunction>
</cfcomponent>