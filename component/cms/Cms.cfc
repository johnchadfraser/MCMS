<cfcomponent>   
    <cffunction name="setAlert" access="public" returntype="string" output="yes" hint="Displays an alert message.">
    <cfargument name="atID" type="numeric" required="yes" default="0">
    <cfset var a = "" >
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getAlert"
    returnvariable="getAlertRet">
    <cfinvokeargument name="aDateRel" value="#Now()#"/>
    <cfinvokeargument name="aDateExp" value="#Now()#"/>
    <cfinvokeargument name="atID" value="#ARGUMENTS.atID#"/>
    <cfinvokeargument name="aStatus" value="1"/>
    </cfinvoke>
    </cfsilent>
    <cfsavecontent variable="a">
    <div id="mcmsBlanket" style="display:none;"></div>
    <div id="mcmsTimeoutMessage" style="display:none;"></div>
    <cfif getAlertRet.recordcount NEQ 0>
    <cfprocessingdirective suppresswhitespace="yes">
    <div id="mcmsAlert">
    <span id="mcmsAlertIcon" class="glyphicon glyphicon-exclamation-sign"></span>
    <span id="mcmsAlertTitle">#getAlertRet.aName#</span>
    <span id="mcmsAlertDescription">#getAlertRet.aDescription#</span>
    </div>
    </cfprocessingdirective>
    </cfif>
    </cfsavecontent>
    <cfreturn a>
    </cffunction>
    
    <cffunction name="setAlertSocket" access="public" returntype="string" output="yes" hint="Displays an alert message.">
    <cfset var result = "" >
    <script src="/scripts/socket.min.js" type="text/javascript"></script>
    <cfwebsocket name="alertSocket" onmessage="msgAlertHandler" onopen="invokeAlert" />
    <cfsavecontent variable="result">
    <div id="alertSocket"></div> 
    </cfsavecontent>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setCatchError" access="public" returntype="any" output="no" hint="Wraps function in catch block.">
    <cfargument name="catchError" type="string" required="yes" default="true">
    <cfargument name="fn" type="any" required="yes" default="">	
    <cfset result = "" >
    <cfif catchError EQ 'true'>
    <cftry>
    <cfset result = arguments.fn>
    <cfcatch type="any" name="e">
    <cfset result = "Error: " & e.message>
    </cfcatch>	
    <cffinally>
    </cffinally>
    </cftry>
    <cfelse>
    <cfset result = arguments.fn>
    </cfif>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getIPAddressPadding" access="public" returntype="string" output="no" hint="Pads the IP addrress.">
    <cfargument name="ipAddress" type="string" required="yes" default="#CGI.REMOTE_ADDR#">
    <cfset var result = ''>
    <cfset ipx = ''>
    <cfloop index="ip" list="#ARGUMENTS.ipAddress#" delimiters=".">
    <cfif LEN(ip) EQ 1>
    <cfset ipx = ipx & '00#ip#.'>
    <cfelseif LEN(ip) EQ 2>
    <cfset ipx = ipx & '0#ip#.'>
    <cfelse>
    <cfset ipx = ipx & ip & '.'>
    </cfif>
    <cfset result = LEFT(ipx, 15)>
    </cfloop>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setCache" access="public" returntype="void" output="no" hint="Method used to control caching.">
    <cfargument name="cacheID" type="string" required="yes" default="">
    <cfargument name="cacheRegion" type="string" required="yes" default="query">
    <cfargument name="cacheType" type="string" required="yes" default="default">
    <cfswitch expression="#ARGUMENTS.cacheType#">
    <cfcase value="remove">
    <cfset CacheRemove(ARGUMENTS.cacheID, false, ARGUMENTS.cacheRegion, true)>
    <!---Remove public cache query as well by adding Public suffix.--->
    <cfset CacheRemove(ARGUMENTS.cacheID & 'Public', false, ARGUMENTS.cacheRegion, true)>
    </cfcase>
    </cfswitch>
    </cffunction>
    
    <cffunction name="setIPAddressRequest" access="public" returntype="void" output="yes" hint="Sets the IP addrress Request variables.">
    <cfargument name="ipAddress" type="string" required="yes" default="#CGI.REMOTE_ADDR#">
    <cfset var result = ''>
    <cftry>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getIPAddressPadding"
    returnvariable="ip">
    <cfinvokeargument name="ipAddress" value="#ARGUMENTS.ipAddress#"/>
    </cfinvoke>
    <cfset request.remoteIP = ip>
    <cfset request.remotePCSiteIP = MID(ip, 9, 3)>
    <cfset request.remotePCDeptIP = MID(ip, 13, 3)>
    <cfset request.remotePCSiteNo = request.remotePCSiteIP>
    <cfset request.remotePCDeptNo = 0>
    <cfif request.remotePCSiteNo LT 100> 
	<cfset request.remotePCSiteNo = 101>
    <cfset request.remotePCDeptNo = 0>
    </cfif>
    <cfset request.remotePCStateProv = ''>
    <!---Get the State/Prov for this PC based on the pcDeptIP.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteAddress"
    returnvariable="getSiteAddressRet">
    <cfinvokeargument name="siteNo" value="#request.remotePCSiteNo#"/>
    <cfinvokeargument name="saStatus" value="1"/>
    </cfinvoke>
    <cfif getSiteAddressRet.recordcount NEQ 0>
    <cfset request.remotePCStateProv = getSiteAddressRet.saStateProv>
    </cfif>
    <cfcatch type="any">
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="setHTMLHeader" access="public" returntype="string" output="yes" hint="Sets HTML header.">
    <cfargument name="type" type="string" required="yes" default="">
    <cfargument name="appName" type="string" required="yes" default="Application">
    <cfargument name="appDescription" type="string" required="yes" default="">
    <cfset var htmlHeader = "">
    <cfsavecontent variable="htmlHeader">
    <cfprocessingdirective suppresswhitespace="yes">
    
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="author" content="#application.companyName# Development Team.">
    <meta name="description" content="#ARGUMENTS.appDescription#">
    <meta name="copyright" content="#DateFormat(Now(), 'yyyy')#">	
	<link rel="shortcut icon" href="#application.mcmsCDNURL#/MCMS/assets/icon/favicon.ico" type="image/ico" />	
		
	<title>#ARGUMENTS.appName#</title>	
	
	<!---Applied bootstrap. Errors PDF if imported in mcms.min.js--->
	<link href="#application.mcmsCDNURL#/MCMS/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />	
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="#application.mcmsCDNURL#/MCMS/js/bootstrap/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
	
	<!---Apply MCMS core scripts.--->
    <script src="#application.mcmsCDNURL#/MCMS/js/mcms.min.js" language="javascript" type="text/javascript"></script>
	
	<!---Applied accordian styles.--->
	<link href="#application.mcmsCDNURL#/MCMS/css/accordian.min.css" rel="stylesheet" type="text/css" />
	
	<!---Apply MCMS core styles.--->
	<link href="#application.mcmsCDNURL#/MCMS/css/mcms.min.css" rel="stylesheet" type="text/css" />
	
	<!---Apply custom styles.--->
	<link href="/app/custom/css/custom.min.css" rel="stylesheet" type="text/css" />
	
	<!---Apply JQuery.--->
	<script src="#application.mcmsCDNURL#/MCMS/js/jquery/js/jquery.min.js" type="text/javascript"></script>
	


    <cfajaximport tags="cftextarea, cfform, cfinput-datefield, cflayout-tab, cfdiv, cfwindow, cftooltip">
    
    <cfswitch expression="#ARGUMENTS.type#">
    <cfcase value="admin">
    <meta name="robots" content="noindex, nofollow">
    <cfif url.mcmsDenied EQ ''>
    <script type="text/javascript">
    mcmsSessionTimeout('<cfoutput>#session.timeoutSeconds#</cfoutput>');
    </script>
    </cfif>
    </cfcase>
    <cfdefaultcase>
    </cfdefaultcase>
    </cfswitch>
    
    <!---Get IP Address Request variables.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="setIPAddressRequest">
    <cfinvokeargument name="ipAddress" value="#Iif(url.remoteIPAddress NEQ 0, DE(url.remoteIPAddress), DE(CGI.REMOTE_ADDR))#"/>
    </cfinvoke>
    
    </cfprocessingdirective>
    </cfsavecontent>
    <cfreturn htmlHeader>
    </cffunction>
    
    <cffunction name="setHeader" access="public" returntype="string" output="yes" hint="Sets the header for the main index page.">
    <cfargument name="type" type="string" required="yes" default="">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="showAdministration" type="string" required="yes" default="false">
    <cfset var header = "">
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getTaskDirect">
    <cfinvokeargument name="appDirectory" value="#url.appDirectory#"/>
    <cfinvokeargument name="mcmsDirect" value="#url.mcmsDirect#"/>
    <cfinvokeargument name="mcmsDirectPath" value="#url.mcmsDirectPath#"/>
    <cfinvokeargument name="mcmsWorkFlowStatus" value="#url.mcmsWorkFlowStatus#"/>
    <cfinvokeargument name="appID" value="#url.appID#"/>
    <cfinvokeargument name="mcmsPageID" value="#url.mcmsPageID#"/>
    <cfinvokeargument name="mcmsID" value="#url.mcmsID#"/>
    <cfinvokeargument name="ID" value="#url.ID#"/>
    <cfinvokeargument name="tabName" value="#url.tabName#"/>
    </cfinvoke>
    <!---Check if there are any admin applications.--->
    <cfinvoke 
 	component="MCMS.component.cms.Menu"
 	method="getMenuApplicationRel"
 	returnvariable="getMenuApplicationRelRet">
	<cfinvokeargument name="marDateRel" value="#Now()#"/>
	<cfinvokeargument name="marDateExp" value="#Now()#"/>
	<cfinvokeargument name="mtID" value="1"/>
    <cfinvokeargument name="apptID" value="#application.appTypeAdmin#"/>
	<cfinvokeargument name="marStatus" value="1"/>
  	<cfinvokeargument name="orderBy" value="appName"/>
	</cfinvoke>
    
    <cfif form.mcmsDirect NEQ false>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="setTaskDirect">
    <cfinvokeargument name="appDirectory" value="#form.appDirectory#"/>
    <cfinvokeargument name="mcmsDirect" value="#form.mcmsDirect#"/>
    <cfinvokeargument name="mcmsDirectPath" value="#form.mcmsDirectPath#"/>
    <cfinvokeargument name="mcmsWorkFlowStatus" value="#form.mcmsWorkFlowStatus#"/>
    <cfinvokeargument name="appID" value="#form.appID#"/>
    <cfinvokeargument name="mcmsPageID" value="#form.mcmsPageID#"/>
    <cfinvokeargument name="mcmsID" value="#form.mcmsID#"/>
    <cfinvokeargument name="ID" value="#form.ID#"/>
    <cfinvokeargument name="tabName" value="#form.tabName#"/>
    </cfinvoke>
    </cfif>
    <cfsavecontent variable="header">
    <cfprocessingdirective suppresswhitespace="yes">
    <cfajaxproxy cfc="MCMS.component.cms.Cms" jsclassname="ajaxl">
    
    <cfscript>
    mcmsObj.cmsObj = CreateObject('component', 'MCMS.component.cms.CMS');
    </cfscript>
    
	<nav class="navbar navbar-fixed-top">	
      <div class="container">
      	
      <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##mainNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>
      <a href="/"><span class="navbar-brand"></span></a>
      <cfinclude template="/MCMS/view/header.cfm">
      <cfswitch expression="#ARGUMENTS.type#">
        <cfdefaultcase>
        <!---Set menu type.--->
        #mcmsObj.cmsObj.setTaskMenu('public', ARGUMENTS.appID, ARGUMENTS.showAdministration)#
        </cfdefaultcase>
	
    	<cfcase value="admin">
        <!---Set menu type.--->
        #mcmsObj.cmsObj.setTaskMenu('admin', ARGUMENTS.appID, ARGUMENTS.showAdministration)#
    	</cfcase>
   </cfswitch>
      
    </div>
      		
    <cfswitch expression="#ARGUMENTS.type#">
        <cfdefaultcase>
		
		
          
        <!---Set main navigation.--->
        #mcmsObj.cmsObj.setMainNavigation('public',100,1,application.appTypePublic,'1,3','menuName, appName')#	
        </cfdefaultcase>
	
    	<cfcase value="admin">

          
        <!---Set main navigation.--->
        #mcmsObj.cmsObj.setMainNavigation('admin',session.userRoleAccess,1,application.appTypeAdmin,'1,3','menuName, appName')#
    	</cfcase>
   </cfswitch>
   </div>
    </nav>
    <cfscript>
    //Set page alert and view.
	WriteOutput(mcmsObj.cmsObj.setAlert(application.alertType));
    </cfscript>
    </cfprocessingdirective>
    </cfsavecontent>
    <cfreturn header>
    </cffunction>
    
    <cffunction name="setTaskMenu" access="public" returntype="string" output="yes" hint="Sets the tasks menu in the header and controls the sign in state.">
    <cfargument name="type" type="string" required="yes" default="">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="showAdministration" type="string" required="yes" default="false">
    <cfset var taskMenu = "">
    <!---Get user role access to help.--->
    <cfset this.hlptID = 1>
    <!---Developer access.--->
    <cfif session.urID EQ 102>
    <cfset this.hlptID = 0>
    </cfif>
    <!---System Administrator access.--->
    <cfif session.urID EQ 103>
    <cfset this.hlptID = '1,2'>
    </cfif>
    <!---Set the Help menu is there is a record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContentSectionRel"
    returnvariable="getHelpContentSectionRelRet">
    <cfinvokeargument name="appID" value="#Iif(ARGUMENTS.appID EQ 100, DE('0'), DE(ARGUMENTS.appID))#"/>
    <cfinvokeargument name="netID" value="#application.networkID#"/>
    <cfinvokeargument name="hlptID" value="#this.hlptID#"/>
    <cfinvokeargument name="hlpcsrStatus" value="1"/>
    </cfinvoke>
    <cfsavecontent variable="taskMenu">
    <cfprocessingdirective suppresswhitespace="yes">
    <div id="mcmsNavMenu">
    IP: #request.remoteIP#
    <cfswitch expression="#ARGUMENTS.type#">
    <cfcase value="admin">
	<div id="mcmsTimeoutCounter"><script>timeoutCountdown(10, #session.timeoutSeconds#);</script></div>
	<cfif getHelpContentSectionRelRet.recordcount NEQ 0 AND ARGUMENTS.appID NEQ 100>
    <a href="#application.helpServerURL#/?mcmsID=content_redirect&hlpID=#getHelpContentSectionRelRet.hlpID#&hlptID=#this.hlptID#&hlpmID=0&hlpsID=#getHelpContentSectionRelRet.hlpsID#&hlpcID=#getHelpContentSectionRelRet.hlpcID#" target="_blank" id="mcmsHeaderLink">#getHelpContentSectionRelRet.appName# Help</a>
    <cfelseif this.hlptID NEQ 1>
    <a href="#application.helpServerURL#/?hlptID=#this.hlptID#" target="_blank" id="mcmsHeaderLink">#session.userRole# Help</a>
    </cfif>
	<br/>
	Welcome #session.userName# (<a href="/#application.mcmsAppAdminPath#/?mcmsSignOut=true" id="mcmsHeaderLink">Not #session.userName#?</a>)
    <a href="/#application.mcmsAppAdminPath#/?mcmsSignOut=true" id="mcmsHeaderLink"><span class="glyphicon glyphicon-log-out"></span>Sign-Out</a> 
    </cfcase>
    <cfdefaultcase>
    <cfif arguments.showAdministration EQ 'true'>
    <a href="/#application.mcmsAppAdminPath#/" id="mcmsHeaderLink">Administration</a>
    </cfif>
    <cfif session.signedIn EQ 'true'>
    <br/>
    Welcome #session.userName# (<a href="?mcmsSignOut=true" id="mcmsHeaderLink">Not #session.userName#?</a>)
    <a href="?mcmsSignOut=true" id="mcmsHeaderLink"><span class="glyphicon glyphicon-log-out"></span>Sign-Out</a>
    <cfelse>
    <a href="/#application.mcmsAppAdminPath#" id="mcmsHeaderLink"><span class="glyphicon glyphicon-log-in"></span>Sign-In</a>
    </cfif>
    </cfdefaultcase>
    </cfswitch>
    </div>
    </cfprocessingdirective>
    </cfsavecontent>
    <cfreturn taskMenu>
    </cffunction>
    
    <cffunction name="linkAjax" access="remote" returntype="struct" output="true" hint="Uses cfajax proxy to improve linking in cflayout.">
    <cfargument name="layout" type="string" default="">
    <cfargument name="appID" type="string" default="100">
    <cfargument name="tab" type="string" default="">
    <cfargument name="path" type="string" default="">
    <cfargument name="mcmsPageID" type="string" default="">
    <cfargument name="mcmsID" type="string" default="result">
    <cfargument name="ID" type="string" default="0">
    <cfargument name="mcmsWorkFlowStatus" type="string" default="test">
    <cfset result = StructNew()>
    <cfset result.layout = ARGUMENTS.layout>
    <cfset result.appID = ARGUMENTS.appID>
    <cfset result.tab = ARGUMENTS.tab>
    <cfset result.path = ARGUMENTS.path>
    <cfset result.mcmsPageID = ARGUMENTS.mcmsPageID>
    <cfset result.mcmsID = ARGUMENTS.mcmsID>
    <cfset result.ID = ARGUMENTS.ID>
    <cfset result.mcmsWorkFlowStatus = ARGUMENTS.mcmsWorkFlowStatus>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getTaskDirect" access="public" returntype="void" output="yes" hint="Gets the task to direct in AJAX.">
    <cfargument name="appDirectory" type="string" required="yes" default="/#application.mcmsAppAdminPath#/temp/">
    <cfargument name="mcmsDirectPath" type="string" required="yes" default="false">
    <cfargument name="appID" type="string" required="yes" default="100">
    <cfargument name="mcmsPageID" type="string" required="yes" default="">
    <cfargument name="mcmsID" type="string" required="yes" default="result">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tabName" type="string" required="yes" default="Temp">
    <cfargument name="mcmsDirect" type="string" required="yes" default="false">
    <cfargument name="mcmsWorkFlowStatus" type="string" required="yes" default="0" hint="The value (list) of statuses to modify as part of a workflow.">
    <!---Handles direct link via form post.--->
    <cfif ARGUMENTS.mcmsDirect EQ 'true'>
    <cfajaxproxy cfc="MCMS.component.cms.Cms" jsclassname="ajaxl">
    <cfoutput>
    <script language="javascript">
    mcmsAjaxLink('layoutIndex', '#ARGUMENTS.appID#','#ARGUMENTS.tabName#','#ARGUMENTS.appDirectory##ARGUMENTS.mcmsDirectPath#','#ARGUMENTS.mcmsPageID#','#ARGUMENTS.mcmsID#','#ARGUMENTS.ID#', '#ARGUMENTS.mcmsWorkFlowStatus#');
    </script>
    </cfoutput>
    </cfif>
    </cffunction>
    
    <cffunction name="setTaskDirect" access="public" returntype="void" output="yes" hint="Sets the task to direct in AJAX.">
    <cfargument name="appDirectory" type="string" required="yes" default="/#application.mcmsAppAdminPath#/temp/">
    <cfargument name="mcmsDirectPath" type="string" required="yes" default="false">
    <cfargument name="appID" type="string" required="yes" default="100">
    <cfargument name="mcmsPageID" type="string" required="yes" default="">
    <cfargument name="mcmsID" type="string" required="yes" default="result">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tabName" type="string" required="yes" default="Temp">
    <cfargument name="mcmsDirect" type="string" required="yes" default="false">
    <cfargument name="mcmsWorkFlowStatus" type="string" required="yes" default="0" hint="The value (list) of statuses to modify as part of a workflow.">
    <!---Handle direct links. Arguments in order of key.--->
    <cfif ARGUMENTS.mcmsDirect EQ true>
    <script type="text/javascript">   mcmsDirect('#ARGUMENTS.appDirectory#','#ARGUMENTS.mcmsDirectPath#','#ARGUMENTS.appID#','#ARGUMENTS.mcmsPageID#','#ARGUMENTS.mcmsID#','#ARGUMENTS.ID#','#ARGUMENTS.tabName#','#ARGUMENTS.mcmsWorkFlowStatus#');
    </script>
    </cfif>
    </cffunction>
    
    <cffunction name="setMenuNavigation" access="public" returntype="query" output="yes" hint="Sets the menu mavigation based on defaults/authentication.">
    <cfargument name="appID" type="string" required="yes" default="100">
    <cfargument name="mtID" type="numeric" required="yes" default="0">
    <cfargument name="apptID" type="string" required="yes" default="0">
    <cfargument name="marStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="menuName, appName">
    <cfset var rsMenuNavigation = "" >
    <cftry>
    <cfquery name="rsMenuNavigation" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM v_menu_application_rel WHERE 0=0
    <cfif ARGUMENTS.appID NEQ 100>
    AND appID IN (<cfqueryparam value="#ARGUMENTS.appID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.mtID NEQ 0>
    AND mtID = <cfqueryparam value="#ARGUMENTS.mtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.apptID NEQ 0>
    AND apptID IN (<cfqueryparam value="#ARGUMENTS.apptID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (marDateRel <= <cfqueryparam value="#DateAdd('d', 1, DateFormat(Now(), 'mm/dd/yyyy'))#" cfsqltype="cf_sql_date"> AND marDateExp >= <cfqueryparam value="#DateFormat(Now(), 'mm/dd/yyyy')#" cfsqltype="cf_sql_date">)
    AND appStatus IN (<cfqueryparam value="#ARGUMENTS.marStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND menuStatus IN (<cfqueryparam value="#ARGUMENTS.marStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND marStatus IN (<cfqueryparam value="#ARGUMENTS.marStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMenuNavigation = StructNew()>
    <cfset rsMenuNavigation.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMenuNavigation>
    </cffunction>
    
    <cffunction name="setMainNavigation" access="public" returntype="string" output="yes" hint="Sets the navigation for access to applications based on authentication.">
    <cfargument name="type" type="string" required="yes" default="">
    <cfargument name="appID" type="string" required="yes" default="100">
    <cfargument name="mtID" type="numeric" required="yes" default="0">
    <cfargument name="apptID" type="string" required="yes" default="0">
    <cfargument name="marStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="menuName, appName">
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="setMenuNavigation"
    returnvariable="setMenuNavigationRet">
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="mtID" value="#ARGUMENTS.mtID#"/>
    <cfinvokeargument name="apptID" value="#ARGUMENTS.apptID#"/>
    <cfinvokeargument name="marStatus" value="#ARGUMENTS.marStatus#"/>
    <cfinvokeargument name="orderBy" value="#ARGUMENTS.orderBy#"/>
    </cfinvoke>
    <!---Get any Links and add them to the menu.--->
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="getLink"
    returnvariable="getLinkRet">
    <cfinvokeargument name="netID" value="#application.networkID#"/>
    <cfinvokeargument name="ltID" value="2"/>
    <cfinvokeargument name="lStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="lSort,lName"/>
    </cfinvoke>
    </cfsilent>
    <cfsavecontent variable="result">
    
    <div class="mcmsMainNavContainer"> 
    <div class="container">
    	<div class="row no-gutter">
    	
    	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-12" style="padding:0px !important; margin:0px !important;">
    <ul class="nav navbar-nav" id="mainNavBar">
    <cfswitch expression="#ARGUMENTS.type#">
    	<cfdefaultcase>
        
        <li><a href="/">Home</a></li>
        
        <cfif setMenuNavigationRet.recordcount NEQ 0>
    	<cfoutput query="setMenuNavigationRet" group="menuID">
    	<li class="dropdown">
    	<a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">#setMenuNavigationRet.menuName#<span class="caret"></span></a>	
    	
    		
    	
<ul class="dropdown-menu">
    	<cfoutput>
    
    
    
            <li>
            	<!---TODO: Adjust navigation code when the database changes.--->
            	<cfif setMenuNavigationRet.appURL CONTAINS '/admin/'>
            	<cfset this.url = Replace(setMenuNavigationRet.appURL, '/admin/', '/', 'ALL')>
            	<a href="/#application.mcmsAppAdminPath##this.url#/?appID=#setMenuNavigationRet.appID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#"  target="#setMenuNavigationRet.marTarget#">#Iif(setMenuNavigationRet.appNameAlt NEQ "", DE(setMenuNavigationRet.appNameAlt), DE(setMenuNavigationRet.appName))#</a>
            	<cfelse>
            	<a href="/#application.mcmsAppPublicPath##setMenuNavigationRet.appURL#/?appID=#setMenuNavigationRet.appID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#"  target="#setMenuNavigationRet.marTarget#">#Iif(setMenuNavigationRet.appNameAlt NEQ "", DE(setMenuNavigationRet.appNameAlt), DE(setMenuNavigationRet.appName))#</a>
            	</cfif>
            	
            </li>	

    </cfoutput>
    </ul>
    </cfoutput>
       </li> 
       </cfif>
    		
    	</cfdefaultcase>
    	
    	<cfcase value="admin">	
    	<li><a href="/">Home</a></li>
    	<li><a href="/#application.mcmsAppAdminPath#">Main Menu</a></li>
    	<cfif session.urID EQ 102>
    	<li class="dropdown">
    	<a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Control Panel<span class="caret"></span></a>	
    	
    		
    	
<ul class="dropdown-menu">
    	<li><a href="/#application.mcmsAppAdminPath#/global/?appID=0">Global</a></li>
    	<li><a href="/#application.mcmsAppAdminPath#/user/?appID=0">User</a></li>
    	<li><a href="/#application.mcmsAppAdminPath#/application/?appID=0">Application</a></li>
    	<li><a href="/#application.mcmsAppAdminPath#/menu/?appID=0">Menu</a></li>
    	<li><a href="/#application.mcmsAppAdminPath#/alert/?appID=0">Alert</a></li>
    	
    	</ul>
    	</cfif>
        
        <cfif setMenuNavigationRet.recordcount NEQ 0>
    	<cfoutput query="setMenuNavigationRet" group="menuID">
    	<li class="dropdown">
    	<a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">#setMenuNavigationRet.menuName#<span class="caret"></span></a>	
    	
    		
    	
<ul class="dropdown-menu">
    	<cfoutput>
    
    
    
            <li>
            	
            	<a href="/app#setMenuNavigationRet.appURL#/?appID=#setMenuNavigationRet.appID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#"  target="#setMenuNavigationRet.marTarget#">#Iif(setMenuNavigationRet.appNameAlt NEQ "", DE(setMenuNavigationRet.appNameAlt), DE(setMenuNavigationRet.appName))#</a>
            	
            </li>	

    </cfoutput>
    </ul>
    </cfoutput>
       </li> 
       </cfif>
        </cfcase>
        </cfswitch>
        
        
        <cfif getLinkRet.recordcount NEQ 0>
    <li class="dropdown">
    	<a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Links<span class="caret"></span></a>	
    	
    		
    	
<ul class="dropdown-menu">
    <cfoutput query="getLinkRet">
    	
    <!---Check for mcmsPreview.--->
    <cfif getLinkRet.lURL CONTAINS '?'>
    <cfset getLinkRet.lURL = getLinkRet.lURL & Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))>
	<cfelse>
    <cfset getLinkRet.lURL = getLinkRet.lURL & Iif(url.mcmsPreview EQ true, DE('?mcmsPreview=true'), DE(''))>
	</cfif>
	
	<li>
            	
            	<a href="#getLinkRet.lURL#"  target="#getLinkRet.lTarget#">#getLinkRet.lName#</a>
            	
            </li>
	
	
    </cfoutput>
   
    </cfif>
      </ul>
      </div>
      </div>
	</div>
	</div>
    <script>
    //Run mouse leave event to close menu.
	$('ul.nav li.dropdown').hover(function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
}, function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
});
    	
    </script>
    </cfsavecontent>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setNavigation" access="public" returntype="string" output="yes" hint="Sets the navigation for access to applications based on authentication.">
    <cfargument name="type" type="string" required="yes" default="">
    <cfargument name="fontColor" type="string" required="yes" default="##999999">
    <cfargument name="fontSize" type="string" required="yes" default="14">
    <cfargument name="bgColor" type="string" required="yes" default="##E4E4E4">
    <cfargument name="rolloverColor" type="string" required="yes" default="##333333">
    <cfargument name="appID" type="string" required="yes" default="100">
    <cfargument name="mtID" type="numeric" required="yes" default="0">
    <cfargument name="apptID" type="string" required="yes" default="0">
    <cfargument name="marStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="menuName, appName">
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="setMenuNavigation"
    returnvariable="setMenuNavigationRet">
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="mtID" value="#ARGUMENTS.mtID#"/>
    <cfinvokeargument name="apptID" value="#ARGUMENTS.apptID#"/>
    <cfinvokeargument name="marStatus" value="#ARGUMENTS.marStatus#"/>
    <cfinvokeargument name="orderBy" value="#ARGUMENTS.orderBy#"/>
    </cfinvoke>
    <!---Get any Links and add them to the menu.--->
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="getLink"
    returnvariable="getLinkRet">
    <cfinvokeargument name="netID" value="#application.networkID#"/>
    <cfinvokeargument name="ltID" value="2"/>
    <cfinvokeargument name="lStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="lSort,lName"/>
    </cfinvoke>
    </cfsilent>
    <cfsavecontent variable="result">
    <div id="mcmsNavigationContainer">
    <cfmenu name="mcmsNavigationMenu" type="horizontal" fontcolor="#ARGUMENTS.fontColor#" fontsize="#ARGUMENTS.fontSize#" bgcolor="#ARGUMENTS.bgColor#" selectedFontColor="#ARGUMENTS.rolloverColor#">
    <!---Static group links.--->
    <cfswitch expression="#ARGUMENTS.type#">
    <cfcase value="admin">
    <cfmenuitem name="_main_menu" href="/#application.mcmsAppAdminPath#/" display="Main Menu">
    <cfmenuitem name="_home" href="/" display="Home"/>
    </cfmenuitem>
    <cfif setMenuNavigationRet.recordcount NEQ 0>
    <cfset menuGroup = 0>
    <cfset menuList = 0>
    <cfoutput query="setMenuNavigationRet" group="menuID">
    <cfset menuGroup = menuGroup+1>
    <cfmenuitem name="_main#menuGroup#" display="#setMenuNavigationRet.menuName#">
    <cfoutput>
    <!---Create a unique menuName.--->
    <cfset menuList = menuList+1>
    <cfmenuitem name="_#menuList#" href="/app#setMenuNavigationRet.appURL#/?appID=#setMenuNavigationRet.appID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#" display="#Iif(setMenuNavigationRet.appNameAlt NEQ "", DE(setMenuNavigationRet.appNameAlt), DE(setMenuNavigationRet.appName))#" target="#setMenuNavigationRet.marTarget#"/>
    </cfoutput>
    </cfmenuitem>
    </cfoutput>
    </cfif>
    </cfcase>
    <cfdefaultcase>
    <cfmenuitem name="_main_menu" href="/#Iif(url.mcmsPreview EQ true, DE('?mcmsPreview=true'), DE(''))#" display="Home"/>
    <cfif setMenuNavigationRet.recordcount NEQ 0>
    <cfset menuGroup = 0>
    <cfset menuList = 0>
    <cfoutput query="setMenuNavigationRet" group="menuID">
    <cfset menuGroup = menuGroup+1>
    <cfmenuitem name="_main#menuGroup#" display="#setMenuNavigationRet.menuName#">
    <cfoutput>
    <!---Create a unique menuName.--->
    <cfset menuList = menuList+1>
    <cfmenuitem name="_#menuList#" href="/#application.mcmsAppPublicPath##setMenuNavigationRet.appURL#/?appID=#setMenuNavigationRet.appID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#" display="#Iif(setMenuNavigationRet.appNameAlt NEQ "", DE(setMenuNavigationRet.appNameAlt), DE(setMenuNavigationRet.appName))#" target="#setMenuNavigationRet.marTarget#"/>
    </cfoutput>
    </cfmenuitem>
    </cfoutput>
    </cfif>
    </cfdefaultcase>
    </cfswitch>
    
    <cfif getLinkRet.recordcount NEQ 0>
    <cfset linkList = 0>
    <cfmenuitem name="_mainLink" display="Links">
    <cfoutput query="getLinkRet">
    <!---Check for mcmsPreview.--->
    <cfset linkList = linkList+1>
    <cfif getLinkRet.lURL CONTAINS '?'>
    <cfset getLinkRet.lURL = getLinkRet.lURL & Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))>
	<cfelse>
    <cfset getLinkRet.lURL = getLinkRet.lURL & Iif(url.mcmsPreview EQ true, DE('?mcmsPreview=true'), DE(''))>
	</cfif>
    <!---Create a unique lName.--->
    <cfmenuitem name="_link#linkList#" href="#getLinkRet.lURL#" display="#getLinkRet.lName#" target="#getLinkRet.lTarget#"/>
    </cfoutput>
    </cfmenuitem>
    </cfif>
    </cfmenu>
    </div>
    </cfsavecontent>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setApplicationGlobal" access="public" returntype="any" hint="Set application global variables.">
    <cfargument name="appID" type="string" required="yes" default="0">
    <cfargument name="agtID" type="string" required="yes" default="0">
    <cfargument name="agStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="agName">
    <cfset var global = "" >
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationGlobal"
    returnvariable="getApplicationGlobalRet">
    <cfinvokeargument name="appID" value="0,#ARGUMENTS.appID#"/>
    <cfinvokeargument name="agtID" value="#ARGUMENTS.agtID#"/>
    <cfinvokeargument name="agStatus" value="#ARGUMENTS.agStatus#"/>
    <cfinvokeargument name="orderBy" value="#ARGUMENTS.orderBy#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationGlobalType"
    returnvariable="getApplicationGlobalTypeRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.agtID#"/>
    <cfinvokeargument name="agtStatus" value="#ARGUMENTS.agStatus#"/>
    </cfinvoke>
    </cfsilent>
    <!---Set the variables.--->
    <cfif getApplicationGlobalRet.recordcount NEQ 0>
    <!---Construct by type.--->
    <cfset this.varType = UCASE(getApplicationGlobalTypeRet.agtName)>
    <!---Build the struct.--->
    <cfloop query="getApplicationGlobalRet" startrow="1" endrow="#getApplicationGlobalRet.recordcount#">
    <cfset Evaluate("#this.varType#[getApplicationGlobalRet.agName] = getApplicationGlobalRet.agValue")>
    </cfloop>
    </cfif>
    <cfreturn />
    </cffunction>
    
    <cffunction name="setQueryForm" access="public" returntype="string" output="true" hint="Sets the query form.">
    <cfargument name="queryFields" type="string" required="yes" default=""/> 
    <cfargument name="queryType" type="string" required="yes" default="basic"/> 
    <cfargument name="uaID" type="numeric" required="yes" default="105"/>
    <!---Any new query fieled added here must include a URL parameter to the core Application.cfc onRequest method.--->
    <!---Required default param for ajax query form name.--->
    <cfparam name="url._cf_containerID" default="">
    <cfsavecontent variable="query">
    <fieldset>
    <legend>Search</legend>
    <cfform method="#Iif(ARGUMENTS.queryType EQ 'ajax', DE('post'), DE('get'))#" name="query#Iif(ARGUMENTS.queryType EQ 'ajax', DE(url._cf_containerID), DE('Form'))#" id="query#Iif(ARGUMENTS.queryType EQ 'ajax', DE(url._cf_containerID), DE('Form'))#" preloader="no" action="#CGI.SCRIPT_NAME#?appID=#url.appID#&mcmsPageID=#url.mcmsPageID#&pageNo=#url.pageNo#&maxRows=#url.maxRows#&_cf_containerID=#url._cf_containerID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#">
    <div id="valMessage"></div>
    <table id="queryFormTable" cellspacing="0" cellpadding="0">
    <tr>
    <td nowrap colspan="2">
    <!---Set hidden required query string parameters.--->
    <cfinput type="hidden" name="appID" id="appID" value="#url.appID#">
    <cfinput type="hidden" name="mcmsPageID" id="mcmsPageID" value="#url.mcmsPageID#">
    <strong>Keywords:</strong> <cfinput type="text" name="keywords" id="keywords" maxlength="50" value="#Iif(form.keywords EQ 'All', DE('All'), DE(form.keywords))#" onFocus="if(this.value=='All')this.value='';"></td>
    <cfif ARGUMENTS.queryFields CONTAINS "siteNo">
    <td nowrap colspan="2">
    <strong>Site:</strong>
    <cfif session.urID EQ 100>
    All Sites
    <cfinput type="hidden" name="siteNo" id="siteNo" value="100">
    <cfelse>
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getSiteRet">
    <cfinvokeargument name="siteNo" value="#Iif(ARGUMENTS.uaID EQ 101, DE('100'), DE(session.siteNo))#"/>
    <cfinvokeargument name="siteStatus" value="1,3"/>
    </cfinvoke>
    </cfsilent>
    <cfselect name="siteNo" id="siteNo">
    <option value="100">All Sites...</option>
    <cfoutput query="getSiteRet"> 
    <option value="#siteNo#" <cfif siteNo EQ form.siteNo OR siteNo EQ url.siteNo>selected</cfif>>(#siteNo#) #siteName#</option>
    </cfoutput>
    </cfselect>
    </cfif>
    </td>
    </cfif>
    
    <cfif ARGUMENTS.queryFields CONTAINS "deptNo">
    <td>
    <strong>Dept.:</strong>
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.app.department.Department"
    method="getDepartment"
    returnvariable="getDepartmentRet">
    <cfinvokeargument name="deptNo" value="#Iif(ARGUMENTS.uaID EQ 101, DE('0'), DE(session.deptNo))#"/>
    <cfinvokeargument name="deptStatus" value="1,3"/>
    </cfinvoke>
    </cfsilent>
    <cfselect name="deptNo" id="deptNo">
    <option value="0">All Depts...</option>
    <cfoutput query="getDepartmentRet"> 
    <option value="#deptNo#" <cfif deptNo EQ form.deptNo OR deptNo EQ url.deptNo>selected</cfif>>(#deptNo#) #deptName#</option>
    </cfoutput>
    </cfselect>
    </td>
    </cfif>
    <cfif ARGUMENTS.queryFields CONTAINS "status">
    <td>
    <strong>Status:</strong> 
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.utility.List"
    method="getStatus"
    returnvariable="getStatusRet">
    <cfinvokeargument name="sStatus" value="1"/>
    </cfinvoke>
    </cfsilent>
    <cfselect name="status" id="status">
    <option value="1,2,3">All Statuses...</option>
    <cfoutput query="getStatusRet"> 
    <option value="#ID#" <cfif ID EQ form.status OR ID EQ url.status>selected</cfif>>#sName#</option>
    </cfoutput>
    </cfselect>
    </td>
    </cfif>
    <td><cfinput type="submit" name="mcmsQuery" id="mcmsQuery" value="Search"></td>
    </tr>
    <cfif ARGUMENTS.queryFields CONTAINS "dateRel" OR ARGUMENTS.queryFields CONTAINS "dateExp">
    <tr>
    <cfif ARGUMENTS.queryFields CONTAINS "dateRel">
    <td class="bold">Date Rel.:</td>
    <td><cfinput type="datefield" name="dateRel" id="dateRel" maxlength="10" size="10" value="#form.dateRel#" onFocus="this.value='';" validate="date" message="The Release Date must be in the correct format '#application.dateFormat#'."> ie: #application.dateFormat#</td>
    </cfif>
    <cfif ARGUMENTS.queryFields CONTAINS "dateExp">
    <td class="bold">Date Exp.:</td>
    <td><cfinput type="datefield" name="dateExp" id="dateExp" maxlength="10" size="10" value="#form.dateExp#" onFocus="this.value='';" validate="date" message="The Expiration Date must be in the correct format '#application.dateFormat#'."> ie: #application.dateFormat#</td>
    </cfif>
    <td colspan="2">&nbsp;</td>
    </tr>
    </cfif>
    </table>
    </cfform>
    </fieldset>
    </cfsavecontent>
    <cfreturn query>
    </cffunction> 
    
    <cffunction name="setPageResult" access="public" returntype="string" output="true" hint="Sets the page results.">
    <cfargument name="id" type="string" required="yes" default=""/>
    <cfargument name="increment" type="numeric" required="yes" default="10"/>
    <cfargument name="maxCount" type="numeric" required="yes" default="4"/>
    <cfargument name="recordCount" type="numeric" required="yes" default="0"/>
    <cfargument name="appID" type="numeric" required="yes" default="0"/>
    <cfargument name="pageID" type="string" required="yes" default=""/>
    <cfargument name="pageNo" type="numeric" required="yes" default="1"/>
    <cfargument name="queryString" type="string" required="yes" default=""/>
    <cfargument name="startRow" type="numeric" required="yes" default="1"/>
    <cfargument name="endRow" type="numeric" required="yes" default="1"/>
    <cfargument name="totalPages" type="numeric" required="yes" default="1"/>
    <cfargument name="maxRows" type="numeric" required="yes" default="#request.rowCount#"/>
    <cfsavecontent variable="pageResult">
    <!---Below "select" required for JQuery tablesorter. DO NOT REMOVE.--->
    <div id="#ARGUMENTS.id#" style="display:none;">
    <select class="pagesize" style="visibility:hidden;"><option value="#ARGUMENTS.maxRows#"></option></select>
	</div>

	<div id="mcmsResultPageNavigation">
    
    <cfif ARGUMENTS.recordCount GT ARGUMENTS.increment>
    <a href="#ajaxLink('#CGI.SCRIPT_NAME#?appID=#ARGUMENTS.appID#&mcmsPageID=#ARGUMENTS.pageID#&pageNo=1&maxRows=#ARGUMENTS.maxRows#&#ARGUMENTS.queryString##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#')#"><span class="glyphicon glyphicon-fast-backward"></span></a>
    <a href="#ajaxLink('#CGI.SCRIPT_NAME#?appID=#ARGUMENTS.appID#&mcmsPageID=#ARGUMENTS.pageID#&pageNo=#Max(DecrementValue(ARGUMENTS.pageNo),1)#&maxRows=#ARGUMENTS.maxRows#&#ARGUMENTS.queryString##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#')#"><span class="glyphicon glyphicon-backward"></span></span></a>
    <cfif ARGUMENTS.recordCount GT ARGUMENTS.endRow>
    <a href="#ajaxLink('#CGI.SCRIPT_NAME#?appID=#ARGUMENTS.appID#&mcmsPageID=#ARGUMENTS.pageID#&pageNo=#Min(IncrementValue(ARGUMENTS.pageNo),ARGUMENTS.totalPages)#&maxRows=#ARGUMENTS.maxRows#&#ARGUMENTS.queryString##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#')#"><span class="glyphicon glyphicon-forward"></span></a>
    <a href="#ajaxLink('#CGI.SCRIPT_NAME#?appID=#ARGUMENTS.appID#&mcmsPageID=#ARGUMENTS.pageID#&pageNo=#ARGUMENTS.totalPages#&maxRows=#ARGUMENTS.maxRows#&#ARGUMENTS.queryString##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#')#"><span class="glyphicon glyphicon-fast-forward"></span></a>
    </cfif>

    </div>
	

	<div id="mcmsResultPaging">
    Results Per Page:
    <cfloop index="index" from="1" to="#ARGUMENTS.maxCount#"> 
    <cfif index*ARGUMENTS.increment EQ ARGUMENTS.maxRows>
    <strong>#index*ARGUMENTS.increment#</strong>
    <cfelse>
    <a href="#ajaxLink('#CGI.SCRIPT_NAME#?appID=#ARGUMENTS.appID#&mcmsPageID=#ARGUMENTS.pageID#&pageNo=#ARGUMENTS.pageNo#&maxRows=#index*ARGUMENTS.increment#&#ARGUMENTS.queryString##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#')#">#index*ARGUMENTS.increment#</a>
    </cfif>
    <cfif index*ARGUMENTS.increment GT ARGUMENTS.recordCount>
    <cfbreak>
    </cfif>
    <cfif index NEQ ARGUMENTS.maxCount>|</cfif>
    </cfloop>
    &nbsp;&nbsp;&nbsp;Records: #ARGUMENTS.startRow# - #ARGUMENTS.endRow#
    </div>
    </cfif>
</div>
    </cfsavecontent>
    <cfreturn pageResult>
    </cffunction>
    
    <cffunction name="setTaskCRUDMenu" access="public" returntype="string" output="true" hint="Sets the menu for CRUD tasks.">
    <cfargument name="uaID" type="numeric" required="yes" default="105"/>
    <cfargument name="queryString" type="string" required="yes" default=""/>
    <cfsavecontent variable="taskMenu">
    <cfset this.queryString = Replace(Replace(ARGUMENTS.queryString, '|', '=', 'All'), '^', '&', 'All')>
    <!---Call the timeout counter feature.--->
    <cfif url.mcmsID NEQ "insert" AND ARGUMENTS.uaID LTE 103>
    <a id="mcmsCrudInsertLink" href="#ajaxLink('#CGI.SCRIPT_NAME#?appID=#url.appID#&mcmsPageID=#url.mcmsPageID#&mcmsID=insert&pageNo=#url.pageNo#&maxRows=#url.maxRows#&#this.queryString##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#')#">Insert</a>
    </cfif>
    <cfif url.mcmsID NEQ "result">
    <a id="mcmsCrudResultLink" href="#ajaxLink('#CGI.SCRIPT_NAME#?appID=#url.appID#&mcmsPageID=#url.mcmsPageID#&mcmsID=result&pageNo=#url.pageNo#&maxRows=#url.maxRows#&#this.queryString##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#')#">Search</a>
    </cfif>
    </cfsavecontent>
    <cfreturn taskMenu>
    </cffunction>
    
    <cffunction name="setPagingVariables" access="public" returntype="void" output="true" hint="Sets paging variables.">
    <cfargument name="maxRows" type="numeric" required="yes" default="0"/>
    <cfargument name="pageNo" type="numeric" required="yes" default="0"/>
    <cfargument name="recordcount" type="numeric" required="yes" default="0"/>
    <cfargument name="queryString" type="string" required="yes" default=""/>
    <cfscript>
    request.maxRows = ARGUMENTS.maxRows;
	request.startRow = Min((ARGUMENTS.pageNo - 1) * maxRows + 1, Max(ARGUMENTS.recordcount, 1));
	request.endRow = Min(request.startRow + request.maxRows - 1, ARGUMENTS.recordcount);
	request.totalPages = Ceiling(ARGUMENTS.recordcount / request.maxRows);
	request.queryString = ARGUMENTS.queryString;
    </cfscript>
    </cffunction>
    
    <cffunction name="setTabMenu" access="public" returntype="string" output="true" hint="Sets a tab menu for basic type web pages.">
    <cfargument name="appID" type="numeric" required="yes" default="0"/>
    <cfargument name="pageID" type="string" required="yes" default=""/>
    <cfargument name="pageName" type="string" required="yes" default=""/>
    <cfsavecontent variable="tabMenu">
    <div style="-moz-user-select: none;" id="ext-gen9" class="x-tab-panel-header x-unselectable x-tab-panel-header-plain"> 
    <div id="ext-gen12" class="x-tabs-strip-wrap">
    <cfset tabLoop = 0>
    <ul id="ext-gen14" class="x-tab-strip x-tab-strip-top">
    <cfloop index="page" list="#ARGUMENTS.pageName#">
    <cfset tabLoop = tabLoop + 1>
    <li class="#Iif(tabLoop EQ 1 AND ARGUMENTS.pageID EQ '' OR ARGUMENTS.pageID EQ page, DE('x-tab-strip-active'), DE(''))#">
    <a id="ext-gen17" class="x-tab-strip-close"></a>
    <a id="ext-gen18" class="x-tab-right" href="?appID=#ARGUMENTS.appID#&mcmsPageID=#page#">
    <em class="x-tab-left">
	<span class="x-tab-strip-inner">
    <span class="x-tab-strip-text">#page#</span>
    </span>
    </em>
    </a>
    </li>
    </cfloop>
    <li id="ext-gen15" class="x-tab-edge">
	<span class="x-tab-strip-text">&nbsp;</span>
	</li>
    <div id="ext-gen16" class="x-clear"></div>
    </ul>
    </div>
    <div id="ext-gen13" class="x-tab-strip-spacer">
	</div>
	</div>
    </cfsavecontent>
    <cfreturn tabMenu>
    </cffunction>  
    
    <cffunction name="setTaskResult" access="public" returntype="string" output="true" hint="Sets the tasks for a result page.">
    <cfargument name="appID" type="numeric" required="yes" default="100"/>
    <cfargument name="reportType" type="string" required="yes" hint="Either EXCEL PDF or other."/>
    <cfargument name="reportCFC" type="string" required="yes" hint="CFC used for the report in the root cfc directory."/>
    <cfargument name="reportFunction" type="string" required="yes" hint="Function used within the CFC for the report."/>
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="status" type="string" required="yes" default="1,2,3">
    <cfsavecontent variable="taskResult">
    <cfoutput>
    <!---Apply warning to report generation due to it is a All query.--->
    <cfset alertMessage = 'Are you SURE you want to run a report for all data?\n It may cause system slow down and take some time to complete.\n Hit Cancel and filter your query prior to generating it.'>
    <cfset confirmJS = "return confirm('#HTMLEditFormat(alertMessage)#')">
    <a href="/#application.mcmsAppTaskPath#/export/?appID=#url.appID#&mcmsReportType=#ARGUMENTS.reportType#&mcmsReportCFC=#ARGUMENTS.reportCFC#&mcmsReportFunction=#ARGUMENTS.reportFunction#&keywords=#ARGUMENTS.keywords#&siteNo=#ARGUMENTS.siteNo#&deptNo=#ARGUMENTS.deptNo#&args=#ARGUMENTS.args#&status=#ARGUMENTS.status##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#" target="_blank" onClick="#Iif(form.keywords EQ 'All', DE(confirmJS), '')#"><img src="/MCMS/assets/icon/excel.gif" alt="Excel Report" name="excel_report" hspace="3" border="0" align="absmiddle" id="excel_report" />Excel</a>
    </cfoutput>
    </cfsavecontent>
    <cfreturn taskResult>
    </cffunction> 
    
    <cffunction name="setFooter" access="public" returntype="string" output="yes" hint="Sets the footer.">
    <cfargument name="mtID" type="numeric" required="yes" default="0">
    <cfargument name="apptID" type="string" required="yes" default="0">
    <cfargument name="marStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="menuName, appName">
    <cfset var footer = "">
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="setMenuNavigation"
    returnvariable="setMenuNavigationRet">
    <cfinvokeargument name="mtID" value="#ARGUMENTS.mtID#"/>
    <cfinvokeargument name="apptID" value="#ARGUMENTS.apptID#"/>
    <cfinvokeargument name="marStatus" value="#ARGUMENTS.marStatus#"/>
    <cfinvokeargument name="orderBy" value="#ARGUMENTS.orderBy#"/>
    </cfinvoke>
    </cfsilent>
    <cfsavecontent variable="footer">
    <cfprocessingdirective suppresswhitespace="yes">
    
    <footer class="footer">
      <div class="container">
      	<div class="row no-gutter">
      		
      		<div class="col-md-5">	
      		<a href="http://www.adobe.com" target="_blank" >Powered by Adobe</a> 
    <a href="http://www.adobe.com/devnet/coldfusion/"><img src="/MCMS/assets/logo/cf_logo.gif" alt="Powered by ColdFusion" name="cf_logo" hspace="5" border="0" id="cf_logo" valign="middle"></a>	<br/>
      		
      		&copy;#DateFormat(Now(), 'yyyy')# #application.companyname# - All Rights Reserved.
      		
      	</div>
      	<div class="col-md-7">	
      	
      <cfoutput query="setMenuNavigationRet">
      	
      	
      	<!---TODO: Adjust navigation code when the database changes.--->
            	<cfif setMenuNavigationRet.appURL CONTAINS '/admin/'>
            	<cfset this.url = Replace(setMenuNavigationRet.appURL, '/admin/', '/', 'ALL')>
            	<a href="/#application.mcmsAppAdminPath##this.url#/?appID=#appID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#" id="mcmsFooterLink" title="#appName#" target="#marTarget#">#Iif(appNameAlt NEQ "", DE(appNameAlt), DE(appName))#</a>
            	<cfelse>
            	<a href="/#application.mcmsAppPublicPath##appURL#/?appID=#appID##Iif(url.mcmsPreview EQ true, DE('&mcmsPreview=true'), DE(''))#" id="mcmsFooterLink" title="#appName#" target="#marTarget#">#Iif(appNameAlt NEQ "", DE(appNameAlt), DE(appName))#</a>
            	</cfif>
    </cfoutput>
      
      </div>
      	</div>
      
      
      </div>
      
    </footer>
    </cfprocessingdirective>
    
	<!---Apply jQuery validator.--->
    <script src="#application.mcmsCDNURL#/MCMS/js/jquery/validator/js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="#application.mcmsCDNURL#/MCMS/js/jquery/validator/js/additional-methods.min.js" type="text/javascript"></script>
    
    <!---Apply Bootstrap stack.--->
    <script src="#application.mcmsCDNURL#/MCMS/js/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    
    <!---Applied accordian scripts.--->
	<script src="#application.mcmsCDNURL#/MCMS/js/accordian.min.js" type="text/javascript"></script>
	
	<script src="#application.mcmsCDNURL#/MCMS/js/float-label.min.js" type="text/javascript"></script>
    
    <!---Apply Tablesorter scripts.--->
    <script type="text/javascript" src="#application.mcmsCDNURL#/MCMS/js/ajax/jquery/tablesorter/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="#application.mcmsCDNURL#/MCMS/js/ajax/jquery/tablesorter/addons/pager/jquery.tablesorter.pager.js"></script>
	
	    <!---Reference any app specific js or css.--->
    <cfif FileExists(ExpandPath('#Replace(CGI.SCRIPT_NAME, '/index.cfm', '', 'ALL')#/js/script.min.js'))>
    <script src="#Replace(CGI.SCRIPT_NAME, '/index.cfm', '', 'ALL')#/js/script.min.js" language="javascript" type="text/javascript"></script>	
    </cfif>
    <cfif FileExists(ExpandPath('#Replace(CGI.SCRIPT_NAME, '/index.cfm', '', 'ALL')#/js/validation.js'))>
    <script src="#Replace(CGI.SCRIPT_NAME, '/index.cfm', '', 'ALL')#/js/validation.js" language="javascript" type="text/javascript"></script>	
    </cfif>
    <cfif FileExists(ExpandPath('#Replace(CGI.SCRIPT_NAME, '/index.cfm', '', 'ALL')#/css/style.min.css'))>
    <link href="#Replace(CGI.SCRIPT_NAME, '/index.cfm', '', 'ALL')#/css/style.min.css" rel="stylesheet" type="text/css" />	
    </cfif>
    
    </cfsavecontent>
    <cfreturn footer>
    </cffunction>
    
    <cffunction name="getNetwork" access="public" returntype="query" output="yes" hint="Get network records.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="netName" type="string" required="yes" default="">
    <cfargument name="netStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="netName">
    <cfset var rsNetwork = "" >
    <cftry>
    <cfquery name="rsNetwork" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_network WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(netName) LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.netName NEQ "">
    AND UPPER(netName) = <cfqueryparam value="#UCASE(ARGUMENTS.netName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND netStatus IN (<cfqueryparam value="#ARGUMENTS.netStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNetwork = StructNew()>
    <cfset rsNetwork.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNetwork>
    </cffunction>
    
    <cffunction name="getMaxValueSQL" access="public" returntype="string" output="yes" hint="Get max value of table ID for SQL. 0 is an error.">
    <cfargument name="tableName" type="string" required="yes" default="DUAL">
    <cfset var rsMaxValueSQL = "" >
    <cftry>
    <cfset isSQL = 'SELECT MAX(ID) AS ID FROM ' & ARGUMENTS.tableName>
    <cfquery name="rsMaxValueSQL" datasource="#application.mcmsDSN#">
    #PreserveSingleQuotes(isSQL)#
    </cfquery>
    <cfreturn rsMaxValueSQL.ID>
    <cfcatch type="any">
    <!---Check for zero for error.--->
    <cfreturn 0>
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="getNextValueSQL" access="public" returntype="string" output="yes" hint="Get next value of sequence ID for SQL. 0 is an error.">
	<cfargument name="sequenceOwner" type="string" required="yes" default="" hint="Schema Name">
	<cfargument name="sequenceName" type="string" required="yes" default="">
	<cfset var rsNextValueSQL = "" >
    <cftry>    
    <cfset isSQL = "SELECT LAST_NUMBER AS ID FROM all_sequences WHERE sequence_owner = '#UCASE(ARGUMENTS.sequenceOwner)#' AND sequence_name =  '#UCASE(ARGUMENTS.sequenceName)#'">   
    <cfquery name="rsNextValueSQL" datasource="#application.mcmsDSN#">
    #PreserveSingleQuotes(isSQL)#
    </cfquery>
    <cfreturn rsNextValueSQL.ID>
    <cfcatch type="any">
    <!---Check for zero for error.--->
    <cfreturn 0>
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="getAlert" access="public" returntype="query" output="yes" hint="Get Alert data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aName" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="aDateRel" type="string" required="yes" default="">
    <cfargument name="aDateExp" type="string" required="yes" default="">
    <cfargument name="atID" type="numeric" required="yes" default="0">
    <cfargument name="atStatus" type="string" required="no" default="1">
    <cfargument name="aStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aName">
    <cfset var rsAlert = "" >
    <cftry>
    <cfquery name="rsAlert" datasource="#application.mcmsDSN#">
    SELECT * FROM v_alert WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aName) LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.aName NEQ "">
    AND UPPER(aName) = <cfqueryparam value="#UCASE(ARGUMENTS.aName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.aDateRel NEQ "">
    AND aDateRel <= <cfqueryparam value="#DateAdd('d', 1, ARGUMENTS.aDateRel)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.aDateExp NEQ "">
    AND aDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.aDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.atID NEQ 0>
    AND atID = <cfqueryparam value="#ARGUMENTS.atID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND atStatus IN (<cfqueryparam value="#ARGUMENTS.atStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND aStatus IN (<cfqueryparam value="#ARGUMENTS.aStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAlert = StructNew()>
    <cfset rsAlert.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAlert>
    </cffunction>
    
    <cffunction name="getAlertType" access="public" returntype="query" output="yes" hint="Get Alert Type data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="atName" type="string" required="yes" default="">
    <cfargument name="atStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="atName">
    <cfset var rsAlertType = "" >
    <cftry>
    <cfquery name="rsAlertType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_alert_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(atName) LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.atName NEQ "">
    AND UPPER(atName) = <cfqueryparam value="#UCASE(ARGUMENTS.aName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND atStatus IN (<cfqueryparam value="#ARGUMENTS.atStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAlertType = StructNew()>
    <cfset rsAlertType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAlertType>
    </cffunction>
    
    <cffunction name="getApplication" access="public" returntype="any" hint="Get Application data.">
    <cfargument name="args" type="struct" required="no" default="{}">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="appName" type="string" required="yes" default="">
    <cfargument name="appURL" type="string" required="yes" default="">
    <cfargument name="apptID" type="string" required="yes" default="0">
    <cfargument name="apptStatus" type="string" required="no" default="1">
    <cfargument name="appStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="appName">
    <cfset var rsApplication = "">
    <cftry>
    <cfquery name="rsApplication" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM v_application WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(appName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(appDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.appID NEQ 100>
    AND appID = <cfqueryparam value="#ARGUMENTS.appID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.appName NEQ "">
    AND UPPER(appName) = <cfqueryparam value="#UCASE(ARGUMENTS.appName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.args.appURL NEQ "">
    AND UPPER(appURL) = <cfqueryparam value="#UCASE(ARGUMENTS.args.appURL)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.apptID NEQ 0>
    AND apptID IN (<cfqueryparam value="#ARGUMENTS.apptID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND apptStatus IN (<cfqueryparam value="#ARGUMENTS.apptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND appStatus IN (<cfqueryparam value="#ARGUMENTS.args.appStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsApplication = StructNew()>
    <cfset rsApplication.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsApplication>
    </cffunction>
    
    <cffunction name="getApplicationReport" access="public" returntype="query" hint="Get Application Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="appName">
    <cfset var rsApplicationReport = "" >
    <cfquery name="rsApplicationReport" datasource="#application.mcmsDSN#">
    SELECT ID, appName AS Name, appNameAlt AS ALT_Name, TO_CHAR(appDescription) AS Description, appURL AS URL, imgName AS Image, apptName AS Type, sName AS Status FROM v_application WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(appName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(appDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsApplicationReport>
    </cffunction>
    
    <cffunction name="getApplicationType" access="public" returntype="any" hint="Get Application Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="apptName" type="string" required="yes" default="">
    <cfargument name="apptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="apptName">
    <cfset var rsApplicationType = "">
    <cftry>
    <cfquery name="rsApplicationType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_application_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(apptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.apptName NEQ "">
    AND apptName = <cfqueryparam value="#ARGUMENTS.apptName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND apptStatus IN (<cfqueryparam value="#ARGUMENTS.apptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsApplicationType = StructNew()>
    <cfset rsApplicationType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsApplicationType>
    </cffunction>
    
    <cffunction name="getApplicationTypeReport" access="public" returntype="query" hint="Get Application Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="apptName">
    <cfset var rsApplicationTypeReport = "" >
    <cftry>
    <cfquery name="rsApplicationTypeReport" datasource="#application.mcmsDSN#">
    SELECT ID, apptName AS Name FROM tbl_application_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(apptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsApplicationTypeReport = StructNew()>
    <cfset rsApplicationTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsApplicationTypeReport>
    </cffunction>
    
    <cffunction name="getApplicationGlobal" access="public" returntype="query" hint="Get Application Global data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="string" required="yes" default="100">
    <cfargument name="agName" type="string" required="yes" default="">
    <cfargument name="agtID" type="numeric" required="yes" default="0">
    <cfargument name="agtStatus" type="string" required="no" default="1">
    <cfargument name="agStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="agName">
    <cfset var rsApplicationGlobal = "" >
    <!---<cftry>--->
    <cfquery name="rsApplicationGlobal" datasource="#application.mcmsDSN#">
    SELECT * FROM v_application_global WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (agName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR agDescription LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.agName NEQ "">
    AND agName = <cfqueryparam value="#ARGUMENTS.agName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.agtID NEQ 0>
    AND agtID = <cfqueryparam value="#ARGUMENTS.agtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.appID NEQ "">
    AND appID IN (<cfqueryparam value="0,#ARGUMENTS.appID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND agtStatus IN (<cfqueryparam value="#ARGUMENTS.agtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND agStatus IN (<cfqueryparam value="#ARGUMENTS.agStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.
    <cfcatch type="any">
    <cfset rsApplicationGlobal = StructNew()>
    <cfset rsApplicationGlobal.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>--->
    <cfreturn rsApplicationGlobal>
    </cffunction>
    
    <cffunction name="getGlobalReport" access="public" returntype="query" hint="Get Global Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="agName">
    <cfset var rsGlobalReport = "" >
    <cftry>
    <cfquery name="rsGlobalReport" datasource="#application.mcmsDSN#">
    SELECT appID AS APPLICATION_ID, agName AS Name, TO_CHAR(agDescription) AS Description, TO_CHAR(agValue) AS Value, agtName AS Type, sName AS Status FROM v_application_global WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(agName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(agDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsGlobalReport> = StructNew()>
    <cfset rsGlobalReport>.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsGlobalReport>
    </cffunction>
    
    <cffunction name="getGlobalTypeReport" access="public" returntype="query" hint="Get Global Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="agtName">
    <cfset var rsGlobalTypeReport = "" >
    <cftry>
    <cfquery name="rsGlobalTypeReport" datasource="#application.mcmsDSN#">
    SELECT ID, agtName AS Name FROM tbl_application_global_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(agtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsGlobalTypeReport = StructNew()>
    <cfset rsGlobalTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsGlobalTypeReport>
    </cffunction>
    
    <cffunction name="getApplicationGlobalType" access="public" returntype="query" hint="Get Application Global Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="agtName" type="string" required="yes" default="">
    <cfargument name="agtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="agtName">
    <cfargument name="cacheQueryTime" type="string" required="yes" default="0,12,0,0">
    <cfset var rsApplicationGlobalType = "" >
    <cftry>
    <cfquery name="rsApplicationGlobalType" datasource="#application.mcmsDSN#" cachedWithin="#CreateTimeSpan(ListGetAt(ARGUMENTS.cacheQueryTime,1),ListGetAt(ARGUMENTS.cacheQueryTime,2),ListGetAt(ARGUMENTS.cacheQueryTime,3),ListGetAt(ARGUMENTS.cacheQueryTime,4))#">
    SELECT * FROM tbl_application_global_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND agtName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.agtName NEQ "">
    AND agtName = <cfqueryparam value="#ARGUMENTS.agtName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND agtStatus IN (<cfqueryparam value="#ARGUMENTS.agtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsApplicationGlobalType = StructNew()>
    <cfset rsApplicationGlobalType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsApplicationGlobalType>
    </cffunction>
    
    <cffunction name="getReportFunction" access="public" returntype="string" output="yes" description="Gets the Report Function and renders it to report type.">
    <cfargument name="reportName" type="string" required="yes" default="report">
    <cfargument name="reportType" type="string" required="yes" default="EXCEL">
    <cfargument name="reportCFC" type="string" required="yes">
    <cfargument name="reportFunction" type="string" required="yes">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="status" type="string" required="yes" default="1,2,3">
    <cfsavecontent variable="reportFunctionResult">
    <link href="/css/styles.css" rel="stylesheet" type="text/css">
    <!---Override any background image.--->
    <body style="background-image:none;">
    <!---<cftry>--->
    <cfsilent>
    <cfinvoke 
    component="#application.mcmsComponentPath#/#ARGUMENTS.reportCFC#" 
    method="#ARGUMENTS.reportFunction#" 
    returnvariable="result">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#">
    <cfinvokeargument name="args" value="#ARGUMENTS.args#">
    <cfinvokeargument name="status" value="#ARGUMENTS.status#">
    </cfinvoke>
    </cfsilent>
    <!---Check the report type.--->
    <cfswitch expression="#ARGUMENTS.reportType#">
    <cfcase value="EXCEL">
    <!---Serialize the query to sort the columnlist as the functions SQL order.--->
    <cfwddx action="CFML2WDDX" input="#result#" output="qWDDX">
    <cfset fieldNamesStart = "fieldNames='">
    <cfset fieldNamesStartPos = FindNoCase(fieldNamesStart,qWDDX)+Len(fieldNamesStart)>
    <cfset tmp1 = Right(qWDDX,Len(qWDDX)-fieldNamesStartPos)>
    <cfset fieldNamesStop = "'">
    <cfset fieldNamesLen = FindNoCase(fieldNamesStop,tmp1)>
    <cfset columnList = Mid(qWDDX,fieldNamesStartPos,fieldNamesLen)>
    <!--- Get the list of column names --->
    <cfset reportColumnArray = ListToArray(columnList)>
    <cfset columnCount = ListLen(columnList)>
    
    <cfscript>

       fileName = "#Replace(LCASE(ARGUMENTS.reportName), ' ', '-', 'ALL')#_#DateFormat(Now(), 'mm-dd-yyyy')#.xls";
       sheetName = LCASE(arguments.reportCFC);

       //Create spreadsheet object. --->
       sheet = SpreadsheetNew(sheetName);

       //Populate sheet object with a query. --->
       SpreadsheetAddRow(sheet,columnList,1,1);
       SpreadsheetAddRows(sheet, result);
        
    </cfscript>

    <cfheader name="content-disposition" value="inline; filename=#fileName#">
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sheet)#">
    </cfcase>
    <cfcase value="PDF">
    <!---Serialize the query to sort the columnlist as the functions SQL order.--->
    <cfwddx action="CFML2WDDX" input="#result#" output="qWDDX">
    <cfset fieldNamesStart = "fieldNames='">
    <cfset fieldNamesStartPos = FindNoCase(fieldNamesStart,qWDDX)+Len(fieldNamesStart)>
    <cfset tmp1 = Right(qWDDX,Len(qWDDX)-fieldNamesStartPos)>
    <cfset fieldNamesStop = "'">
    <cfset fieldNamesLen = FindNoCase(fieldNamesStop,tmp1)>
    <cfset columnList = Mid(qWDDX,fieldNamesStartPos,fieldNamesLen)>
    <!--- Get the list of column names --->
    <cfset reportColumnArray = ListToArray(columnList)>
    <cfset columnCount = ListLen(columnList)>
    <cfdocument format="pdf" unit="in" orientation="portrait" pagetype="letter">
    <table cols="#columnCount#" border="1">
    <tr>
    <cfloop array="#reportColumnArray#" index="column">
    <th><cfoutput>#column#</cfoutput></th>
    </cfloop>
    </tr>
    <cfoutput query="result">
    <tr>
    <cfloop array="#reportColumnArray#" index="column">
    <cfset columnValue = "result." & column>
    <td>#Evaluate(XMLFormat(columnValue))#</td>
    </cfloop>
    </tr>
    </cfoutput>
    </table>
    </cfdocument>
    </cfcase>
    <cfcase value="WORD">
    <!---Serialize the query to sort the columnlist as the functions SQL order.--->
    <cfwddx action="CFML2WDDX" input="#result#" output="qWDDX">
    <cfset fieldNamesStart = "fieldNames='">
    <cfset fieldNamesStartPos = FindNoCase(fieldNamesStart,qWDDX)+Len(fieldNamesStart)>
    <cfset tmp1 = Right(qWDDX,Len(qWDDX)-fieldNamesStartPos)>
    <cfset fieldNamesStop = "'">
    <cfset fieldNamesLen = FindNoCase(fieldNamesStop,tmp1)>
    <cfset columnList = Mid(qWDDX,fieldNamesStartPos,fieldNamesLen)>
    <!--- Get the list of column names --->
    <cfset reportColumnArray = ListToArray(columnList)>
    <cfset columnCount = ListLen(columnList)>
    <cfcontent type="application/vnd.ms-word">
    <cfheader name="content-disposition" value="inline;filename=#LCASE(ARGUMENTS.reportCFC)#_#DateFormat(Now(), application.dateFormat)#.doc">
    <table cols="#columnCount#" border="1">
    <tr>
    <cfloop array="#reportColumnArray#" index="column">
    <th><cfoutput>#column#</cfoutput></th>
    </cfloop>
    </tr>
    <cfoutput query="result">
    <tr>
    <cfloop array="#reportColumnArray#" index="column">
    <cfset columnValue = "result." & column>
    <td>#Evaluate(XMLFormat(columnValue))#</td>
    </cfloop>
    </tr>
    </cfoutput>
    </table>
    </cfcase>
    <cfdefaultcase>
    No reports available or the setting are incorrect.
    </cfdefaultcase>
    </cfswitch>
    <!---
    <cfcatch type="any">
    <div id="mcmsMessage">
    <span class="glyphicon glyphicon-exclamation-sign"></span><br /><br />
    An error occurred. You may require to modify the modules Component and Report Query values. No reports available.<br /><br />
    <a href="javascript:window.close();">Close This Window</a>
    </div>
    </cfcatch>
    </cftry>
    --->
    </body>
    <cfabort>
    </cfsavecontent>
    <cfreturn reportFunctionResult>
    </cffunction>
    
    <cffunction name="insertAlert" access="public" returntype="struct">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="aName" type="string" required="yes">
    <cfargument name="aDescription" type="string" required="yes">
    <cfargument name="aDateRel" type="date" required="yes">
    <cfargument name="aDateExp" type="date" required="yes">
    <cfargument name="atID" type="numeric" required="yes">
    <cfargument name="aStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getAlert"
    returnvariable="getCheckAlertRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="aName" value="#ARGUMENTS.aName#"/>
    <cfinvokeargument name="atID" value="#ARGUMENTS.atID#"/>
    <cfinvokeargument name="aStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAlertRet.recordcount NEQ 0>
    <cfset result.message = "An alert already exists for site #ARGUMENTS.siteNo#, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_alert (siteNo,aName,aDescription,aDateRel,aDateExp,atID,aStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.atID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAlert" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="aName" type="string" required="yes">
    <cfargument name="aDescription" type="string" required="yes">
    <cfargument name="aDateRel" type="date" required="yes">
    <cfargument name="aDateExp" type="date" required="yes">
    <cfargument name="atID" type="numeric" required="yes">
    <cfargument name="aStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getAlert"
    returnvariable="getCheckAlertRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="aName" value="#ARGUMENTS.aName#"/>
    <cfinvokeargument name="atID" value="#ARGUMENTS.atID#"/>
    <cfinvokeargument name="aStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAlertRet.recordcount NEQ 0>
    <cfset result.message = "An alert already exists for site #ARGUMENTS.siteNo#, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_alert SET
    aName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aName#">,
    aDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aDescription#">,
    aDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateRel#">,
    aDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateExp#">,
    atID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.atID#">,
    aStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAlertList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_alert SET
    aStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAlert" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_alert
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertApplication" access="public" returntype="struct">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="appName" type="string" required="yes">
    <cfargument name="appNameAlt" type="string" required="yes">
    <cfargument name="appDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="appURL" type="string" required="yes">
    <cfargument name="apptID" type="numeric" required="yes">
    <cfargument name="appStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.appDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplication"
    returnvariable="getCheckApplicationRet">
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="appName" value="#ARGUMENTS.appName#"/>
    <cfinvokeargument name="appStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.appName# already exists for app. ID #ARGUMENTS.appID#, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.appDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_application (appID,appName,appNameAlt,appDescription,imgID,appURL,apptID,appStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appNameAlt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appURL#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.apptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertApplicationType" access="public" returntype="struct">
    <cfargument name="apptName" type="string" required="yes">
    <cfargument name="apptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationType"
    returnvariable="getCheckApplicationTypeRet">
    <cfinvokeargument name="apptName" value="#ARGUMENTS.apptName#"/>
    <cfinvokeargument name="apptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.apptName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_application_type (apptName,apptStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.apptName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.apptStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateApplication" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="appName" type="string" required="yes">
    <cfargument name="appNameAlt" type="string" required="yes">
    <cfargument name="appDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="appURL" type="string" required="yes">
    <cfargument name="apptID" type="numeric" required="yes">
    <cfargument name="appStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.appDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplication"
    returnvariable="getCheckApplicationRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="appName" value="#ARGUMENTS.appName#"/>
    <cfinvokeargument name="appStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.appName# already exists for app. ID #ARGUMENTS.appID#, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.appDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application SET
    appName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appName#">,
    appNameAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appNameAlt#">,
    appDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appDescription#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    appURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.appURL#">,
    apptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.apptID#">,
    appStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateApplicationType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="apptName" type="string" required="yes">
    <cfargument name="apptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationType"
    returnvariable="getCheckApplicationTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="apptName" value="#ARGUMENTS.apptName#"/>
    <cfinvokeargument name="apptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.apptName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application_type SET
    apptName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.apptName#">,
    apptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.apptStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateApplicationList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="appStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application SET
    appStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateApplicationTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="apptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application_type SET
    apptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.apptStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteApplication" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_application
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplication"
    returnvariable="getApplicationRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="appStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getApplicationRet.recordcount NEQ 0>
    <cfset appID = ValueList(getApplicationRet.appID)>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_menu_application_rel
    WHERE appID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#appID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_role_access
    WHERE appID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#appID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_application_global
    WHERE appID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#appID#">)
    </cfquery>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteApplicationType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_application_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplication"
    returnvariable="getApplicationRet">
    <cfinvokeargument name="apptID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="appStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getApplicationRet.recordcount NEQ 0>
    <cfset appID = ValueList(getApplicationRet.appID)>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_application
    WHERE appID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#appID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_menu_application_rel
    WHERE appID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#appID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_role_access
    WHERE appID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#appID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_application_global
    WHERE appID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#appID#">)
    </cfquery>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertGlobal" access="public" returntype="struct">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="agName" type="string" required="yes">
    <cfargument name="agDescription" type="string" required="yes">
    <cfargument name="agValue" type="string" required="yes">
    <cfargument name="agtID" type="numeric" required="yes">
    <cfargument name="agStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record. <br/>You must now perform an application reset. <a href='/#application.mcmsAppAdminPath#/?mcmsReset=true'>Click here</a>. <br/> You may want to perform a reset on other servers that use this global variable.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.agDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationGlobal"
    returnvariable="getCheckApplicationGlobalRet">
    <cfinvokeargument name="agName" value="#ARGUMENTS.agName#"/>
    <cfinvokeargument name="agStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationGlobalRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.agName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.agDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new name under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_application_global (appID,agName,agDescription,agValue,agtID,agStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertGlobalType" access="public" returntype="struct">
    <cfargument name="agtName" type="string" required="yes">
    <cfargument name="agtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationGlobalType"
    returnvariable="getCheckApplicationGlobalTypeRet">
    <cfinvokeargument name="agtName" value="#ARGUMENTS.agtName#"/>
    <cfinvokeargument name="agtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationGlobalTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.agtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_application_global_type (agtName,agtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agtName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agtStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateGlobal" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="agName" type="string" required="yes">
    <cfargument name="agDescription" type="string" required="yes">
    <cfargument name="agValue" type="string" required="yes">
    <cfargument name="agtID" type="numeric" required="yes">
    <cfargument name="agStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record. <br/>You must now perform an application reset. <a href='/#application.mcmsAppAdminPath#/?mcmsReset=true'>Click here</a>. <br/> You may want to perform a reset on other servers that use this global variable.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.agDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationGlobal"
    returnvariable="getCheckApplicationGlobalRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="agName" value="#ARGUMENTS.agName#"/>
    <cfinvokeargument name="agStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationGlobalRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.agName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.agDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new name under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application_global SET
    agName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agName#">,
    agDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agDescription#">,
    agValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agValue#">,
    agtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agtID#">,
    agStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateGlobalType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="agtName" type="string" required="yes">
    <cfargument name="agtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getApplicationGlobalType"
    returnvariable="getCheckApplicationGlobalTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="agtName" value="#ARGUMENTS.agtName#"/>
    <cfinvokeargument name="agtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckApplicationGlobalTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.agtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application_global_type SET
    agtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.agtName#">,
    agtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateGlobalList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="agStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application_global SET
    agStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateGlobalTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="agtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_application_global_type SET
    agtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.agtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteGlobal" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "RESTRICTED - You cannot delete these record(s).">
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteGlobalType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "RESTRICTED - You cannot delete these record(s).">
    <cfreturn result>
    </cffunction>      
</cfcomponent>