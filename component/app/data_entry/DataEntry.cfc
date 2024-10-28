<cfcomponent>
    <cffunction name="getDataEntry" access="public" returntype="query" hint="Get Data Entry data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="deName" type="string" required="yes" default="">
    <cfargument name="detID" type="string" required="yes" default="0">
    <cfargument name="deStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deName">
    <cfset var rsDataEntry = "" >
    <cftry>
    <cfquery name="rsDataEntry" datasource="#application.mcmsDSN#">
    SELECT * FROM v_data_entry WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(deName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deName NEQ "">
    AND UPPER(deName) = <cfqueryparam value="#UCASE(ARGUMENTS.deName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.detID NEQ 0>
    AND detID = <cfqueryparam value="#ARGUMENTS.detID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND deStatus IN (<cfqueryparam value="#ARGUMENTS.deStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDataEntry = StructNew()>
    <cfset rsDataEntry.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDataEntry>
    </cffunction>
    
    <cffunction name="getDataEntryUserRoleRel" access="public" returntype="query" hint="Get Data Entry User Role Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="deName" type="string" required="yes" default="">
    <cfargument name="detID" type="string" required="yes" default="0">
    <cfargument name="deurrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deName">
    <cfset var rsDataEntryUserRoleRel = "" >
    <cftry>
    <cfquery name="rsDataEntryUserRoleRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_de_user_role_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(deName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deName NEQ "">
    AND UPPER(deName) = <cfqueryparam value="#UCASE(ARGUMENTS.deName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.detID NEQ 0>
    AND detID = <cfqueryparam value="#ARGUMENTS.detID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND deurrStatus IN (<cfqueryparam value="#ARGUMENTS.deurrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDataEntryUserRoleRel = StructNew()>
    <cfset rsDataEntryUserRoleRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDataEntryUserRoleRel>
    </cffunction>
    
    <cffunction name="getDataEntryType" access="public" returntype="query" hint="Get Data Entry Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="detStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="detName">
    <cfset var rsDataEntryType = "" >
    <cftry>
    <cfquery name="rsDataEntryType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_data_entry_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(detName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND detStatus IN (<cfqueryparam value="#ARGUMENTS.detStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDataEntryType = StructNew()>
    <cfset rsDataEntryType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDataEntryType>
    </cffunction>
    
    <cffunction name="getDataEntryReport" access="public" returntype="query" hint="Get Data Entry Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="deName">
    <cfset var rsDataEntryReport = "" >
    <cftry>
    <cfquery name="rsDataEntryReport" datasource="#application.mcmsDSN#">
    SELECT deName AS Name, deDescription AS Description, dePath AS Path, sName AS Status FROM v_data_entry WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(deName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDataEntryReport = StructNew()>
    <cfset rsDataEntryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDataEntryReport>
    </cffunction>
    
    <cffunction name="getDataEntryTypeReport" access="public" returntype="query" hint="Get DataEntry Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="detName">
    <cfset var rsDataEntryTypeReport = "" >
    <cftry>
    <cfquery name="rsDataEntryTypeReport" datasource="#application.mcmsDSN#">
    SELECT detName AS Name, detDescription AS Description, sName AS Status FROM v_data_entry_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(detName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDataEntryTypeReport = StructNew()>
    <cfset rsDataEntryTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDataEntryTypeReport>
    </cffunction>
    
    <cffunction name="insertDataEntry" access="public" returntype="struct">
    <cfargument name="deName" type="string" required="yes">
    <cfargument name="deDescription" type="string" required="yes">
    <cfargument name="dePath" type="string" required="yes">
    <cfargument name="deTarget" type="string" required="yes">
    <cfargument name="deDateRel" type="string" required="yes">
    <cfargument name="deDateExp" type="string" required="yes">
    <cfargument name="detID" type="numeric" required="yes">
    <cfargument name="deSort" type="numeric" required="yes">
    <cfargument name="deStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.deDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.data_entry.DataEntry"
    method="getDataEntry"
    returnvariable="getCheckDataEntryRet">
    <cfinvokeargument name="deName" value="#ARGUMENTS.deName#"/>
    <cfinvokeargument name="deStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDataEntryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.deName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.deDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_data_entry (deName,deDescription,dePath,deTarget,deDateRel,deDateExp,detID,deSort,deStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dePath#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deTarget#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.deDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.deDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.detID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deStatus#">
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
    
    <cffunction name="insertDataEntryType" access="public" returntype="struct">
    <cfargument name="detName" type="string" required="yes">
    <cfargument name="detDescription" type="string" required="yes">
    <cfargument name="detStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.detDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.data_entry.DataEntry"
    method="getDataEntryType"
    returnvariable="getCheckDataEntryTypeRet">
    <cfinvokeargument name="detName" value="#ARGUMENTS.detName#"/>
    <cfinvokeargument name="detStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDataEntryTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.detName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.detDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_data_entry_type (detName,detDescription,detStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.detName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.detDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.detStatus#">
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
    
    <cffunction name="updateDataEntry" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="deName" type="string" required="yes">
    <cfargument name="deDescription" type="string" required="yes">
    <cfargument name="dePath" type="string" required="yes">
    <cfargument name="deTarget" type="string" required="yes">
    <cfargument name="deDateRel" type="string" required="yes">
    <cfargument name="deDateExp" type="string" required="yes">
    <cfargument name="detID" type="numeric" required="yes">
    <cfargument name="deSort" type="numeric" required="yes">
    <cfargument name="deStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.deDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.data_entry.DataEntry"
    method="getDataEntry"
    returnvariable="getCheckDataEntryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deName" value="#ARGUMENTS.deName#"/>
    <cfinvokeargument name="deStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDataEntryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.deName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.deDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_data_entry SET
    deName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deName#">,
    deDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deDescription#">,
    dePath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dePath#">,
    deTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deTarget#">,
    deDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.deDateRel#">,
    deDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.deDateExp#">,
    detID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.detID#">,
    deSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deSort#">,
    deStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deStatus#">
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
    
    <cffunction name="updateDataEntryType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="detName" type="string" required="yes">
    <cfargument name="detDescription" type="string" required="yes">
    <cfargument name="detStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.detDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.data_entry.DataEntry"
    method="getDataEntryType"
    returnvariable="getCheckDataEntryTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="detName" value="#ARGUMENTS.detName#"/>
    <cfinvokeargument name="detStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDataEntryTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.detName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.detDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_data_entry_type SET
    detName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.detName#">,
    detDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.detDescription#">,
    detStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.detStatus#">
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
    
    <cffunction name="updateDataEntryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="deStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_data_entry SET
    deStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDataEntryTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="detStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_data_entry_type SET
    detStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.detStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDataEntry" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_data_entry
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteDataEntryType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_data_entry_type
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