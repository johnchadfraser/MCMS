<cfcomponent>
    <cffunction name="getDepartment" access="public" returntype="query" hint="Get Department data.">
    <cfargument name="keywords" type="string" required="no" default="All">
	<cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
	<cfargument name="deptName" type="string" required="yes" default="">
    <cfargument name="deptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptName">
	<cfset var rsDepartment = "" >
    <cftry>
    <cfquery name="rsDepartment" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_department WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (deptName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptName NEQ "">
    AND deptName = <cfqueryparam value="#ARGUMENTS.deptName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDepartment = StructNew()>
    <cfset rsDepartment.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDepartment>
    </cffunction>

	<cffunction name="insertDepartment" access="public" returntype="struct">
	<cfargument name="deptName" type="string" required="yes">
	<cfargument name="deptNo" type="numeric" required="yes">
	<cfargument name="deptSort" type="numeric" required="yes">
	<cfargument name="deptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<cftransaction>
	<cfquery datasource="#application.mcmsDSN#">
	INSERT INTO tbl_department (deptName,deptNo,deptSort,deptStatus) VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deptName#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
	<cfqueryparam cfsqltype="cf_sql_smallint" value="#ARGUMENTS.deptSort#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptStatus#">
	)
	</cfquery>
	</cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
	<cfreturn result>
	</cffunction>
	
	<cffunction name="updateDepartment" access="public" returntype="struct">
	<cfargument name="ID" type="numeric" required="yes">
	<cfargument name="deptName" type="string" required="yes">
	<cfargument name="deptNo" type="numeric" required="yes">
	<cfargument name="deptSort" type="numeric" required="yes">
	<cfargument name="deptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
	<cftransaction>
	<cfquery datasource="#application.mcmsDSN#">
	UPDATE tbl_department SET
	deptName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deptName#">,
	deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
	deptSort = <cfqueryparam cfsqltype="cf_sql_smallint" value="#ARGUMENTS.deptSort#">,
	deptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptStatus#">
	WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
	</cfquery>
	</cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
	<cfreturn result>
	</cffunction>
    
    <cffunction name="updateDepartmentList" access="public" returntype="struct">
	<cfargument name="ID" type="numeric" required="yes">
	<cfargument name="deptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
	<cftransaction>
	<cfquery datasource="#application.mcmsDSN#">
	UPDATE tbl_department SET
	deptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptStatus#">
	WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
	</cfquery>
	</cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
	<cfreturn result>
	</cffunction>
	
	<cffunction name="deleteDepartment" access="public" returntype="struct">
	<cfargument name="ID" type="numeric" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
	<cftransaction>
	<cfquery datasource="#application.mcmsDSN#">
	DELETE FROM tbl_department
	WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
	</cfquery>
	</cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
	</cffunction>    
</cfcomponent>