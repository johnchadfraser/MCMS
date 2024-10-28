<!---Call report method.--->
<cfparam name="url.args" default="">
<cfparam name="url.mcmsCustom" default="false">
<cfif url.mcmsCustom EQ true>
<cfinvoke 
 component="MCMS.component.cms.Cms"
 method="getReportFunctionCustom"
 returnvariable="getReportFunctionRet">
	<cfinvokeargument name="reportType" value="#url.mcmsReportType#"/>
    <cfinvokeargument name="reportCFC" value="#url.mcmsReportCFC#"/>
    <cfinvokeargument name="reportFunction" value="#url.mcmsReportFunction#"/>
    <cfinvokeargument name="keywords" value="#url.keywords#"/>
    <cfinvokeargument name="args" value="#url.args#"/>
    <cfinvokeargument name="filePath" value="#url.filePath#"/>
    <cfinvokeargument name="fileName" value="#url.fileName#"/>
    <cfinvokeargument name="sheetName" value="#url.sheetName#"/>
    <cfinvokeargument name="sheetHeader" value="#url.sheetHeader#"/>
</cfinvoke>
<cfelse>
<cfinvoke 
 component="MCMS.component.cms.Cms"
 method="getReportFunction"
 returnvariable="getReportFunctionRet">
	<cfinvokeargument name="reportType" value="#url.mcmsReportType#"/>
    <cfinvokeargument name="reportCFC" value="#url.mcmsReportCFC#"/>
    <cfinvokeargument name="reportFunction" value="#url.mcmsReportFunction#"/>
    <cfinvokeargument name="keywords" value="#url.keywords#"/>
    <cfinvokeargument name="siteNo" value="#url.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#url.deptNo#"/>
    <cfinvokeargument name="args" value="#url.args#"/>
    <cfinvokeargument name="status" value="#url.status#"/>
</cfinvoke>
<cfoutput>#getReportQueryRet#</cfoutput>
</cfif>
