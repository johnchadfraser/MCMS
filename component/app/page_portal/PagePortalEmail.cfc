<cfcomponent>  
    <cffunction name="sendEmail" access="public" returntype="struct" output="yes">
    <cfargument name="subject" type="string" required="yes" default="#application.companyName# Email">
    <cfargument name="to" type="string" required="yes" default="#TRIM(application.companyEmail)#">
    <cfargument name="from" type="string" required="yes" default="#TRIM(application.companyEmail)#">
    <cfargument name="cc" type="string" required="yes" default="">
    <cfargument name="bcc" type="string" required="yes" default="">
    <cfargument name="body" type="string" required="yes" default="">
    <cfargument name="mimeAttach" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
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
    mimeAttach="#ARGUMENTS.mimeAttach#"
    subject="#ARGUMENTS.subject#"
    timeout="5"
    type="#ARGUMENTS.emailType#"
    >
    <!---Contsruct the email content.--->
    <html>
    <link href="//#CGI.SERVER_NAME#/css/styles.css" rel="stylesheet" type="text/css">
    <body>
    <table align="center" width="720" border="0" cellspacing="0" cellpadding="5">
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
    <td style="padding:0px;"><cfinclude template="#ARGUMENTS.emailTemplate#"></td>
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
    <cfset result.message = "You have not successfully sent your email.">
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
</cfcomponent>
