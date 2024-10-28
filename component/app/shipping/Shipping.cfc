<cfcomponent>
    <cffunction name="getShipRestriction" access="public" returntype="query" hint="Get Ship Restriction data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="srID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="restriction_id">
    <cfset var rsShipRestriction = "" >
    <cftry>
    <cfquery name="rsShipRestriction" datasource="#application.mcmsDSN#">
    SELECT * FROM to_atg.restriction_code WHERE 0=0
    <cfif ARGUMENTS.srID NEQ 0>
    AND restriction_id = <cfqueryparam value="#ARGUMENTS.srID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND restriction_id <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(restriction_id) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsShipRestriction = StructNew()>
    <cfset rsShipRestriction.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsShipRestriction>
    </cffunction>
    
    <cffunction name="getShipRestrictionReport" access="public" returntype="query" hint="Get Ship Restriction Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="restriction_id">
    <cfset var rsShipRestrictionReport = "" >
    <cftry>
    <cfquery name="rsShipRestrictionReport" datasource="#application.mcmsDSN#">
    SELECT restriction_id AS Restriction_ID, description AS Description, stateprov AS StateProv, county AS County, zipcode AS Zip_Code, TO_CHAR(sw_last_updated,'MM/DD/YYYY') AS Date_Updated, sw_update_user AS Username FROM to_atg.restriction_code WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(restriction_id) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsShipRestrictionReport = StructNew()>
    <cfset rsShipRestrictionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsShipRestrictionReport>
    </cffunction>
    
    <cffunction name="insertShipRestriction" access="public" returntype="struct">
    <cfargument name="srID" type="string" required="yes">
    <cfargument name="srDescription" type="string" required="yes">
    <cfargument name="srStateProv" type="string" required="yes">
	<cfargument name="srCounty" type="string" required="yes">
    <cfargument name="srZipCode" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.srDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.shipping.Shipping"
    method="getShipRestriction"
    returnvariable="getCheckShipRestrictionRet">
    <cfinvokeargument name="srID" value="#TRIM(ARGUMENTS.srID)#"/>
    </cfinvoke>
    <cfif getCheckShipRestrictionRet.recordcount NEQ 0>
    <cfset result.message = "The restriction ID #TRIM(ARGUMENTS.srID)# already exists, please enter a new restriction ID.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.srDescription) GT 4000>
    <cfset result.message = "The description is longer than 4000 characters, please enter a new description under 4000 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO to_atg.restriction_code (restriction_id,description,stateprov,county,zipcode,sw_last_updated,sw_update_user) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srStateProv)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srCounty)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srZipCode)#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userName#">
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
    
    <cffunction name="updateShipRestriction" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="srID" type="string" required="yes">
    <cfargument name="srDescription" type="string" required="yes">
    <cfargument name="srStateProv" type="string" required="yes">
	<cfargument name="srCounty" type="string" required="yes">
    <cfargument name="srZipCode" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.srDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.shipping.Shipping"
    method="getShipRestriction"
    returnvariable="getCheckShipRestrictionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.srID#"/>
    <cfinvokeargument name="srID" value="#TRIM(ARGUMENTS.srID)#"/>
    </cfinvoke>
    <cfif getCheckShipRestrictionRet.recordcount NEQ 0>
    <cfset result.message = "The restriction ID #TRIM(ARGUMENTS.srID)# already exists, please enter a new restriction ID.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.srDescription) GT 4000>
    <cfset result.message = "The description is longer than 4000 characters, please enter a new description under 4000 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE to_atg.restriction_code SET
    restriction_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srID)#">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srDescription)#">,
    stateprov = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srStateProv)#">,
    county = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srCounty)#">,
    zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.srZipCode)#">,
    sw_last_updated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    sw_update_user = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userName#">
    WHERE restriction_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteShipRestriction" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM to_atg.restriction_code
    WHERE restriction_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>