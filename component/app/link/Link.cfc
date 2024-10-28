<cfcomponent>
    <cffunction name="getLink" access="public" returntype="query" hint="Get Link data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="lName" type="string" required="yes" default="">
    <cfargument name="netID" type="numeric" required="yes" default="0">
    <cfargument name="ltID" type="string" required="yes" default="">
    <cfargument name="lStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lSort, lName">
    <cfset var rsLink = "" >
    <cftry>
    <cfquery name="rsLink" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM v_link WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">) OR 
    (UPPER(lUrl) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.lName NEQ "">
    AND UPPER(lName) = <cfqueryparam value="#UCASE(ARGUMENTS.lName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ltID NEQ ''>
    AND ltID IN (<cfqueryparam value="#ARGUMENTS.ltID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="0,#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND lStatus IN (<cfqueryparam value="#ARGUMENTS.lStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLink = StructNew()>
    <cfset rsLink.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLink>
    </cffunction>
    
    <cffunction name="getLinkSiteRel" access="public" returntype="query" hint="Get Link Site Rel data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="lID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="lName" type="string" required="yes" default="">
    <cfargument name="lDateExp" type="string" required="yes" default="">
    <cfargument name="netID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ltID" type="string" required="yes" default="0">
    <cfargument name="lStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lSort, lName">
    <cfset var rsLinkSiteRel = "" >
    <cftry>
    <cfquery name="rsLinkSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_link_site_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.lID NEQ 0>
    AND lID = <cfqueryparam value="#ARGUMENTS.lID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.lName NEQ "">
    AND UPPER(lName) = <cfqueryparam value="#UCASE(ARGUMENTS.lName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.lDateExp NEQ "">
    AND lDateExp >= <cfqueryparam value="#ARGUMENTS.lDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ltID NEQ 0>
    AND ltID = <cfqueryparam value="#ARGUMENTS.ltID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="0,#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND lStatus IN (<cfqueryparam value="#ARGUMENTS.lStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLinkSiteRel = StructNew()>
    <cfset rsLinkSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLinkSiteRel>
    </cffunction>
    
    <cffunction name="getLinkDepartmentRel" access="public" returntype="query" hint="Get Link Department Rel data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="lID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="lName" type="string" required="yes" default="">
    <cfargument name="lDateExp" type="string" required="yes" default="">
    <cfargument name="netID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ltID" type="string" required="yes" default="0">
    <cfargument name="lStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lSort, lName">
    <cfset var rsLinkDepartmentRel = "" >
    <cftry>
    <cfquery name="rsLinkDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_link_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.lID NEQ 0>
    AND lID = <cfqueryparam value="#ARGUMENTS.lID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.lName NEQ "">
    AND UPPER(lName) = <cfqueryparam value="#UCASE(ARGUMENTS.lName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.lDateExp NEQ "">
    AND lDateExp >= <cfqueryparam value="#ARGUMENTS.lDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ltID NEQ 0>
    AND ltID = <cfqueryparam value="#ARGUMENTS.ltID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="0,#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND lStatus IN (<cfqueryparam value="#ARGUMENTS.lStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLinkDepartmentRel = StructNew()>
    <cfset rsLinkDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLinkDepartmentRel>
    </cffunction>
    
    <cffunction name="getLinkSiteDepartmentRel" access="public" returntype="query" hint="Get Link Site/Department Rel data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="lName" type="string" required="yes" default="">
    <cfargument name="lDateExp" type="string" required="yes" default="">
    <cfargument name="netID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="">
    <cfargument name="saStateProv" type="string" required="yes" default="">
    <cfargument name="ltID" type="string" required="yes" default="0">
    <cfargument name="lStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lSort, lName">
    <cfset var rsLinkSiteDepartmentRel = "" >
    <cftry>
    <cfquery name="rsLinkSiteDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_link_site_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.lName NEQ "">
    AND UPPER(lName) = <cfqueryparam value="#UCASE(ARGUMENTS.lName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ ''>
    AND (siteNo IN (<cfqueryparam value="100,#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">))
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ ''>
    AND (deptNo IN (<cfqueryparam value="0,#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">))
    </cfif>
    <cfif ARGUMENTS.lDateExp NEQ "">
    AND lDateExp >= <cfqueryparam value="#ARGUMENTS.lDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ltID NEQ 0>
    AND ltID = <cfqueryparam value="#ARGUMENTS.ltID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="0,#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND lStatus IN (<cfqueryparam value="#ARGUMENTS.lStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLinkSiteDepartmentRel = StructNew()>
    <cfset rsLinkSiteDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLinkSiteDepartmentRel>
    </cffunction>

    <cffunction name="getLinkType" access="public" returntype="query" hint="Get Link Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ltStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ltName">
    <cfset var rsLinkType = "" >
    <cftry>
    <cfquery name="rsLinkType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_link_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ltName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ltStatus IN (<cfqueryparam value="#ARGUMENTS.ltStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLinkType = StructNew()>
    <cfset rsLinkType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLinkType>
    </cffunction>    
    
    <cffunction name="getLinkReport" access="public" returntype="query" hint="Get Link Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="lName">
    <cfset var rsLinkReport = "" >
    <cftry>
    <cfquery name="rsLinkReport" datasource="#application.mcmsDSN#">
    SELECT lName AS Name, lURL AS URL, netDomain AS Domain, ltName AS Type, sName AS Status FROM v_link WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lUrl) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLinkReport = StructNew()>
    <cfset rsLinkReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLinkReport>
    </cffunction>
    
    <cffunction name="getLinkTypeReport" access="public" returntype="query" hint="Get Link Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ltName">
    <cfset var rsLinkTypeReport = "" >
    <cftry>
    <cfquery name="rsLinkTypeReport" datasource="#application.mcmsDSN#">
    SELECT ltName AS Name, ltDescription AS Description, ltStatus AS Status FROM tbl_link_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ltName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLinkTypeReport = StructNew()>
    <cfset rsLinkTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLinkTypeReport>
    </cffunction>
    
    <cffunction name="insertLink" access="public" returntype="struct">
    <cfargument name="lName" type="string" required="yes">
    <cfargument name="lURL" type="string" required="yes">
    <cfargument name="lTarget" type="string" required="yes">
    <cfargument name="lDateExp" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="ltID" type="numeric" required="yes">
    <cfargument name="lSort" type="numeric" required="yes">
    <cfargument name="lStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="getLink"
    returnvariable="getCheckLinkRet">
    <cfinvokeargument name="lName" value="#ARGUMENTS.lName#"/>
    <cfinvokeargument name="netID" value="#ARGUMENTS.netID#"/>
    <cfinvokeargument name="lStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckLinkRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.lName# already exists for this network, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.lURL) GT 512>
    <cfset result.message = "The URL is longer than 512 characters, please enter a new URL under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_link (lName,lURL,lTarget,lDateExp,imgID,netID,ltID,lSort,lStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lTarget#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.lDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ltID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted link ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="lID">
    <cfinvokeargument name="tableName" value="tbl_link"/>
    </cfinvoke>
    <cfset var.lID = lID>
    <!---Create site relationships.--->
    <cfloop index="siteNoList" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="insertLinkSiteRel"
    returnvariable="insertLinkSiteRelRet">
    <cfinvokeargument name="lID" value="#var.lID#"/>
    <cfinvokeargument name="siteNo" value="#siteNoList#"/>
    <cfinvokeargument name="lsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNoList" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="insertLinkDepartmentRel"
    returnvariable="insertLinkDepartmentRelRet">
    <cfinvokeargument name="lID" value="#var.lID#"/>
    <cfinvokeargument name="deptNo" value="#deptNoList#"/>
    <cfinvokeargument name="ldrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertLinkSiteRel" access="public" returntype="struct">
    <cfargument name="lID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="lsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_link_site_rel (lID,siteNo,lsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lsrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertLinkDepartmentRel" access="public" returntype="struct">
    <cfargument name="lID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ldrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_link_department_rel (lID,deptNo,ldrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ldrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertLinkType" access="public" returntype="struct">
    <cfargument name="ltName" type="string" required="yes">
    <cfargument name="ltDescription" type="string" required="yes">
    <cfargument name="ltStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="getLinkType"
    returnvariable="getCheckLinkTypeRet">
    <cfinvokeargument name="ltName" value="#ARGUMENTS.ltName#"/>
    <cfinvokeargument name="ltStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckLinkTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ltName# already exists, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ltDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_link_type (ltName,ltDescription,ltStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ltName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ltDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ltStatus#">
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
    
    <cffunction name="updateLink" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="lName" type="string" required="yes">
    <cfargument name="lURL" type="string" required="yes">
    <cfargument name="lTarget" type="string" required="yes">
    <cfargument name="lDateExp" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="ltID" type="numeric" required="yes">
    <cfargument name="lSort" type="numeric" required="yes">
    <cfargument name="lStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="getLink"
    returnvariable="getCheckLinkRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="lName" value="#ARGUMENTS.lName#"/>
    <cfinvokeargument name="netID" value="#ARGUMENTS.netID#"/>
    <cfinvokeargument name="lStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckLinkRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.lName# already exists for this network, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.lURL) GT 512>
    <cfset result.message = "The URL is longer than 512 characters, please enter a new URL under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_link SET
    lName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lName#">,
    lURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lURL#">,
    lTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lTarget#">,
    lDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.lDateExp#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    ltID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ltID#">,
    lSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lSort#">,
    lStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="deleteLinkSiteRel"
    returnvariable="deleteLinkSiteRelRet">
    <cfinvokeargument name="lID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="deleteLinkDepartmentRel"
    returnvariable="deleteLinkDepartmentRelRet">
    <cfinvokeargument name="lID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNoList" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="insertLinkSiteRel"
    returnvariable="insertLinkSiteRelRet">
    <cfinvokeargument name="lID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNoList#"/>
    <cfinvokeargument name="lsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNoList" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="insertLinkDepartmentRel"
    returnvariable="insertLinkDepartmentRelRet">
    <cfinvokeargument name="lID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNoList#"/>
    <cfinvokeargument name="ldrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateLinkType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ltName" type="string" required="yes">
    <cfargument name="ltDescription" type="string" required="yes">
    <cfargument name="ltStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="getLinkType"
    returnvariable="getCheckLinkTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ltName" value="#ARGUMENTS.ltName#"/>
    <cfinvokeargument name="ltStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckLinkTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ltName# already exists, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ltDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_link_type SET
    ltName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ltName#">,
    ltDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ltDescription#">,
    ltStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ltStatus#">
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
    
    <cffunction name="updateLinkList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="lStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_link SET
    lStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateLinkTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ltStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_link_type SET
    ltStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ltStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteLink" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_link
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="deleteLinkSiteRel"
    returnvariable="deleteLinkSiteRelRet">
    <cfinvokeargument name="lID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.link.Link"
    method="deleteLinkDepartmentRel"
    returnvariable="deleteLinkDepartmentRelRet">
    <cfinvokeargument name="lID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteLinkSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="lID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_link_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR lID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteLinkDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="lID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_link_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR lID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteLinkType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_link_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>    
</cfcomponent>