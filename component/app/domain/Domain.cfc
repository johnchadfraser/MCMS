<cfcomponent>
    <cffunction name="getDomain" access="public" returntype="query" hint="Get Domain data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dName" type="string" required="yes" default="">
    <cfargument name="dDateExp" type="string" required="yes" default="">
    <cfargument name="dStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dName">
    <cfset var rsDomain = "" >
    <cftry>
    <cfquery name="rsDomain" datasource="#application.mcmsDSN#">
    SELECT * FROM v_domain WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.dName NEQ "">
    AND UPPER(dName) = <cfqueryparam value="#UCASE(ARGUMENTS.dName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dDateExp NEQ "">
    AND dDateExp >= <cfqueryparam value="#ARGUMENTS.dDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND dStatus IN (<cfqueryparam value="#ARGUMENTS.dStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDomain = StructNew()>
    <cfset rsDomain.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDomain>
    </cffunction>
    
    <cffunction name="getDomainReport" access="public" returntype="query" hint="Get Domain Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="dName">
    <cfset var rsDomainReport = "" >
    <cftry>
    <cfquery name="rsDomainReport" datasource="#application.mcmsDSN#">
    SELECT dName AS Name, TO_CHAR(dDescription) AS Description, dURL AS URL, TO_CHAR(dDate, 'MM/DD/YYYY') AS Create_Date, TO_CHAR(dDateExp, 'MM/DD/YYYY') AS Expire_Date, sName AS Status FROM v_domain WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDomainReport = StructNew()>
    <cfset rsDomainReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDomainReport>
    </cffunction>
    
    <cffunction name="insertDomain" access="public" returntype="struct">
    <cfargument name="dName" type="string" required="yes">
    <cfargument name="dDescription" type="string" required="yes">
    <cfargument name="dURL" type="string" required="yes">
    <cfargument name="dDateExp" type="string" required="yes">
    <cfargument name="dStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.domain.Domain"
    method="getDomain"
    returnvariable="getCheckDomainRet">
    <cfinvokeargument name="dName" value="#ARGUMENTS.dName#"/>
    <cfinvokeargument name="dStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDomainRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.dName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_domain (dName,dDescription,dURL,dDateExp,dStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dURL#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.dDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dStatus#">
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
    
    <cffunction name="updateDomain" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dName" type="string" required="yes">
    <cfargument name="dDescription" type="string" required="yes">
    <cfargument name="dURL" type="string" required="yes">
    <cfargument name="dDateExp" type="numeric" required="yes">
    <cfargument name="dStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.domain.Domain"
    method="getDomain"
    returnvariable="getCheckDomainRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="dName" value="#ARGUMENTS.dName#"/>
    <cfinvokeargument name="dStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDomainRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.dName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_domain SET
    dName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dName#">,
    dDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dDescription#">,
    dURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dURL#">,
    dDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.dDateExp#">,
    dStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dStatus#">
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
    
    <cffunction name="updateDomainList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_domain SET
    dStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDomain" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_domain
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