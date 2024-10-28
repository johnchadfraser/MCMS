<cfcomponent>
	<cffunction name="getMenu" access="public" returntype="any" hint="Get Menu data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="menuName" type="string" required="yes" default="">
    <cfargument name="mtID" type="string" required="yes" default="0">
    <cfargument name="mtStatus" type="string" required="no" default="1">
    <cfargument name="menuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="menuName">
    <cfset var rsMenu = "">
    <cftry>
    <cfquery name="rsMenu" datasource="#application.mcmsDSN#">
    SELECT * FROM v_menu WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(menuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(menuDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.menuName NEQ "">
    AND menuName = <cfqueryparam value="#ARGUMENTS.menuName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.mtID NEQ 0>
    AND mtID IN (<cfqueryparam value="#ARGUMENTS.mtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND mtStatus IN (<cfqueryparam value="#ARGUMENTS.mtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND menuStatus IN (<cfqueryparam value="#ARGUMENTS.menuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMenu = StructNew()>
    <cfset rsMenu.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMenu>
    </cffunction>
    
    <cffunction name="getMenuType" access="public" returntype="any" hint="Get Menu Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="mtName" type="string" required="yes" default="">
    <cfargument name="mtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="mtName">
    <cfset var rsMenuType = "">
    <cftry>
    <cfquery name="rsMenuType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_menu_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(mtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.mtName NEQ "">
    AND mtName = <cfqueryparam value="#ARGUMENTS.mtName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND mtStatus IN (<cfqueryparam value="#ARGUMENTS.mtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMenuType = StructNew()>
    <cfset rsMenuType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMenuType>
    </cffunction>
    
    <cffunction name="getMenuApplicationRel" access="public" returntype="any" hint="Get Menu Application Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="menuID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="string" required="yes" default="0">
    <cfargument name="marDateRel" type="string" required="yes" default="">
    <cfargument name="marDateExp" type="string" required="yes" default="">
    <cfargument name="menuName" type="string" required="yes" default="">
    <cfargument name="mtID" type="string" required="yes" default="0">
    <cfargument name="apptID" type="string" required="yes" default="0">
    <cfargument name="menuStatus" type="string" required="no" default="1">
    <cfargument name="appStatus" type="string" required="no" default="1">
    <cfargument name="marStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="menuName">
    <cfset var rsMenuApplicationRel = "">
    <cftry>
    <cfquery name="rsMenuApplicationRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_menu_application_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(menuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(appName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.menuID NEQ 0>
    AND menuID = <cfqueryparam value="#ARGUMENTS.menuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.appID NEQ 0>
    AND appID IN (<cfqueryparam value="#ARGUMENTS.appID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.marDateRel NEQ "">
    AND marDateRel <= <cfqueryparam value="#ARGUMENTS.marDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.marDateExp NEQ "">
    AND marDateExp >= <cfqueryparam value="#ARGUMENTS.marDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.menuName NEQ "">
    AND menuName = <cfqueryparam value="#ARGUMENTS.menuName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.mtID NEQ 0>
    AND mtID = <cfqueryparam value="#ARGUMENTS.mtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.apptID NEQ 0>
    AND apptID IN (<cfqueryparam value="#ARGUMENTS.apptID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND menuStatus IN (<cfqueryparam value="#ARGUMENTS.menuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND appStatus IN (<cfqueryparam value="#ARGUMENTS.appStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND marStatus IN (<cfqueryparam value="#ARGUMENTS.marStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMenuApplicationRel = StructNew()>
    <cfset rsMenuApplicationRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMenuApplicationRel>
    </cffunction>
    
    <cffunction name="getMenuReport" access="public" returntype="query" hint="Get Menu Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="menuName">
    <cfset var rsMenuReport = "" >
    <cftry>
    <cfquery name="rsMenuReport" datasource="#application.mcmsDSN#">
    SELECT menuName AS Name, TO_CHAR(menuDescription) AS Description, mtName AS Type, sName AS Status FROM v_menu WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(menuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(menuDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMenuReport = StructNew()>
    <cfset rsMenuReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMenuReport>
    </cffunction>
    
    <cffunction name="getMenuTypeReport" access="public" returntype="query" hint="Get Menu Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="mtName">
    <cfset var rsMenuTypeReport = "" >
    <cftry>
    <cfquery name="rsMenuTypeReport" datasource="#application.mcmsDSN#">
    SELECT mtName AS Name FROM tbl_menu_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(mtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMenuTypeReport = StructNew()>
    <cfset rsMenuTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMenuTypeReport>
    </cffunction>
    
    <cffunction name="getMenuApplicationRelReport" access="public" returntype="query" hint="Get Menu Application Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="menuName">
    <cfset var rsMenuApplicationRelReport = "" >
    <cftry>
    <cfquery name="rsMenuApplicationRelReport" datasource="#application.mcmsDSN#">
    SELECT appID AS APP_ID, menuName AS Name, appName AS Application_Name, appNameAlt AS Application_Name_Alt, appURL AS URL, sName AS Status FROM v_menu_application_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(menuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(appName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMenuApplicationRelReport = StructNew()>
    <cfset rsMenuApplicationRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMenuApplicationRelReport>
    </cffunction>
    
    <cffunction name="insertMenu" access="public" returntype="struct">
    <cfargument name="menuName" type="string" required="yes">
    <cfargument name="menuDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="mtID" type="numeric" required="yes">
    <cfargument name="menuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.menuDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="getMenu"
    returnvariable="getCheckMenuRet">
    <cfinvokeargument name="menuName" value="#ARGUMENTS.menuName#"/>
    <cfinvokeargument name="menuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMenuRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.menuName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.menuDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_menu (menuName,menuDescription,imgID,mtID,menuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.menuName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.menuDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.menuStatus#">
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
    
    <cffunction name="insertMenuType" access="public" returntype="struct">
    <cfargument name="mtName" type="string" required="yes">
    <cfargument name="mtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="getMenuType"
    returnvariable="getCheckMenuTypeRet">
    <cfinvokeargument name="mtName" value="#ARGUMENTS.mtName#"/>
    <cfinvokeargument name="mtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMenuTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.mtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_menu_type (mtName,mtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mtName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mtStatus#">
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
    
    <cffunction name="insertMenuApplicationRel" access="public" returntype="struct">
    <cfargument name="menuID" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="marDateRel" type="string" required="yes">
    <cfargument name="marDateExp" type="string" required="yes">
    <cfargument name="marTarget" type="string" required="yes">
    <cfargument name="marStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="getMenuApplicationRel"
    returnvariable="getCheckMenuApplicationRelRet">
    <cfinvokeargument name="menuID" value="#ARGUMENTS.menuID#"/>
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="marStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMenuApplicationRelRet.recordcount NEQ 0>
    <cfset result.message = "The menu and application configuration you have submitted already exists, please choose an alternate.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_menu_application_rel (menuID,appID,marDateRel,marDateExp,marTarget,marStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.menuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.marDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.marDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.marTarget#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.marStatus#">
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
    
    <cffunction name="updateMenu" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="menuName" type="string" required="yes">
    <cfargument name="menuDescription" type="string" required="yes">
    <cfargument name="imgID" type="string" required="yes">
    <cfargument name="mtID" type="numeric" required="yes">
    <cfargument name="menuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.menuDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="getMenu"
    returnvariable="getCheckMenuRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="menuName" value="#ARGUMENTS.menuName#"/>
    <cfinvokeargument name="menuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMenuRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.menuName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.menuDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_menu SET
    menuName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.menuName#">,
    menuDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.menuDescription#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgID#">,
    mtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mtID#">,
    menuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.menuStatus#">
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
    
    <cffunction name="updateMenuType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mtName" type="string" required="yes">
    <cfargument name="mtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="getMenuType"
    returnvariable="getCheckMenuTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="mtName" value="#ARGUMENTS.mtName#"/>
    <cfinvokeargument name="mtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMenuTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.mtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_menu_type SET
    mtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mtName#">,
    mtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mtStatus#">
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
    
    <cffunction name="updateMenuApplicationRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="menuID" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="marDateRel" type="string" required="yes">
    <cfargument name="marDateExp" type="string" required="yes">
    <cfargument name="marTarget" type="string" required="yes">
    <cfargument name="marStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="getMenuApplicationRel"
    returnvariable="getCheckMenuApplicationRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="menuID" value="#ARGUMENTS.menuID#"/>
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="marStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMenuApplicationRelRet.recordcount NEQ 0>
    <cfset result.message = "The menu and application configuration you have submitted already exists, please choose an alternate.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_menu_application_rel SET
    menuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.menuID#">,
    appID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    marDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.marDateRel#">,
    marDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.marDateExp#">,
    marTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.marTarget#">,
    marStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.marStatus#">
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
    
    <cffunction name="updateMenuList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="menuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_menu SET
    menuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.menuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMenuTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_menu_type SET
    mtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMenuApplicationRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="marStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_menu_application_rel SET
    marStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.marStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMenu" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_menu
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="deleteMenuApplicationRel"
    returnvariable="deleteMenuApplicationRelRet">
    <cfinvokeargument name="menuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMenuType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_menu_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.ID NEQ 0>
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="getMenu"
    returnvariable="getMenuRet">
    <cfinvokeargument name="mtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="menuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getMenuRet.recordcount NEQ 0>
    <cfset menuID = ValueList(getMenuRet.ID)>
    <cfinvoke 
    component="MCMS.component.cms.Menu"
    method="deleteMenu"
    returnvariable="deleteMenuRet">
    <cfinvokeargument name="ID" value="#menuID#"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMenuApplicationRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="menuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_menu_application_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR menuID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.menuID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>