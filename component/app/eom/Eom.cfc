<cfcomponent>
    <cffunction name="getEmployeeOfMonth" access="public" returntype="query" hint="Get Employee Of Month data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="eomName" type="string" required="yes" default="">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="eomDateRel" type="string" required="yes" default="">
    <cfargument name="eomDateExp" type="string" required="yes" default="">
    <cfargument name="eomtID" type="string" required="yes" default="0">
    <cfargument name="eomStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eomName">
    <cfargument name="cacheQueryTime" type="string" required="yes" default="0,0,0,0">
    <!--- When random equals true. --->
    <cfargument name="random" type="string" required="yes" default="false">
    <cfset var rsEmployeeOfMonth = "" >
    <cftry>
    <cfif ARGUMENTS.random EQ true>
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getSiteRet">
    <cfinvokeargument name="siteStatus" value="1,3"/>
    </cfinvoke>
    <cfset siteNoRandom = RandRange(1,getSiteRet.recordcount)>
    <cfset siteNoList = ValueList(getSiteRet.siteNo)>
    <cfset ARGUMENTS.siteNo = ListGetAt(siteNoList,siteNoRandom)>
    </cfif>
    <cfquery name="rsEmployeeOfMonth" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employee_of_month WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(eomName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(eomDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="0,#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.eomName NEQ "">
    AND UPPER(eomName) = <cfqueryparam value="#UCASE(ARGUMENTS.eomName)#" cfsqltype="cf_sql_varchar">
    </cfif>
	<!---Date Range.--->
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.eomDateRel NEQ "">
    AND eomDateRel >= <cfqueryparam value="#ARGUMENTS.eomDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.eomDateExp NEQ "">
    AND eomDateExp <= <cfqueryparam value="#ARGUMENTS.eomDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfelse>
    <cfif ARGUMENTS.eomDateRel NEQ "">
    AND eomDateRel = <cfqueryparam value="#ARGUMENTS.eomDateRel#" cfsqltype="cf_sql_timestamp">
    </cfif>
    <cfif ARGUMENTS.eomDateExp NEQ "">
    AND eomDateExp = <cfqueryparam value="#ARGUMENTS.eomDateExp#" cfsqltype="cf_sql_timestamp">
    </cfif>
    </cfif>
    <cfif ARGUMENTS.eomtID NEQ 0>
    AND eomtID = <cfqueryparam value="#ARGUMENTS.eomtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND eomStatus IN (<cfqueryparam value="#ARGUMENTS.eomStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmployeeOfMonth = StructNew()>
    <cfset rsEmployeeOfMonth.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmployeeOfMonth>
    </cffunction>
    
    <cffunction name="getEmployeeOfMonthType" access="public" returntype="query" hint="Get Employee Of Month Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="eomtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eomtName">
    <cfset var rsEmployeeOfMonthType = "" >
    <cftry>
    <cfquery name="rsEmployeeOfMonthType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employee_of_month_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eomtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND eomtStatus IN (<cfqueryparam value="#ARGUMENTS.eomtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmployeeOfMonthType = StructNew()>
    <cfset rsEmployeeOfMonthType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmployeeOfMonthType>
    </cffunction>
    
    <cffunction name="getEmployeeOfMonthReport" access="public" returntype="query" hint="Get Employee Of Month Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="eomName">
    <cfset var rsEmployeeOfMonthReport = "" >
    <cftry>
    <cfquery name="rsEmployeeOfMonthReport" datasource="#application.mcmsDSN#">
    SELECT eomName As Name, TO_CHAR(eomDateHire, 'MM/DD/YYYY') As Hire_Date, TO_CHAR(eomDateRel, 'MM/DD/YYYY') As Release_Date, TO_CHAR(eomDateExp, 'MM/DD/YYYY') As Expire_Date, siteName As Site, deptName As Dept, eomtName As Type, sName As Status FROM v_employee_of_month WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eomName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND eomDateRel = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND eomDateExp = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmployeeOfMonthReport = StructNew()>
    <cfset rsEmployeeOfMonthReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmployeeOfMonthReport>
    </cffunction>
    
    <cffunction name="getEmployeeOfMonthTypeReport" access="public" returntype="query" hint="Get Employee Of Month Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="eomtName">
    <cfset var rsEmployeeOfMonthTypeReport = "" >
    <cftry>
    <cfquery name="rsEmployeeOfMonthTypeReport" datasource="#application.mcmsDSN#">
    SELECT eomtName FROM v_employee_of_month_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eomtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmployeeOfMonthTypeReport = StructNew()>
    <cfset rsEmployeeOfMonthTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmployeeOfMonthTypeReport>
    </cffunction>
    
    <cffunction name="insertEmployeeOfMonth" access="public" returntype="struct">
    <cfargument name="eomName" type="string" required="yes">
    <!--- eomDescription has been commented out on form, default to blank. --->
    <cfargument name="eomDescription" type="string" required="yes" default="">
    <cfargument name="eomDateHire" type="string" required="yes">
    <cfargument name="eomRelMonth" type="string" required="yes">
    <cfargument name="eomRelYear" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="imgFile" type="string" required="yes">
    <cfargument name="imgStatus" type="numeric" required="yes" default="1">
    <cfargument name="btID" type="numeric" required="yes" default="0">    
    <cfargument name="eomtID" type="numeric" required="yes">
    <cfargument name="eomStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.image.Image" 
    method="insertImage" 
    returnvariable="result">
    <cfinvokeargument name="imgName" value="#ARGUMENTS.eomName#-#DateFormat(Now(), application.dateFormat)#-#LSTimeFormat(Now(), 'hh:mm:ss')#">
    <cfinvokeargument name="imgFile" value="#ARGUMENTS.imgFile#">
    <cfinvokeargument name="imgtID" value="#application.employeeOfMonthImageType#">
    <cfinvokeargument name="netID" value="#application.networkID#">
    <cfinvokeargument name="imgStatus" value="#ARGUMENTS.imgStatus#">
    <cfinvokeargument name="imgCountID" value="1"> 
    <cfinvokeargument name="btID" value="#ARGUMENTS.btID#">                
    </cfinvoke>
    <cfif result.message DOES NOT CONTAIN "error">
    <!---Get latest image id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="imgID">
    <cfinvokeargument name="tableName" value="tbl_image"/>
    </cfinvoke>
    <cfset var.imgID = imgID>              
    <!---Create the variable for the first day and last day of the month.--->
    <cfset this.eomDateRel = CreateDate(ARGUMENTS.eomRelYear, ARGUMENTS.eomRelMonth, 1)>
    <cfset this.eomDateExp = CreateDate(ARGUMENTS.eomRelYear, ARGUMENTS.eomRelMonth, DaysInMonth(this.eomDateRel))>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.eomDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.eom.EOM"
    method="getEmployeeOfMonth"
    returnvariable="getCheckEmployeeOfMonthRet">
    <cfinvokeargument name="eomName" value="#ARGUMENTS.eomName#"/>
    <cfinvokeargument name="eomDateRel" value="#this.eomDateRel#"/>
    <cfinvokeargument name="eomDateExp" value="#this.eomDateExp#"/>
    <cfinvokeargument name="eomStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmployeeOfMonthRet.recordcount NEQ 0>
    <cfset result.message = "The employee of the month already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.eomDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_employee_of_month (eomName,eomDescription,eomDateHire,eomDateRel,eomDateExp,siteNo,deptNo,imgID,eomtID,eomStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eomName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eomDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.eomDateHire#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#this.eomDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#this.eomDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#var.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eomtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eomStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get latest ad item id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="eomID">
    <cfinvokeargument name="tableName" value="tbl_employee_of_month"/>
    </cfinvoke>
    <cfset var.eomID = eomID>
    <!--- Send email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# Employee Of The Month Submission (#ARGUMENTS.siteNo#)"/>
    <cfinvokeargument name="to" value="#application.employeeOfMonthEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="eomID" value="#var.eomID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/employee_of_month/view/inc_employee_of_month_email_template.cfm"/>
    </cfinvoke>           
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmployeeOfMonth" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="eomName" type="string" required="yes">
    <!--- eomDescription has been commented out on form, default to blank. --->
    <cfargument name="eomDescription" type="string" required="yes" default="">
    <cfargument name="eomDateHire" type="string" required="yes">
    <cfargument name="eomRelMonth" type="string" required="yes">
    <cfargument name="eomRelYear" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes" default="0">
    <cfargument name="imgFile" type="string" required="yes" default="">
    <cfargument name="tempImgFile" type="string" required="yes">
    <cfargument name="btID" type="numeric" required="yes" default="0">
    <cfargument name="imgStatus" type="numeric" required="yes" default="1">
    <cfargument name="eomtID" type="numeric" required="yes">
    <cfargument name="eomStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfif ARGUMENTS.imgFile NEQ "">
    <cfinvoke 
    component="MCMS.component.app.image.Image" 
    method="updateImage" 
    returnvariable="result">
    <cfinvokeargument name="ID" value="#ARGUMENTS.imgID#">
    <cfinvokeargument name="imgName" value="#ARGUMENTS.eomName#-#DateFormat(Now(), application.dateFormat)#-#LSTimeFormat(Now(), 'hh:mm:ss')#">
    <cfinvokeargument name="imgFile" value="#ARGUMENTS.imgFile#">
    <cfinvokeargument name="tempImgFile" value="#ARGUMENTS.tempImgFile#">
    <cfinvokeargument name="imgtID" value="#application.employeeOfMonthImageType#">
    <cfinvokeargument name="btID" value="#ARGUMENTS.btID#">
    <cfinvokeargument name="uaID" value="#ARGUMENTS.uaID#">
    <cfinvokeargument name="imgStatus" value="#ARGUMENTS.imgStatus#">               
    </cfinvoke>
    </cfif>
    <cfif result.message DOES NOT CONTAIN "error">
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.eomDescription#"/>
    </cfinvoke>
    <!---Create the variable for the first day and last day of the month.--->
    <cfset this.eomDateRel = CreateDate(ARGUMENTS.eomRelYear, ARGUMENTS.eomRelMonth, 1)>
    <cfset this.eomDateExp = CreateDate(ARGUMENTS.eomRelYear, ARGUMENTS.eomRelMonth, DaysInMonth(this.eomDateRel))>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.eom.EOM"
    method="getEmployeeOfMonth"
    returnvariable="getCheckEmployeeOfMonthRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="eomName" value="#ARGUMENTS.eomName#"/>
    <cfinvokeargument name="eomDateRel" value="#this.eomDateRel#"/>
    <cfinvokeargument name="eomDateExp" value="#this.eomDateExp#"/>
    <cfinvokeargument name="eomStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmployeeOfMonthRet.recordcount NEQ 0>
    <cfset result.message = "The employee of the month already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.eomDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employee_of_month SET
    eomName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eomName#">,
    eomDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eomDescription#">,
    eomDateHire = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.eomDateHire#">,
    eomDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#this.eomDateRel#">,
    eomDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#this.eomDateExp#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    eomtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eomtID#">,
	<cfif ARGUMENTS.uaID NEQ 101>
    eomDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    eomStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eomStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmployeeOfMonthList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eomStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employee_of_month SET
    eomStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eomStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteEmployeeOfMonth" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_employee_of_month
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