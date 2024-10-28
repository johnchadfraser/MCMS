<cfcomponent>
    <cffunction name="getCustomerService" access="public" returntype="query" hint="Get Customer Service data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="excludeDeptNo" type="string" required="yes" default="0">
    <cfargument name="csName" type="string" required="yes" default="">
    <cfargument name="csDateExp" type="string" required="yes" default="">
    <cfargument name="userStatus" type="string" required="no" default="1">
    <cfargument name="csStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="csDate DESC">
    <cfargument name="cacheQueryTime" type="string" required="yes" default="0,0,0,0">
    <cfset var rsCustomerService = "" >
    <cftry>
    <cfquery name="rsCustomerService" datasource="#application.mcmsDSN#" cachedWithin="#CreateTimeSpan(ListGetAt(ARGUMENTS.cacheQueryTime,1),ListGetAt(ARGUMENTS.cacheQueryTime,2),ListGetAt(ARGUMENTS.cacheQueryTime,3),ListGetAt(ARGUMENTS.cacheQueryTime,4))#">
    SELECT * FROM v_customer_service WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(csName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(csDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.csName NEQ "">
    AND UPPER(csName) = <cfqueryparam value="#UCASE(ARGUMENTS.csName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.csDateExp NEQ "">
    AND csDateExp >= <cfqueryparam value="#ARGUMENTS.csDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeDeptNo NEQ 0>
    AND deptNo NOT IN (<cfqueryparam value="#ARGUMENTS.excludeDeptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND csStatus IN (<cfqueryparam value="#ARGUMENTS.csStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCustomerService = StructNew()>
    <cfset rsCustomerService.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCustomerService>
    </cffunction>
    
    <cffunction name="getCustomerServiceReport" access="public" returntype="query" hint="Get Customer Service Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="csName">
    <cfset var rsCustomerServiceReport = "" >
    <cftry>
    <cfquery name="rsCustomerServiceReport" datasource="#application.mcmsDSN#">
    SELECT csName AS Name, TO_CHAR(csDescription) AS Description, siteName AS Site, deptName AS Department, TO_CHAR(csDate, 'MM/DD/YYYY') AS Create_Date, TO_CHAR(csDateExp, 'MM/DD/YYYY') AS Exp_Date, userfName || ' ' || userlName as Username, sortName As Sort, sName AS Status FROM v_customer_service WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(csName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(csDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCustomerServiceReport = StructNew()>
    <cfset rsCustomerServiceReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCustomerServiceReport>
    </cffunction>
    
    <cffunction name="insertCustomerService" access="public" returntype="struct">
    <cfargument name="csName" type="string" required="yes">
    <cfargument name="csDescription" type="string" required="yes">
    <cfargument name="csDateExp" type="date" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="csSort" type="numeric" required="yes">
    <cfargument name="csStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.csDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.customer_service.CustomerService"
    method="getCustomerService"
    returnvariable="getCheckCustomerServiceRet">
    <cfinvokeargument name="csName" value="#ARGUMENTS.csName#"/>
    <cfinvokeargument name="csStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCustomerServiceRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.csName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_customer_service (csName,csDescription,csDateExp,siteNo,deptNo,userID,csSort,csStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.csName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.csDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.csDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csStatus#">
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
    
    <cffunction name="updateCustomerService" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="csName" type="string" required="yes">
    <cfargument name="csDescription" type="string" required="yes">
    <cfargument name="csDateExp" type="date" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="csSort" type="numeric" required="yes">
    <cfargument name="csStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.csDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.customer_service.CustomerService"
    method="getCustomerService"
    returnvariable="getCheckCustomerServiceRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="csName" value="#ARGUMENTS.csName#"/>
    <cfinvokeargument name="csStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCustomerServiceRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.csName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_customer_service SET
    csName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.csName#">,
    csDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.csDescription#">,
    csDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.csDateExp#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    csSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csSort#">,
		<cfif ARGUMENTS.uaID NEQ 101>
    csDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    csStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csStatus#">
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
    
    <cffunction name="updateCustomerServiceList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="csStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_customer_service SET
    csStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCustomerService" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_customer_service
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