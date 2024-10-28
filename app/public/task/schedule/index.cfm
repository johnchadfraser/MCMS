<!---Task to deploy build.--->
<cfparam name="url.mcmsBuild" default="false">
<cfparam name="url.bmID" default="0">
<cfparam name="url.bmaID" default="0">
<cfparam name="url.userID" default="0">
<cfif url.mcmsBuild NEQ false>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="setBuild" 
returnvariable="result">
<cfinvokeargument name="bmID" value="#url.bmID#">
<cfinvokeargument name="bmaID" value="#url.bmaID#">
<cfinvokeargument name="bmDeployerNotes" value="The build was executed from the schedule.">
<cfinvokeargument name="userID" value="#url.userID#">
</cfinvoke>
<cfdump var="#result#">
<cfschedule action="pause" task="build_#url.bmID#"/>
</cfif>