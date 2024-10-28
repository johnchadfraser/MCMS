<cfsilent>
<!--- Header object. --->
<cfobject name="headerObj" component="MCMS.component.cms.Cms">
</cfsilent>
<!---Post HTML header.--->
<cfoutput>
#headerObj.setHTMLHeader('public', mcmsAppDetailObj.appName, mcmsAppDetailObj.appDescription)#
</cfoutput>
<!---Display contents of this application.--->
<cfinclude template="view/inc_index.cfm">