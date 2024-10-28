<cfcomponent>
    <cffunction name="getPageContent" access="public" returntype="query" hint="Get Page Content data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pcName" type="string" required="yes" default="">
    <cfargument name="pcDateExp" type="string" required="yes" default="">
    <cfargument name="pcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pcName">
    <cfset var rsPageContent = "" >
    <cftry>
    <cfquery name="rsPageContent" datasource="#application.mcmsDSN#">
    SELECT * FROM v_page_content WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pcContent) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pcName NEQ "">
    AND UPPER(pcName) = <cfqueryparam value="#UCASE(ARGUMENTS.pcName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pcDateExp NEQ "">
    AND pcDateExp >= <cfqueryparam value="#ARGUMENTS.pcDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND pcStatus IN (<cfqueryparam value="#ARGUMENTS.pcStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageContent = StructNew()>
    <cfset rsPageContent.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageContent>
    </cffunction>
    
    <cffunction name="getPageContentRel" access="public" returntype="query" hint="Get Page Content Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pcID" type="numeric" required="yes" default="0">
    <cfargument name="dID" type="numeric" required="yes" default="0">
    <cfargument name="pcName" type="string" required="yes" default="">
    <cfargument name="pcDateRel" type="string" required="yes" default="">
    <cfargument name="pcDateExp" type="string" required="yes" default="">
    <cfargument name="pcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pcName">
    <cfset var rsPageContentRel = "" >
    <cftry>
    <cfquery name="rsPageContentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_page_content_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pcContent) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pcID NEQ 0>
    AND pcID = <cfqueryparam value="#ARGUMENTS.pcID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dID NEQ 0>
    AND dID = <cfqueryparam value="#ARGUMENTS.dID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pcName NEQ "">
    AND UPPER(pcName) = <cfqueryparam value="#UCASE(ARGUMENTS.pcName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pcDateRel NEQ "">
    AND pcDateExp <= <cfqueryparam value="#ARGUMENTS.pcDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pcDateExp NEQ "">
    AND pcDateExp >= <cfqueryparam value="#ARGUMENTS.pcDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND pcrStatus IN (<cfqueryparam value="#ARGUMENTS.pcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageContentRel = StructNew()>
    <cfset rsPageContentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageContentRel>
    </cffunction>
    
    <cffunction name="getPageContentCategoryRel" access="public" returntype="query" hint="Get Page Content Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pcID" type="numeric" required="yes" default="0">
    <cfargument name="catType" type="string" required="yes" default="" hint="To filter by category type (catID, scatID, etc..)">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfargument name="pcName" type="string" required="yes" default="">
    <cfargument name="pcDateRel" type="string" required="yes" default="">
    <cfargument name="pcDateExp" type="string" required="yes" default="">
    <cfargument name="pccrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pcName">
    <cfset var rsPageContentCategoryRel = "" >
    <cftry>
    <cfquery name="rsPageContentCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_page_content_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pcContent) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pcID NEQ 0>
    AND pcID = <cfqueryparam value="#ARGUMENTS.pcID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catType EQ 'catID'>
    AND catID <> <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND scatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND lcatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND slcatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catType EQ 'scatID'>
    AND catID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND scatID <> <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND lcatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND slcatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catType EQ 'lcatID'>
    AND catID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND scatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND lcatID <> <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND slcatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catType EQ 'slcatID'>
    AND catID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND scatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND lcatID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    AND slcatID <> <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID IN (<cfqueryparam value="#ARGUMENTS.catID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.scatID NEQ 0>
    AND scatID IN (<cfqueryparam value="#ARGUMENTS.scatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.lcatID NEQ 0>
    AND lcatID IN (<cfqueryparam value="#ARGUMENTS.lcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.slcatID NEQ 0>
    AND slcatID IN (<cfqueryparam value="#ARGUMENTS.slcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pcName NEQ "">
    AND UPPER(pcName) = <cfqueryparam value="#UCASE(ARGUMENTS.pcName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pcDateRel NEQ "">
    AND pcDateExp <= <cfqueryparam value="#ARGUMENTS.pcDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pcDateExp NEQ "">
    AND pcDateExp >= <cfqueryparam value="#ARGUMENTS.pcDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND pccrStatus IN (<cfqueryparam value="#ARGUMENTS.pccrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageContentCategoryRel = StructNew()>
    <cfset rsPageContentCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageContentCategoryRel>
    </cffunction>
    
    <cffunction name="getPage" access="public" returntype="query" hint="Get Page data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="pPath" type="string" required="yes" default="">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsPage = "" >
    <cftry>
    <cfquery name="rsPage" datasource="#application.mcmsDSN#">
    SELECT * FROM v_page WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPage = StructNew()>
    <cfset rsPage.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPage>
    </cffunction>
    
    <cffunction name="getPageContentType" access="public" returntype="query" hint="Get Page data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pctName" type="string" required="yes" default="">
    <cfargument name="pctStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pctName">
    <cfset var rsPageContentType = "" >
    <cftry>
    <cfquery name="rsPageContentType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_page_content_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pctName NEQ "">
    AND UPPER(pctName) = <cfqueryparam value="#UCASE(ARGUMENTS.pctName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pctStatus IN (<cfqueryparam value="#ARGUMENTS.pctStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageContentType = StructNew()>
    <cfset rsPageContentType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageContentType>
    </cffunction>
    
    <cffunction name="getPageContentReport" access="public" returntype="query" hint="Get Page Content Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pcName">
    <cfset var rsPageContentReport = "" >
    <cftry>
    <cfquery name="rsPageContentReport" datasource="#application.mcmsDSN#">
    SELECT pcName AS Name, TO_CHAR(pcContent) AS Content, TO_CHAR(pcDate, 'MM/DD/YYYY') AS Create_Date, TO_CHAR(pcDateExp, 'MM/DD/YYYY') AS Expire_Date, sName AS Status FROM v_page_content WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageContentReport = StructNew()>
    <cfset rsPageContentReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageContentReport>
    </cffunction>
    
    <cffunction name="getPageReport" access="public" returntype="query" hint="Get Page Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsPageReport = "" >
    <cftry>
    <cfquery name="rsPageReport" datasource="#application.mcmsDSN#">
    SELECT pName AS Name, pPath AS Path, dName AS Domain, sName AS Status FROM v_page WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageReport = StructNew()>
    <cfset rsPageReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageReport>
    </cffunction>
    
    <cffunction name="getPageContentTypeReport" access="public" returntype="query" hint="Get Page Content Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pctName">
    <cfset var rsPageContentTypeReport = "" >
    <cftry>
    <cfquery name="rsPageContentTypeReport" datasource="#application.mcmsDSN#">
    SELECT pctName AS Name, sName AS Status FROM v_page_content_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageContentTypeReport = StructNew()>
    <cfset rsPageContentTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageContentTypeReport>
    </cffunction>
    
    <cffunction name="insertPageContent" access="public" returntype="struct">
    <cfargument name="pcName" type="string" required="yes">
    <cfargument name="pcContent" type="string" required="yes">
	<cfargument name="pcDateRel" type="string" required="yes">
    <cfargument name="pcDateExp" type="string" required="yes">
    <cfargument name="pctID" type="numeric" required="yes">
    <cfargument name="pID" type="string" required="yes">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfargument name="pcSort" type="numeric" required="yes">
    <cfargument name="pcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record. Please wait while Preview is created.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_content (pcName,pcContent,pcDate,pcDateRel,pcDateExp,pctID,userID,pcSort,pcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pcName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(ARGUMENTS.pcContent)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pcDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pcDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pctID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcStatus#">
    )
    </cfquery>
    <!---Get the pcID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_page_content"/>
    </cfinvoke>
    <cfset this.pcID = getMaxValueSQLRet>
    <cfloop index="pageID" from="1" to="#ListLen(ARGUMENTS.pID)#">
    <!---Insert page relationships.--->
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentRel">
    <cfinvokeargument name="pcID" value="#this.pcID#"/>
    <cfinvokeargument name="pID" value="#ListGetAt(ARGUMENTS.pID, pageID)#"/>
    <cfinvokeargument name="pcrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert category relationships.--->
    <cfif ARGUMENTS.catID NEQ 0>
    <cfloop index="categoryID" from="1" to="#ListLen(ARGUMENTS.catID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#this.pcID#"/>
    <cfinvokeargument name="catID" value="#ListGetAt(ARGUMENTS.catID, categoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert secondary category relationships.--->
    <cfif ARGUMENTS.scatID NEQ 0>
    <cfloop index="secCategoryID" from="1" to="#ListLen(ARGUMENTS.scatID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#this.pcID#"/>
    <cfinvokeargument name="scatID" value="#ListGetAt(ARGUMENTS.scatID, secCategoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert line category relationships.--->
    <cfif ARGUMENTS.lcatID NEQ 0>
    <cfloop index="lineCategoryID" from="1" to="#ListLen(ARGUMENTS.lcatID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#this.pcID#"/>
    <cfinvokeargument name="lcatID" value="#ListGetAt(ARGUMENTS.lcatID, lineCategoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert secondary line category relationships.--->
    <cfif ARGUMENTS.slcatID NEQ 0>
    <cfloop index="secLineCategoryID" from="1" to="#ListLen(ARGUMENTS.slcatID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#this.pcID#"/>
    <cfinvokeargument name="slcatID" value="#ListGetAt(ARGUMENTS.slcatID, secLineCategoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cftransaction>
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {
    lAjax('layoutIndex', #url.appID#, 'PageContent' ,'/#application.mcmsAppAdminPath#/page_content/view/inc_page_content.cfm','Content','update', #this.pcID#);
	}")>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPage" access="public" returntype="struct">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="pPath" type="string" required="yes">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="getPage"
    returnvariable="getCheckPageRet">
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="dID" value="#ARGUMENTS.dID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageRet.recordcount NEQ 0>
    <cfset result.message = "The page already exists for this domain, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page (pName,pPath,dID,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pPath#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
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
    
    <cffunction name="insertPageContentType" access="public" returntype="struct">
    <cfargument name="pctName" type="string" required="yes">
    <cfargument name="pctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="getPageContentType"
    returnvariable="getCheckPageContentTypeRet">
    <cfinvokeargument name="pctName" value="#ARGUMENTS.pctName#"/>
    <cfinvokeargument name="pctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageContentTypeRet.recordcount NEQ 0>
    <cfset result.message = "The page content type already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_content_type (pctName,pctStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pctName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pctStatus#">
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
    
    <cffunction name="insertPageContentRel" access="public" returntype="struct">
    <cfargument name="pcID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_content_rel (pcID,pID,pcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPageContentCategoryRel" access="public" returntype="struct">
    <cfargument name="pcID" type="numeric" required="yes">
    <cfargument name="catID" type="numeric" required="yes" default="0">
    <cfargument name="scatID" type="numeric" required="yes" default="0">
    <cfargument name="lcatID" type="numeric" required="yes" default="0">
    <cfargument name="slcatID" type="numeric" required="yes" default="0">
    <cfargument name="pccrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_content_category_rel (pcID,catID,scatID,lcatID,slcatID,pccrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pccrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePageContent" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pcName" type="string" required="yes">
    <cfargument name="pcContent" type="string" required="yes">
	<cfargument name="pcDateRel" type="string" required="yes">
    <cfargument name="pcDateExp" type="string" required="yes">
    <cfargument name="pctID" type="numeric" required="yes">
    <cfargument name="pID" type="string" required="yes">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfargument name="pcSort" type="numeric" required="yes">
    <cfargument name="pcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_content SET
    pcName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pcName)#">,
    pcContent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(Replace(ARGUMENTS.pcContent, 'InvalidTag', 'script', 'ALL'))#">,
    pcDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pcDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pcDateRel#">,
    pcDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pcDateExp#">,
    pctID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pctID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    pcSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcSort#">,
    pcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete current relationships.--->
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="deletePageContentRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="deletePageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfloop index="pageID" from="1" to="#ListLen(ARGUMENTS.pID)#">
    <!---Insert page relationships.--->
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pID" value="#ListGetAt(ARGUMENTS.pID, pageID)#"/>
    <cfinvokeargument name="pcrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert category relationships.--->
    <cfif ARGUMENTS.catID NEQ 0>
    <cfloop index="categoryID" from="1" to="#ListLen(ARGUMENTS.catID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="catID" value="#ListGetAt(ARGUMENTS.catID, categoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert secondary category relationships.--->
    <cfif ARGUMENTS.scatID NEQ 0>
    <cfloop index="secCategoryID" from="1" to="#ListLen(ARGUMENTS.scatID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="scatID" value="#ListGetAt(ARGUMENTS.scatID, secCategoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert line category relationships.--->
    <cfif ARGUMENTS.lcatID NEQ 0>
    <cfloop index="lineCategoryID" from="1" to="#ListLen(ARGUMENTS.lcatID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="lcatID" value="#ListGetAt(ARGUMENTS.lcatID, lineCategoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert secondary line category relationships.--->
    <cfif ARGUMENTS.slcatID NEQ 0>
    <cfloop index="secLineCategoryID" from="1" to="#ListLen(ARGUMENTS.slcatID)#">
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="insertPageContentCategoryRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="slcatID" value="#ListGetAt(ARGUMENTS.slcatID, secLineCategoryID)#"/>
    <cfinvokeargument name="pccrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pName" type="string" required="yes">
	<cfargument name="pPath" type="string" required="yes">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="getPage"
    returnvariable="getCheckPageRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="dID" value="#ARGUMENTS.dID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageRet.recordcount NEQ 0>
    <cfset result.message = "The page already exists for this domain, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page SET
    pName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pName#">,
    pPath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pPath#">,
    dID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
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
    
    <cffunction name="updatePageContentType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pctName" type="string" required="yes">
    <cfargument name="pctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="getPageContentType"
    returnvariable="getCheckPageContentTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pctName" value="#ARGUMENTS.pctName#"/>
    <cfinvokeargument name="pctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageContentTypeRet.recordcount NEQ 0>
    <cfset result.message = "The page content type already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_content_type SET
    pctName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pctName#">,
    pctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pctStatus#">
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
    
    <cffunction name="updatePageContentList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_content SET
    pcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePageList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page SET
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePageContentTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_content_type SET
    pctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pctStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePageContent" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_content
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="deletePageContentRel">
    <cfinvokeargument name="pcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.page_content.PageContent"
    method="deletePageContentRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePageContentType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_content_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePageContentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pcID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_content_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pcID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePageContentCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pcID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_content_category_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pcID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcID#">)
    OR catID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">)
    OR scatID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">)
    OR lcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatID#">)
    OR slcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>    
</cfcomponent>