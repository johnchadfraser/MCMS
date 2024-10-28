<cfcomponent>
    <cffunction name="getImport" access="public" returntype="query" hint="Get Import data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="iName" type="string" required="yes" default="">
    <cfargument name="iDate" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="itID" type="string" required="yes" default="0">
    <cfargument name="iStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="isID, iName">
    <cfset var rsImport = "" >
    <cftry>
    <cfquery name="rsImport" datasource="#application.mcmsDSN#">
    SELECT * FROM v_import WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(iName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(iDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.iName NEQ "">
    AND UPPER(iName) = <cfqueryparam value="#UCASE(ARGUMENTS.iName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.itID NEQ 0>
    AND itID IN (<cfqueryparam value="#ARGUMENTS.itID#" cfsqltype="cf_sql_integer" list="yes">)
    </cfif>
    <cfif ARGUMENTS.iDate NEQ "">
    AND TO_CHAR(iDate) >= <cfqueryparam value="#ARGUMENTS.iDate#" cfsqltype="cf_sql_date">
    </cfif>
    AND iStatus IN (<cfqueryparam value="#ARGUMENTS.iStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImport = StructNew()>
    <cfset rsImport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsImport>
    </cffunction>
    
    <cffunction name="getImportType" access="public" returntype="query" hint="Get Import Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="itName" type="string" required="yes" default="">
    <cfargument name="itStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="itName">
    <cfset var rsImportType = "" >
    <cftry>
    <cfquery name="rsImportType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_import_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer" list="yes">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(itName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.itName NEQ "">
    AND UPPER(itName) = <cfqueryparam value="#UCASE(ARGUMENTS.itName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND itStatus IN (<cfqueryparam value="#ARGUMENTS.itStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImportType = StructNew()>
    <cfset rsImportType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsImportType>
    </cffunction>
    
    <cffunction name="getImportStatus" access="public" returntype="query" hint="Get Import Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="isStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="isName">
    <cfset var rsImportStatus = "" >
    <cftry>
    <cfquery name="rsImportStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_import_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(isName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND isStatus IN (<cfqueryparam value="#ARGUMENTS.isStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImportStatus = StructNew()>
    <cfset rsImportStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsImportStatus>
    </cffunction>
    
    <cffunction name="getImportSchedule" access="public" returntype="query" hint="Get Import Schedule data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="iID" type="numeric" required="yes" default="0">
    <cfargument name="isDate" type="string" required="yes" default="">
    <cfargument name="isDateTime" type="string" required="yes" default="" hint="Prevents the import from being sent twice in one day.">
    <cfargument name="iStatus" type="string" required="no" default="1">
    <cfargument name="isStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="iName, isDate">
    <cfset var rsImportSchedule = "" >
    <cftry>
    <cfquery name="rsImportSchedule" datasource="#application.mcmsDSN#">
    SELECT * FROM v_import_schedule WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(iName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(iDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.iID NEQ 0>
    AND iID = <cfqueryparam value="#ARGUMENTS.iID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.isDate NEQ "">
    AND isDate >= <cfqueryparam value="#DateFormat(ARGUMENTS.isDate, 'm/d/yyyy')# #TimeFormat('12:01:00 AM', 'h:mm:ss tt')#" cfsqltype="cf_sql_timestamp">
    </cfif>
    <!---To prevent sending a newsletter twice on one day.--->
    <cfif ARGUMENTS.isDateTime NEQ "">
    AND (isDate BETWEEN <cfqueryparam value="#DateFormat(ARGUMENTS.isDateTime, 'm/d/yyyy')# #TimeFormat('12:01:00 AM', 'h:mm:ss tt')#" cfsqltype="cf_sql_timestamp"> AND <cfqueryparam value="#DateFormat(ARGUMENTS.isDateTime, 'm/d/yyyy')# #TimeFormat('11:59:00 PM', 'h:mm:ss tt')#" cfsqltype="cf_sql_timestamp">)
    </cfif>
    AND iStatus IN (<cfqueryparam value="#ARGUMENTS.iStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND isStatus IN (<cfqueryparam value="#ARGUMENTS.isStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImportSchedule = StructNew()>
    <cfset rsImportSchedule.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsImportSchedule>
    </cffunction>
    
    <cffunction name="getImportReport" access="public" returntype="query" hint="Get Import Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="iName">
    <cfset var rsImportReport = "" >
    <cftry>
    <cfquery name="rsImportReport" datasource="#application.mcmsDSN#">
    SELECT iName As Name, iDescription AS Description, TO_CHAR(iDate,'MM/DD/YYYY') AS Import_Date, userLName AS Username, docFile AS Filename, isName AS Import_Status, sName AS Status FROM v_import WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(iName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(iDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImportReport = StructNew()>
    <cfset rsImportReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsImportReport>
    </cffunction>
    
    <cffunction name="getImportTypeReport" access="public" returntype="query" hint="Get Import Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="itName">
    <cfset var rsImportTypeReport = "" >
    <cftry>
    <cfquery name="rsImportTypeReport" datasource="#application.mcmsDSN#">
    SELECT itName, itDescription AS Description, itColumnList AS Column_List, itMethod AS Method, itComponent AS Component, itSheetName as Sheet, sName AS Status FROM v_import_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(itName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(itDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImportTypeReport = StructNew()>
    <cfset rsImportTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsImportTypeReport>
    </cffunction>
    
    <cffunction name="setImportTypeDocument" access="public" returntype="string" hint="Set Import Type Document">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="itComponent" type="string" required="yes" default="">
	<cfset var importTypeDocument = "" >
    <cftry>
    <cfsavecontent variable="importTypeDocument">
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getImportType"
    returnvariable="getImportTypeRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="itStatus" value="1"/>
    </cfinvoke>
    <cfoutput>
    <cfheader name="Content-Disposition" value="attachment;filename=#LCASE(ARGUMENTS.itComponent)#_#DateFormat(Now(), application.dateFormat)#.xls">
    <cfcontent type="application/vnd.ms-excel">
    <html xmlns:o="urn:schemas-microsoft-com:office:excel" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"> 
    <head>
    <meta http-equiv="Content-Type" content="text/html;charset=windows-1252"> 
    <xml> 
    <x:ExcelWorkbook> 
    <x:Name>#getImportTypeRet.itName#</x:Name>
    <x:ExcelWorksheets> 
    <x:ExcelWorksheet> 
    <x:Name>#getImportTypeRet.itSheetName#</x:Name> 
    <x:WorksheetOptions> 
    <x:Panes> 
    </x:Panes> 
    <x:Print>         
    <x:Gridlines />     
    </x:Print> 
    </x:WorksheetOptions> 
    </x:ExcelWorksheet> 
    </x:ExcelWorksheets> 
    </x:ExcelWorkbook> 
    </xml> 
    </head>
    <body>
    <cfloop query="getImportTypeRet">
    <cfset columnHeader = ValueList(getImportTypeRet.itColumnList)>
    <table border="1">
    <tr>
    <cfloop list="#columnHeader#" index="column">
    <th <cfif column CONTAINS("*")>style="color:red"</cfif>>
    <cfoutput>#Replace(column,"*","")#</cfoutput>
    </th>
    </cfloop>
    </tr>
    <tr>
    <cfloop list="#columnHeader#" index="i">
    <td>&nbsp;</td>
    </cfloop>
    </tr>
    </table>
    </cfloop>
    </body>
    </html>
    </cfoutput>
    </cfsavecontent>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset importTypeDocument = "There was an error with setImportTypeDocument.">
    </cfcatch>
    </cftry>
    <cfreturn importTypeDocument>
    </cffunction>
    
    <cffunction name="insertImport" access="public" returntype="struct">
    <cfargument name="iName" type="string" required="yes">
    <cfargument name="iDescription" type="string" required="yes">
    <cfargument name="userID" type="string" required="yes">
    <cfargument name="docID" type="string" required="yes">
    <cfargument name="itID" type="numeric" required="yes">
    <cfargument name="iStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.iDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getImport"
    returnvariable="getCheckImportRet">
    <cfinvokeargument name="iName" value="#ARGUMENTS.iName#"/>
    <cfinvokeargument name="itID" value="#ARGUMENTS.itID#"/>
    <cfinvokeargument name="iStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImportRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.iName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.iDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_import (iName,iDescription,iDate,userID,docID,itID,iStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.iName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.iDescription#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.itID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.iStatus#">
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
    
    <cffunction name="insertImportType" access="public" returntype="struct">
    <cfargument name="itName" type="string" required="yes">
    <cfargument name="itDescription" type="string" required="yes">
    <cfargument name="itColumnList" type="string" required="yes">
    <cfargument name="itComponent" type="string" required="yes">
    <cfargument name="itMethod" type="string" required="yes">
    <cfargument name="itSheetName" type="string" required="yes">
    <cfargument name="itStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.itDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getImportType"
    returnvariable="getCheckImportTypeRet">
    <cfinvokeargument name="itName" value="#ARGUMENTS.itName#"/>
    <cfinvokeargument name="itStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImportTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.itName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.itDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_import_type (itName,itDescription,itColumnList,itComponent,itMethod,itSheetName,itStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itColumnList#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itComponent#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itMethod#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itSheetName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.itStatus#">
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
    
    <cffunction name="insertImportSchedule" access="public" returntype="struct">
    <cfargument name="iID" type="numeric" required="yes">
    <cfargument name="iName" type="string" required="yes">
    <cfargument name="filePath" type="string" required="yes">
    <cfargument name="itSheetName" type="string" required="yes">
    <cfargument name="itComponent" type="string" required="yes">
    <cfargument name="itMethod" type="string" required="yes">
    <cfargument name="itColumnList" type="string" required="yes">
    <cfargument name="isStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully scheduled the import.">
    <!---<cftry>--->
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getImportSchedule"
    returnvariable="getCheckImportScheduleRet">
    <cfinvokeargument name="iID" value="#ARGUMENTS.iID#"/>
    <cfinvokeargument name="isDateTime" value="#Now()#"/>
    <cfinvokeargument name="isStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImportScheduleRet.recordcount NEQ 0>
    <cfset result.message = "A schedule already exists for this import, please enter choose a different import or try again tommorrow.">
    <cfelse>   
    <!---BEGIN SCHEDULER--->
    <!---Get the curent schedules.--->
    <cfset local.totalCountToday = 0>
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getImportSchedule"
    returnvariable="getImportScheduleRet">
    <cfinvokeargument name="isDate" value="#Now()#"/>
    <cfinvokeargument name="isStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="isDate DESC"/>
    </cfinvoke>
    <cfif getImportScheduleRet.recordcount NEQ 0>
    <cfset local.totalCountToday = Evaluate(ValueList(getImportScheduleRet.isCount, '+'))>
    </cfif>
    <!---Get import data.--->
    <cfif getImportScheduleRet.recordcount EQ 0>
    <cfset local.scheduleTimeStart = TimeFormat(Now(), 'hh:mm tt')>
    <cfelse>
    <!---Get the latest schedule and calculate the time of it's last schedule to build on top of.--->
    <cfset local.scheduleTimeStart = TimeFormat(DateAdd('s', (local.totalCountToday+2)*application.importDelayTime, getImportScheduleRet.isDate), 'hh:mm tt')>
	<!---If the scheduleTimeStart is less than now use the current time. This ensures that the scheduled task are not created after time has elapsed.--->
    <cfif local.scheduleTimeStart LT TimeFormat(Now(), 'hh:mm tt')>
    <cfset local.scheduleTimeStart = TimeFormat(Now(), 'hh:mm tt')>
    </cfif>
    </cfif>
    <!---Set the scheduleDate.--->
    <cfset local.scheduleDate = DateFormat(Now(), 'mm/dd/yyyy')>
    <!---Get the records.--->
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getExcelFile"
    returnvariable="getImportDataRet">
    <cfinvokeargument name="iID" value="#ARGUMENTS.iID#"/>
    <cfinvokeargument name="filePath" value="#ARGUMENTS.filePath#"/>
    <cfinvokeargument name="itSheetName" value="#ARGUMENTS.itSheetName#"/>
    </cfinvoke>
    <cfif getImportDataRet.recordcount EQ 0>
    <cfset result.message = "There are no imports, please try again.">
    <cfelse>
    <!---Create a variable for the total amount of subscriptions.--->
    <cfset local.importTotal = getImportDataRet.recordcount>
    <!---Create the total number of schedules to be created.--->
    <cfset local.scheduleCount = Ceiling(local.importTotal/application.importBatchSize)>
    <!---Calculate the total time (seconds) that it will take to run the schedules.--->
    <cfset local.scheduleTimeTotal = local.scheduleCount*application.importDelayTime>
    <!---Build a thread for the scheduler.--->
    <cfthread action="run" name="#ARGUMENTS.iName#" scheduleCount="#local.scheduleCount#" importDelayTime="#application.importDelayTime#" scheduleTimeStart="#local.scheduleTimeStart#" scheduleDate="#local.scheduleDate#" importBatchSize="#application.importBatchSize#" importTotal="#local.importTotal#" iID="#ARGUMENTS.iID#" iName="#ARGUMENTS.iName#" filePath="#ARGUMENTS.filePath#" itSheetName="#ARGUMENTS.itSheetName#" itComponent="#ARGUMENTS.itComponent#" itMethod="#ARGUMENTS.itMethod#" itColumnList="#ARGUMENTS.itColumnList#" importServer="//#CGI.SERVER_NAME#">
    <!---Create the schedules.--->
    <cfloop index="id"from="1" to="#scheduleCount#">
    <!---Add the sequential time to the delaytime values + 1 extra to begin after the last schedule.--->
    <cfset local.scheduleTime = TimeFormat(DateAdd('s', (importDelayTime*id)+importDelayTime, scheduleTimeStart), 'hh:mm tt')>
    <!---If the scheduleTime passes 11:00 PM set the schedule task to the next day.--->
    <cfif ParseDateTime(scheduleDate & '11:00 PM') LT ParseDateTime(scheduleDate & local.scheduleTime) AND scheduleDate EQ DateFormat(Now(), 'mm/dd/yyyy')>
    <!---Add a day to the scheduler.--->
    <cfset scheduleDate = DateFormat(DateAdd('d', 1, scheduleDate), 'mm/dd/yyyy')>
    <!---Renew the scheduler to begin early the next day.--->
	<cfset local.setTime = '00:01'>
	<cfset local.scheduleTime = TimeFormat(DateAdd('s', importDelayTime*id, local.setTime), 'hh:mm tt')>
    </cfif>
    <!---Create the range from where to begin quering for this scheduled task.--->
    <cfset local.startRow = ((id-1)*importBatchSize)+1>
    <!---Create range of total subscription records for this scheduled task.---> 
    <cfset local.totalRows = Min(local.startRow + (importBatchSize-1), importTotal)>
    <cfset local.maxRows = importTotal>
    <!--- Create schedules called 'siteNo & '-newsletter' & id' where id is the loop index. ---> 
    <cfset local.scheduleID = iName & id>
    <!--- Create timeout based on batch size and an estimated 50 records per second. ---> 
    <cfset local.timeOut = (importBatchSize/50)*60>
    <!--- Create cache hours for caching of excel file data. ---> 
    <cfset local.cacheHours = Round((scheduleCount*importDelayTime)/3600)>
    <cfif local.cacheHours EQ 0>
    <cfset local.cacheHours = 1>
    </cfif>
    <!--- Make sure you need to do something.--->  
    <cfif local.startRow LE local.totalRows> 
    <cfschedule 
    action="update" 
    task="#local.scheduleID#" 
    operation="httprequest" 
    url="#importServer#/import/schedule_manager.cfm?scheduleID=#URLEncodedFormat(local.scheduleID)#&startRow=#local.startRow#&maxRows=#local.maxRows#&iID=#iID#&iName=#URLEncodedFormat(iName)#&filePath=#URLEncodedFormat(filePath)#&itSheetName=#URLEncodedFormat(itSheetName)#&itComponent=#itComponent#&itMethod=#itMethod#&itColumnList=#itColumnList#&cacheHours=#local.cacheHours#&userID=#session.userID#&userEmail=#session.userUsername#" 
    startdate="#scheduleDate#"
    starttime="#local.scheduleTime#"
    interval="once"
    requesttimeout="#local.timeOut#"
    >
    </cfif>
    </cfloop>
    </cfthread>
    <!---END SCHEDULER--->
    <!---Create parameters.--->
    <cfset isParameter = "">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_import_schedule (iID,isCount,isParameter,isTimeDelay,isStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.iID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#local.scheduleCount#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#isParameter#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#application.importDelayTime#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    <!---Update the status to "Processing".--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_import SET
    iDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    isID = <cfqueryparam cfsqltype="cf_sql_integer" value="2">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.iID#">
    </cfquery>
    </cftransaction>
    <!---Send email notification.--->
    <cfset this.scheduleTime = TimeFormat(DateAdd('s', application.importDelayTime*2, local.scheduleTimeStart), 'hh:mm tt')>
    <cfmail from="#application.webmasterEmail#" to="#application.webmasterEmail#;#session.userUsername#;" subject="#ARGUMENTS.iName# Import Scheduled" type="html">
    <cfoutput>	
    #ARGUMENTS.iName# has been scheduled to run at #this.scheduleTime#. This time may vary based on other scheduled jobs.</cfoutput>
    </cfmail>
    </cfif>
    </cfif>
    <!---
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record. Make sure the import file matches the sheet name and columns required for the import. You may need to check the application.cfadminPassword.">
    
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateImport" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="iName" type="string" required="yes">
    <cfargument name="iDescription" type="string" required="yes">
    <cfargument name="userID" type="string" required="yes">
    <cfargument name="itID" type="numeric" required="yes">
    <cfargument name="isID" type="numeric" required="yes">
    <cfargument name="iStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.iDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getImport"
    returnvariable="getCheckImportRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="iName" value="#ARGUMENTS.iName#"/>
    <cfinvokeargument name="itID" value="#ARGUMENTS.itID#"/>
    <cfinvokeargument name="iStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImportRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.iName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.iDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_import SET
    iName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.iName#">,
    iDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.iDescription#">,
    itID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.itID#">,
    isID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.isID#">,
		<cfif ARGUMENTS.uaID NEQ 101>
    iDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    iStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.iStatus#">
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
    
    <cffunction name="updateImportType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="itName" type="string" required="yes">
    <cfargument name="itDescription" type="string" required="yes">
    <cfargument name="itColumnList" type="string" required="yes">
    <cfargument name="itComponent" type="string" required="yes">
    <cfargument name="itMethod" type="string" required="yes">
    <cfargument name="itSheetName" type="string" required="yes">
    <cfargument name="itStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.itDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getImportType"
    returnvariable="getCheckImportTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="itName" value="#ARGUMENTS.itName#"/>
    <cfinvokeargument name="itStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImportTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.itName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.itDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_import_type SET
    itName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itName#">,
    itDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itDescription#">,
    itColumnList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itColumnList#">,
    itComponent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itComponent#">,
    itMethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itMethod#">,
    itSheetName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itSheetName#">,
    itStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.itStatus#">
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
    
    <cffunction name="updateImportList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="iStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_import SET
    iStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.iStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateImportTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="itStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_import_type SET
    itStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.itStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteImport" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_import
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteImportType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_import_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertImportData" access="public" returntype="struct">
    <cfargument name="scheduleID" type="string" required="yes">
    <cfargument name="iID" type="numeric" required="yes">
    <cfargument name="iName" type="string" required="yes">
    <cfargument name="filePath" type="string" required="yes">
    <cfargument name="itSheetName" type="string" required="yes">
    <cfargument name="itComponent" type="string" required="yes">
    <cfargument name="itMethod" type="string" required="yes">
    <cfargument name="itColumnList" type="string" required="yes">
    <cfargument name="startRow" type="numeric" required="yes">
    <cfargument name="maxRows" type="numeric" required="yes">
    <cfargument name="cacheHours" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfset result.message = "You have successfully submitted the records for import. Large lists may take some time to complete. An email will be sent.">
    <cftry>
    <cfthread action="run" name="#ARGUMENTS.scheduleID#" scheduleID="#ARGUMENTS.scheduleID#" iID="#ARGUMENTS.iID#" iName="#ARGUMENTS.iName#" filePath="#ARGUMENTS.filePath#" itSheetName="#ARGUMENTS.itSheetName#" itComponent="#ARGUMENTS.itComponent#" itMethod="#ARGUMENTS.itMethod#" itColumnList="#ARGUMENTS.itColumnList#" cacheHours="#ARGUMENTS.cacheHours#" startRow="#ARGUMENTS.startRow#" maxRows="#ARGUMENTS.maxRows#" userID="#ARGUMENTS.userID#" webmasterEmail="#application.webmasterEmail#" userEmail="#ARGUMENTS.userEmail#" siteDSN="#application.mcmsDSN#" dateFormat="#application.dateFormat#">
    <cfset application.mcmsDSN = siteDSN>
    <cfset application.webmasterEmail = webmasterEmail>
	<!---First get the file to import.--->
    <cfinvoke 
    component="MCMS.component.app.import.Import"
    method="getExcelFile"
    returnvariable="data">
    <cfinvokeargument name="iID" value="#iID#"/>
    <cfinvokeargument name="filePath" value="#filePath#"/>
    <cfinvokeargument name="itSheetName" value="#itSheetName#"/>
    <cfinvokeargument name="cacheHours" value="#cacheHours#"/>
    </cfinvoke>
    <!---Loop an insert records.--->
    <cfif data.recordcount EQ 0>
    <cfset result.message = "Your submission returned no records. This is typically caused by an incorrect sheet name in the XLS file.">
    <cfelse>
    <cfset messageLog = ''>
	<cfoutput query="data" startrow="#startRow#" maxrows="#maxRows#">
    <cfinvoke 
    component="cfc.#itComponent#"
    method="#itMethod#"
    returnvariable="rs">
    <cfloop list="#itColumnList#" index="i">
    <cfset i = Replace(i,"*","")>
    <cfset columnName = i>
    <cfset columnValue = Evaluate(DE('##data.#i###'))>
    <cfinvokeargument name="#columnName#" value="#columnValue#"/>
    <cfinvokeargument name="iID" value="#iID#"/>
    </cfloop>
    <cfif userID NEQ 0>
    <cfinvokeargument name="userID" value="#userID#"/>
    </cfif>
    </cfinvoke>
    <cfset messageLog = messageLog & '<br/>' & rs.message>
    </cfoutput>
    <cfset totalrows = startrow+maxRows>
    <!---Update the status of the import once all records have been inserted..--->
    <cfif totalrows GTE data.recordcount>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_import SET
    iDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    isID = <cfqueryparam cfsqltype="cf_sql_integer" value="4">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#iID#">
    </cfquery>
    </cftransaction>
    <!---Clear the querycache.--->
    <cfobjectcache action="clear">
    <!---Send email to confirm completion.--->
    <cfmail
    subject="Import Finished - #scheduleID#"
    to="#webmasterEmail#;#userEmail#"
    from="#webmasterEmail#"  
    type="html">
	<cfoutput>
    #scheduleID# complete. Please check the log below to confirm your import.
    <br/>
    #messageLog#
    </cfoutput>
    </cfmail>
    <cfschedule action="delete" task="#scheduleID#">
    <!--- Delete the schedule.--->
    <cflog text="A total of #data.recordcount# records for #scheduleID# where imported successfully." log="application" type="information" file="importData">
	</cfif>
    </cfif>
    <!---Run garbage collection.--->
    <cfset runtime = CreateObject("java", "java.lang.Runtime").getRuntime()>
	<cfset runtime.gc()>
    <!--- Delete the DSN.--->
    <cfinvoke 
    component="cfc.api"
    method="getCFAdminAPI"
    returnvariable="rs">
    <cfinvokeargument name="args" value="importID#iID#"/>
    <cfinvokeargument name="apiFunction" value="datasource"/>
    <cfinvokeargument name="apiMethod" value="deleteDatasource"/>
    </cfinvoke>
    </cfthread>
    <cfcatch type="any">
    <cflog text="An error occurred importing #ARGUMENTS.iName#. #CFCATCH.Message# | #CFCATCH.Detail#" log="application" type="error" file="import#Replace(ARGUMENTS.iName, ' ', '', 'ALL')#Failure">
	<cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_import SET
	iDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    isID = <cfqueryparam cfsqltype="cf_sql_integer" value="3">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.iID#">
    </cfquery>
    <cfset result.message = "There was an error importing the record(s). Please advise an Administrator see the server logs for more information.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    
    <cffunction name="getExcelFile" access="public" output="true" returntype="any">
    <cfargument name="iID" type="numeric" required="yes" default="0">
    <cfargument name="itSheetName" required="true" type="string" />
	<cfargument name="filePath" required="true" type="string" />
	
	<cfset importQueryName = 'importID#ARGUMENTS.iID#'>
	<cfset importQueryNameResult = 'importID#ARGUMENTS.iID#Data'>
	<cfset sql = "SELECT * FROM #importQueryName#">
	<cfset importFilePath = ARGUMENTS.filePath>
	
	<cfspreadsheet action="read" query="#importQueryName#" src="#importFilePath#" sheetname="#itSheetName#" headerrow="1" excludeheaderrow="1">
	
    <cfquery name="#importQueryNameResult#" dbtype="query">
    #PreserveSingleQuotes(sql)#
    </cfquery>
  
    <cfreturn Evaluate('#importQueryNameResult#') />
    </cffunction>
</cfcomponent>