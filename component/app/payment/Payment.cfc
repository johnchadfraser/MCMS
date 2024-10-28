<cfcomponent>
    <cffunction name="getTemp" access="public" returntype="query" hint="Get Temp data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tempName" type="string" required="yes" default="">
    <cfargument name="ttID" type="string" required="yes" default="0">
    <cfargument name="tempStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tName">
    <cfset var rsTemp = "" >
    <cftry>
    <cfquery name="rsTemp" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_temp WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tempName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tempDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tempName NEQ "">
    AND UPPER(tempName) = <cfqueryparam value="#UCASE(ARGUMENTS.tempName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ttID NEQ 0>
    AND ttID = <cfqueryparam value="#ARGUMENTS.ttID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tempStatus IN (<cfqueryparam value="#ARGUMENTS.tempStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemp = StructNew()>
    <cfset rsTemp.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemp>
    </cffunction>
    
    <cffunction name="getTempType" access="public" returntype="query" hint="Get Temp Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ttName">
    <cfset var rsTempType = "" >
    <cftry>
    <cfquery name="rsTempType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_temp_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ttStatus IN (<cfqueryparam value="#ARGUMENTS.ttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTempType = StructNew()>
    <cfset rsTempType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTempType>
    </cffunction>
    
    <cffunction name="getTempReport" access="public" returntype="query" hint="Get Temp Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tempName">
    <cfset var rsTempReport = "" >
    <cftry>
    <cfquery name="rsTempReport" datasource="#application.mcmsDSN#">
    SELECT tempName, tempDescription FROM tbl_temp WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tempName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tempDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTempReport = StructNew()>
    <cfset rsTempReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTempReport>
    </cffunction>
    
    <cffunction name="getTempTypeReport" access="public" returntype="query" hint="Get Temp Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ttName">
    <cfset var rsTempTypeReport = "" >
    <cftry>
    <cfquery name="rsTempTypeReport" datasource="#application.mcmsDSN#">
    SELECT ttName FROM tbl_temp_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTempTypeReport = StructNew()>
    <cfset rsTempTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTempTypeReport>
    </cffunction>
    
    <cffunction name="insertTemp" access="public" returntype="struct">
    <cfargument name="tempName" type="string" required="yes">
    <cfargument name="tempDescription" type="string" required="yes">
    <cfargument name="tempFile" type="string" required="yes">
    <cfargument name="ttID" type="numeric" required="yes">
    <cfargument name="tempSort" type="numeric" required="yes">
    <cfargument name="tempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tempDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.temp"
    method="getTemp"
    returnvariable="getCheckTempRet">
    <cfinvokeargument name="tempName" value="#ARGUMENTS.tempName#"/>
    <cfinvokeargument name="tempStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTempRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tempName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tempDescription) GT 1500>
    <cfset result.message = "The description is longer than 1500 characters, please enter a new description under 1500 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_temp (tempName,tempDescription,tempFile,ttID,tempSort,tempStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tempName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tempDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tempFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tempSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tempStatus#">
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
    
    <cffunction name="updateTemp" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tempName" type="string" required="yes">
    <cfargument name="tempDescription" type="string" required="yes">
    <cfargument name="tempFile" type="string" required="yes">
    <cfargument name="ttID" type="numeric" required="yes">
    <cfargument name="tempSort" type="numeric" required="yes">
    <cfargument name="tempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tempDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.temp"
    method="getTemp"
    returnvariable="getCheckTempRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tempName" value="#ARGUMENTS.tempName#"/>
    <cfinvokeargument name="tempStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTempRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tempName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tempDescription) GT 1500>
    <cfset result.message = "The description is longer than 1500 characters, please enter a new description under 1500 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_temp SET
    tempName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tempName#">,
    tempDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tempDescription#">,
    tempFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tempFile#">,
    ttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ttID#">,
    tempSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tempSort#">,
    tempStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tempStatus#">
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
    
    <cffunction name="updateTempList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_temp SET
    tempStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tempStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTemp" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_temp
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