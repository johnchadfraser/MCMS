<cfcomponent>
    <cffunction name="getPCDepartmentIP" access="public" returntype="query" hint="Get PCDepartmentIP data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pcdiName" type="string" required="yes" default="">
    <cfargument name="pcDeptIP" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="pcdiStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pcdiName">
    <cfset var rsPCDepartmentIP = "" >
    <cftry>
    <cfquery name="rsPCDepartmentIP" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pc_department_ip WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pcdiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pcdiDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pcdiName NEQ "">
    AND UPPER(pcdiName) = <cfqueryparam value="#UCASE(ARGUMENTS.pcdiName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pcDeptIP NEQ 0>
    AND pcDeptIP = <cfqueryparam value="#ARGUMENTS.pcDeptIP#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pcdiStatus IN (<cfqueryparam value="#ARGUMENTS.pcdiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPCDepartmentIP = StructNew()>
    <cfset rsPCDepartmentIP.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPCDepartmentIP>
    </cffunction>
    
    <cffunction name="getPCDepartmentIPReport" access="public" returntype="query" hint="Get PCDepartmentIP Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pcdiName">
    <cfset var rsPCDepartmentIPReport = "" >
    <cftry>
    <cfquery name="rsPCDepartmentIPReport" datasource="#application.mcmsDSN#">
    SELECT pcdiName AS Name, TO_CHAR(pcdiDescription) AS Description, imgFile AS Image, pcDeptIP, deptNo, deptName AS Department, sName AS Status FROM v_pc_department_ip WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pcdiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pcdiDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPCDepartmentIPReport = StructNew()>
    <cfset rsPCDepartmentIPReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPCDepartmentIPReport>
    </cffunction>
    
    <cffunction name="insertPCDepartmentIP" access="public" returntype="struct">
    <cfargument name="pcdiName" type="string" required="yes">
    <cfargument name="pcdiDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="pcDeptIP" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="pcdiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pcdiDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.portal.Portal"
    method="getPCDepartmentIP"
    returnvariable="getCheckPCDepartmentIPRet">
    <cfinvokeargument name="pcdiName" value="#ARGUMENTS.pcdiName#"/>
    <cfinvokeargument name="pcdiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPCDepartmentIPRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pcdiName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pcdiDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pc_department_ip (pcdiName,pcdiDescription,imgID,pcDeptIP,deptNo,pcdiStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pcdiName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pcdiDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pcDeptIP#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcdiStatus#">
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
    
    <cffunction name="updatePCDepartmentIP" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pcdiName" type="string" required="yes">
    <cfargument name="pcdiDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="pcDeptIP" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="pcdiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pcdiDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.portal.Portal"
    method="getPCDepartmentIP"
    returnvariable="getCheckPCDepartmentIPRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pcdiName" value="#ARGUMENTS.pcdiName#"/>
    <cfinvokeargument name="pcdiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPCDepartmentIPRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pcdiName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pcdiDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pc_department_ip SET
    pcdiName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pcdiName#">,
    pcdiDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pcdiDescription#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    pcDeptIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pcDeptIP#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    pcdiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcdiStatus#">
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
    
    <cffunction name="updatePCDepartmentIPList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pcdiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pc_department_ip SET
    pcdiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcdiStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePCDepartmentIP" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pc_department_ip
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