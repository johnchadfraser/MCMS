<cfcomponent>
    <cffunction name="getShipMethod" access="public" returntype="query" hint="Get Ship Method data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="smName" type="string" required="yes" default="">
    <cfargument name="smtID" type="string" required="yes" default="0">
    <cfargument name="smStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="smName">
    <cfset var rsShipMethod = "" >
    <cftry>
    <cfquery name="rsShipMethod" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ship_method WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(smName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(smDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.smName NEQ "">
    AND UPPER(smName) = <cfqueryparam value="#UCASE(ARGUMENTS.smName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.smtID NEQ 0>
    AND smtID = <cfqueryparam value="#ARGUMENTS.smtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND smStatus IN (<cfqueryparam value="#ARGUMENTS.smStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsShipMethod = StructNew()>
    <cfset rsShipMethod.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsShipMethod>
    </cffunction>
    
    <cffunction name="getShipMethodType" access="public" returntype="query" hint="Get Ship Method Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="smtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="smtName">
    <cfset var rsShipMethodType = "" >
    <cftry>
    <cfquery name="rsShipMethodType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ship_method_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(smtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND smtStatus IN (<cfqueryparam value="#ARGUMENTS.smtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsShipMethodType = StructNew()>
    <cfset rsShipMethodType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsShipMethodType>
    </cffunction>
    
    <cffunction name="getShipMethodReport" access="public" returntype="query" hint="Get Ship Method Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="smName">
    <cfset var rsShipMethodReport = "" >
    <cftry>
    <cfquery name="rsShipMethodReport" datasource="#application.mcmsDSN#">
    SELECT smName, smDescription, smCode, smtName AS Type, sortName AS Sort, sName AS Status FROM v_ship_method WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(smName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(smDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsShipMethodReport = StructNew()>
    <cfset rsShipMethodReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsShipMethodReport>
    </cffunction>
    
    <cffunction name="getShipMethodTypeReport" access="public" returntype="query" hint="Get Ship Method Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="smtName">
    <cfset var rsShipMethodTypeReport = "" >
    <cftry>
    <cfquery name="rsShipMethodTypeReport" datasource="#application.mcmsDSN#">
    SELECT smtName, smtDescription, sortName AS Sort, sName AS Status FROM v_ship_method_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(smtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsShipMethodTypeReport = StructNew()>
    <cfset rsShipMethodTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsShipMethodTypeReport>
    </cffunction>
    
    <cffunction name="insertShipMethod" access="public" returntype="struct">
    <cfargument name="smName" type="string" required="yes">
    <cfargument name="smDescription" type="string" required="yes">
    <cfargument name="smCode" type="string" required="yes">
    <cfargument name="smtID" type="numeric" required="yes">
    <cfargument name="smSort" type="numeric" required="yes">
    <cfargument name="smStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.smDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.temp"
    method="getShipMethod"
    returnvariable="getCheckShipMethodRet">
    <cfinvokeargument name="smName" value="#TRIM(ARGUMENTS.smName)#"/>
    <cfinvokeargument name="smStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckShipMethodRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.smName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.smDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ship_method (smName,smDescription,smCode,smtID,smSort,smStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.smName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.smDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.smCode)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smStatus#">
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
    
    <cffunction name="updateShipMethod" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="smName" type="string" required="yes">
    <cfargument name="smDescription" type="string" required="yes">
    <cfargument name="smCode" type="string" required="yes">
    <cfargument name="smtID" type="numeric" required="yes">
    <cfargument name="smSort" type="numeric" required="yes">
    <cfargument name="smStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.smDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.temp"
    method="getShipMethod"
    returnvariable="getCheckShipMethodRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="smName" value="#TRIM(ARGUMENTS.smName)#"/>
    <cfinvokeargument name="smStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckShipMethodRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.smName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.smDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ship_method SET
    smName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.smName)#">,
    smDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.smDescription)#">,
    smCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.smCode)#">,
    smtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smtID#">,
    smSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smSort#">,
    smStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smStatus#">
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
    
    <cffunction name="updateShipMethodList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="smStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ship_method SET
    smStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteShipMethod" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ship_method
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