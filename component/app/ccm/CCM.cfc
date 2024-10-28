<cfcomponent>
    <cffunction name="getCCMIdentifier" access="public" returntype="query" hint="Get CCM Identifier data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ccmiID" type="string" required="yes" default="">
    <cfargument name="ccmiName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="altDeptNo" type="string" required="yes" default="0">
    <cfargument name="msID" type="numeric" required="yes" default="0">
    <cfargument name="ccmiStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ccmiSort, ccmiName">
    <cfset var rsCCMIdentifier = "" >
    <cftry>
    <cfquery name="rsCCMIdentifier" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ccm_identifier WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ccmiID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ccmiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ccmiName NEQ "">
    AND UPPER(ccmiName) = <cfqueryparam value="#UCASE(ARGUMENTS.ccmiName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ccmiID NEQ ''>
    AND ccmiID = <cfqueryparam value="#ARGUMENTS.ccmiID#" cfsqltype="cf_sql_string">
    </cfif>
    <cfif ARGUMENTS.msID NEQ 0>
    AND msID = <cfqueryparam value="#ARGUMENTS.msID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.altDeptNo NEQ 0>
    AND altDeptNo IN (<cfqueryparam value="#ARGUMENTS.altDeptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND ccmiStatus IN (<cfqueryparam value="#ARGUMENTS.ccmiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCCMIdentifier = StructNew()>
    <cfset rsCCMIdentifier.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCCMIdentifier>
    </cffunction>
    
    <cffunction name="getCCMIdentifierType" access="public" returntype="query" hint="Get CCM Identifier Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ccmitName" type="string" required="yes" default="">
    <cfargument name="ccmitStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ccmitSort, ccmitName">
    <cfset var rsCCMIdentifierType = "" >
    <cftry>
    <cfquery name="rsCCMIdentifierType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ccm_identifier_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ccmitName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ccmitName NEQ "">
    AND UPPER(ccmitName) = <cfqueryparam value="#UCASE(ARGUMENTS.ccmitName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ccmitStatus IN (<cfqueryparam value="#ARGUMENTS.ccmitStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCCMIdentifierType = StructNew()>
    <cfset rsCCMIdentifierType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCCMIdentifierType>
    </cffunction>
    
    <cffunction name="getCCMCountSchedule" access="public" returntype="query" hint="Get CCM Count Schedule data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ccmiIDPK" type="numeric" required="yes" default="0">
    <cfargument name="mfID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="altDeptNo" type="string" required="yes" default="99">
    <cfargument name="weekID" type="numeric" required="yes" default="0">
    <cfargument name="yearID" type="numeric" required="yes" default="0">
    <cfargument name="ccmcsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ccmcsSort, ccmiName">
    <cfset var rsCCMCountSchedule = "" >
    <cftry>
    <cfquery name="rsCCMCountSchedule" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ccm_count_schedule WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ccmiID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ccmiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ccmiIDPK NEQ 0>
    AND ccmiIDPK = <cfqueryparam value="#ARGUMENTS.ccmiIDPK#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.mfID NEQ 0>
    AND mfID = <cfqueryparam value="#ARGUMENTS.mfID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.altDeptNo NEQ 99>
    AND altDeptNo IN (<cfqueryparam value="#ARGUMENTS.altDeptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.weekID NEQ 0>
    AND weekID = <cfqueryparam value="#ARGUMENTS.weekID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.yearID NEQ 0>
    AND yearID = <cfqueryparam value="#ARGUMENTS.yearID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ccmcsStatus IN (<cfqueryparam value="#ARGUMENTS.ccmcsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCCMCountSchedule = StructNew()>
    <cfset rsCCMCountSchedule.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCCMCountSchedule>
    </cffunction>
    
    <cffunction name="getCCMSiteCount" access="public" returntype="query" hint="Get CCM Site Count data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ccmiIDPK" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="altDeptNo" type="string" required="yes" default="0">
    <cfargument name="weekID" type="numeric" required="yes" default="0">
    <cfargument name="yearID" type="numeric" required="yes" default="0">
    <cfargument name="ccmscDate" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="ccmscStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ccmiName">
    <cfset var rsCCMSiteCount = "" >
    <cftry>
    <cfquery name="rsCCMSiteCount" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ccm_site_count WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ccmiID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ccmiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ccmiIDPK NEQ 0>
    AND ccmiIDPK = <cfqueryparam value="#ARGUMENTS.ccmiIDPK#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.altDeptNo NEQ 0>
    AND altDeptNo IN (<cfqueryparam value="#ARGUMENTS.altDeptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.weekID NEQ 0>
    AND weekID = <cfqueryparam value="#ARGUMENTS.weekID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.yearID NEQ 0>
    AND yearID = <cfqueryparam value="#ARGUMENTS.yearID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ccmscStatus IN (<cfqueryparam value="#ARGUMENTS.ccmscStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCCMSiteCount = StructNew()>
    <cfset rsCCMSiteCount.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCCMSiteCount>
    </cffunction>
    
    <cffunction name="getCCMIdentifierReport" access="public" returntype="query" hint="Get CCM Identifier Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ccmiName">
    <cfset var rsCCMIdentifierReport = "" >
    <cftry>
    <cfquery name="rsCCMIdentifierReport" datasource="#application.mcmsDSN#">
    SELECT ccmiID, ccmiName, TO_CHAR(ccmiDate, 'MM/DD/YYYY') AS ccmiDate, deptNo, deptName AS Department, altDeptNo, altDeptName AS Alt_Department, msID, ccmiTolerance, sortName, sName AS Status FROM v_ccm_identifier WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ccmiID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ccmiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCCMIdentifierReport = StructNew()>
    <cfset rsCCMIdentifierReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCCMIdentifierReport>
    </cffunction>
    
    <cffunction name="getCCMCountScheduleReport" access="public" returntype="query" hint="Get CCM Count Schedule Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ccmiName">
    <cfset var rsCCMCountScheduleReport = "" >
    <cftry>
    <cfquery name="rsCCMCountScheduleReport" datasource="#application.mcmsDSN#">
    SELECT ccmiID, ccmiName, TO_CHAR(ccmiDate, 'MM/DD/YYYY') AS ccmiDate, deptNo, deptName AS Department, altDeptNo, altDeptName AS Alt_Department, msID AS Section, ccmiTolerance, mfID AS Fixture, weekID AS Week, yearID AS Year, sortName AS Sort, sName AS Status FROM v_ccm_count_schedule WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ccmiID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ccmiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND altDeptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND weekID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND yearID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCCMCountScheduleReport = StructNew()>
    <cfset rsCCMCountScheduleReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCCMCountScheduleReport>
    </cffunction>
    
    <cffunction name="getCCMCSExcelQuickReport" access="public" returntype="query" hint="Get CCM Count Schedule Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ccmcsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo, ccmiid">
    <cfset var getCCMCSExcelQuickReport = "" >
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getWeekIDList"
    returnvariable="getWeekIDListRet">
    <cfinvokeargument name="startDate" value="#DateFormat(Now(), 'mm/dd/yyyy')#"/>
    <cfinvokeargument name="startYear" value="#Year(Now())#"/>
    <cfinvokeargument name="startMonth" value="1"/>
    <cfinvokeargument name="startDay" value="1"/>
    <cfinvokeargument name="totalWeeks" value="52"/>
    <cfinvokeargument name="filterRange" value="#application.ccmFilterWeekRange#"/>
    <cfinvokeargument name="filterCurrentWeek" value="true"/>
    </cfinvoke>
    <!---Special rule for returning counts based on the weekID and the yearID.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getYearByWeekID"
    returnvariable="yearID">
    <cfinvokeargument name="weekID" value="#getWeekIDListRet.currentWeek#"/>
    <cfinvokeargument name="filterRange" value="#application.ccmFilterWeekRange#"/>
    </cfinvoke>
    <cfquery name="getCCMCSExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT ccmiID, ccmiName, TO_CHAR(ccmiDate, 'MM/DD/YYYY') AS ccmiDate, deptNo, deptName AS Department, altDeptNo, altDeptName AS Alt_Department, msID AS Section, ccmiTolerance, mfID AS Fixture, weekID AS Week, yearID AS Year, sortName AS Sort, sName AS Status FROM v_ccm_count_schedule WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ccmiID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ccmiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND weekID = <cfqueryparam value="#getWeekIDListRet.currentWeek#" cfsqltype="cf_sql_integer">
    AND yearID = <cfqueryparam value="#yearID#" cfsqltype="cf_sql_integer">
    AND ccmcsStatus IN (<cfqueryparam value="#ARGUMENTS.ccmcsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getCCMCSExcelQuickReport = StructNew()>
    <cfset getCCMCSExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getCCMCSExcelQuickReport>
    </cffunction>
    
    <cffunction name="getCCMSiteCountReport" access="public" returntype="query" hint="Get CCM Site Count Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ccmiName">
    <cfset var rsCCMSiteCountReport = "" >
    <cftry>
    <cfquery name="rsCCMSiteCountReport" datasource="#application.mcmsDSN#">
    SELECT ccmiID, ccmiName, TO_CHAR(ccmscDate, 'MM/DD/YYYY') AS ccmscDate, siteNo, siteName AS Site, ccmscCountID, ccmscDiscrepancy, ccmscInitial, userFName || ' ' || userLName AS Username, deptNo, deptName AS Department, altDeptNo, altDeptName AS Alt_Department, msID AS Section, ccmiTolerance, mfID AS Fixture, weekID AS WeekID, yearID AS YearID, sName AS Status FROM v_ccm_site_count WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ccmiID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ccmiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    AND altDeptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    AND weekID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    AND yearID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCCMSiteCountReport = StructNew()>
    <cfset rsCCMSiteCountReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCCMSiteCountReport>
    </cffunction>
    
    <cffunction name="getYearByWeekID" hint="Gets the yearID based on which week was selected." access="public" returntype="string" output="false">
	<cfargument name="weekID" required="yes" default="1" type="numeric" hint="A numeric value for a month.">
    <cfargument name="filterRange" required="yes" default="4" type="numeric" hint="A numeric value for range of weeks.">
	<cfset var yearID = Year(Now())>
	<cfif Month(Now()) EQ 1>
    <cfset yearID = Year(Now())-1>
    </cfif>
	<cfreturn yearID>
	</cffunction>
    
    <cffunction name="getStartDate" hint="Gets the start date for the fiscal year." access="public" returntype="date" output="false">
	<cfargument name="startYear" required="yes" default="#Year(Now())#" type="numeric" hint="A 4 digit numeric value for year.">
    <cfargument name="startMonth" required="yes" default="#Month(Now())#" type="numeric" hint="A numeric value for a month.">
    <cfargument name="startDay" required="yes" default="1" type="numeric" hint="A numeric value for a week day.">
	<cfset var startDate = "" >
    <!--- Get the current month based on the current date. --->
    <cfset this.currentDate = CreateDate(ARGUMENTS.startYear,ARGUMENTS.startMonth,ARGUMENTS.startDay)>
    <!---Create fiscal year based on startMonth.--->
    <cfset yearDay = DayOfYear(this.currentDate)>
    <cfif IsLeapYear(this.currentDate)>
    <cfset leapYear = -29>
    <cfelse>
    <cfset leapYear = -28>
    </cfif>
    <cfset startDate = DateFormat(DateAdd('d', leapYear, this.currentDate), 'mm/dd/yyyy')>
	<cfreturn startDate>
	</cffunction>
    
    <cffunction name="getWeekIDList" hint="Generates a Week ID based on the fiscal year." access="public" returntype="any" output="false">
	<cfargument name="startDate" required="yes" default="#DateFormat(Now(), 'mm/dd/yyyy')#" type="date">
    <cfargument name="startYear" required="yes" default="#DateFormat(Now(), 'yyyy')#" type="numeric">
    <cfargument name="startMonth" required="yes" default="1" type="numeric">
    <cfargument name="startDay" required="yes" default="1" type="numeric">
    <cfargument name="totalWeeks" required="yes" default="52" type="numeric">
    <cfargument name="filterRange" required="yes" default="4" type="numeric">
    <cfargument name="filterCurrentWeek" required="yes" default="4" type="string" hint="To return the current week ID.">
    <!---Get the startWeek for this count cycle.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getStartDate"
    returnvariable="startDate">
    <cfinvokeargument name="startYear" value="#ARGUMENTS.startYear#"/>
    <cfinvokeargument name="startMonth" value="#ARGUMENTS.startMonth#"/>
    <cfinvokeargument name="startDay" value="#ARGUMENTS.startDay#"/>
    </cfinvoke>
    <!---Set the startDate.--->
    <cfset this.startDate = DateFormat(startDate, 'mm/dd/yyyy')>
    <cfset nowDate = DateFormat(Now(), 'mm/dd/yyyy')>
    <cfset startWeek = 0>
	<!---Filter range to see if the week is past the value to begin forward and reverse lookups once the condition has been met.--->
    <cfset beginDate = DateFormat(DateAdd('ww', ARGUMENTS.filterRange, this.startDate), 'mm/dd/yyyy')>
    <cfset weekID = DateDiff('ww', this.startDate, nowDate)>
    <cfset endWeek = DateDiff('ww', this.startDate, nowDate)>
    <cfset ARGUMENTS.totalWeeks = endWeek-startWeek+ARGUMENTS.filterRange>
    <!---Create the endDate which is the end of the week.--->
    <cfset endDate = DateFormat(DateAdd('d', 6, startDate), 'mm/dd/yyyy')>
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalWeeks)>
    <!---If the new fiscal has just begun.--->
    <cfloop index="id" from="1" to="#ARGUMENTS.totalWeeks#">
    <cfset startWeek = startWeek + 1>
    <cfset weekID = startWeek+43>
    <cfif weekID GT 52>
    <cfset weekID = startWeek-9>
    </cfif>
    <cfset beginCountDate = "#DateFormat(DateAdd('ww', '#startWeek-1#', '#this.startDate#'), 'mm/dd/yyyy')#">
    <cfset endCountDate = "#DateFormat(DateAdd('ww', '#startWeek-1#', '#endDate#'), 'mm/dd/yyyy')#">
    <cfset temp = QuerySetCell(myQuery, "Name", "#beginCountDate# - #endCountDate# (Wk. #weekID#)", id)>
    <cfset temp = QuerySetCell(myQuery, "Value", weekid, id)>
    <cfset result = StructNew()> 
	<cfset result.currentWeek = weekID-ARGUMENTS.filterRange+1>
    <cfset result.beginCountDate = beginCountDate>
    <cfset result.endCountDate = endCountDate>
    </cfloop>
    <cfif ARGUMENTS.filterCurrentWeek EQ true>
    <cfreturn result>
    <cfelse>
    <cfreturn myQuery>
    </cfif>
    </cffunction>
    
    <cffunction name="getSendReminderEmail" hint="Send an email to the parties responsible for receiving incomplete count reports." access="public" returntype="struct" output="false">
    <cfargument name="ID" required="yes" type="numeric" default="0">
    <cfargument name="urID" required="yes" type="string" default="0">
    <cfargument name="siteNo" required="yes" type="numeric" default="0">
    <cfargument name="deptNo" required="yes" type="string" default="0">
    <cfargument name="altDeptNo" required="yes" type="string" default="0">
    <cfargument name="weekID" required="yes" type="numeric" default="0">
    <cfargument name="yearID" required="yes" type="numeric" default="0">
    <cfset result.message = "You have successfully sent the reminder email.">
    <cftry>
    <!---Get users by deparment and site.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteDepartmentRel"
    returnvariable="getUserSiteDepartmentRelRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="0,#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSiteDepartmentRelRet.RecordCount NEQ 0>
    <cfset urEmail = ValueList(getUserSiteDepartmentRelRet.userEmail, ';')>
    <cfelse>
    <cfset urEmail = application.webmasterEmail>
    </cfif>
    <cfset reminderEmail = "#urEmail#">
    <!---Create email string for reminder email based on department.--->
    <cfinvoke 
    component="MCMS.component.app.department.Department"
    method="getDepartment"
    returnvariable="getDepartmentRet">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="deptStatus" value="1"/>
    </cfinvoke>
    <cfset reminderEmail = "#ARGUMENTS.siteNo#-#LCASE(getDepartmentRet.deptName)##application.exchangeUserSuffix#;#urEmail#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Cycle Count Reminder from #session.userName# for Week #ARGUMENTS.weekID#"/>
    <cfinvokeargument name="to" value="#reminderEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.weekID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ccm/view/inc_ccm_site_count_reminder_email_template.cfm"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error sending the discrepancy report.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getSendDiscrepancyEmail" hint="Send an email to the parties responsible for receiving disprecancy reports." access="public" returntype="void" output="false">
    <cfargument name="ID" required="yes" type="numeric" default="0">
    <cfargument name="ccmiID" required="yes" type="string" default="0">
    <cfargument name="urID" required="yes" type="string" default="0">
    <cfargument name="siteNo" required="yes" type="numeric" default="0">
    <cfargument name="deptNo" required="yes" type="string" default="0">
    <cfargument name="altDeptNo" required="yes" type="string" default="0">
    <cfset result.message = "You have successfully sent the discrepancy report.">
    <cftry>
    <!---Get users by deparment and site.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteDepartmentRel"
    returnvariable="getUserSiteDepartmentRelRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="0,#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSiteDepartmentRelRet.RecordCount NEQ 0>
    <cfset urEmail = ValueList(getUserSiteDepartmentRelRet.userEmail, ';')>
    <cfelse>
    <cfset urEmail = application.webmasterEmail>
    </cfif>
    <!---Create email string for discrepancy email.--->
    <cfinvoke 
    component="MCMS.component.app.department.Department"
    method="getDepartment"
    returnvariable="getDepartmentRet">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="deptStatus" value="1"/>
    </cfinvoke>
    <cfset discrepancyEmail = "#LCASE(getDepartmentRet.deptName)#discrepancies#application.exchangeUserSuffix#;#urEmail#;">
    <!---Create a special exception for firearms or Guns - altDeptNo = 17.--->
    <cfif ARGUMENTS.altDeptNo EQ 17> 
    <cfset discrepancyEmail = "#LCASE(getDepartmentRet.deptName)#discrepancies#application.exchangeUserSuffix#;atfcompliance#application.exchangeUserSuffix#;#urEmail#;">
    </cfif>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Cycle Count Manager Discrepancy Report - No. #ARGUMENTS.ccmiID#"/>
    <cfinvokeargument name="to" value="#discrepancyEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ccm/view/inc_ccm_site_count_email_template.cfm"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error sending the discrepancy report.">
    
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="insertCCMIdentifier" access="public" returntype="struct">
    <cfargument name="ccmiID" type="string" required="yes">
    <cfargument name="ccmiName" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="string" required="yes">
    <cfargument name="msID" type="numeric" required="yes">
    <cfargument name="ccmiTolerance" type="string" required="yes">
    <cfargument name="ccmitID" type="numeric" required="yes">
    <cfargument name="ccmiSort" type="numeric" required="yes">
    <cfargument name="ccmiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getCCMIdentifier"
    returnvariable="getCheckCCMIdentifierRet">
    <cfif ARGUMENTS.altDeptNo EQ 17>
    <cfinvokeargument name="ccmiName" value="#ARGUMENTS.ccmiName#"/>
    <cfelse>
    <cfinvokeargument name="ccmiID" value="#ARGUMENTS.ccmiID#"/>
    </cfif>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="altDeptNo" value="#ARGUMENTS.altDeptNo#"/>
    <cfinvokeargument name="ccmiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCCMIdentifierRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ccmiName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ccm_identifier (ccmiID,ccmiName,deptNo,altDeptNo,msID,ccmiTolerance,ccmitID,ccmiSort,ccmiStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ccmiID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ccmiName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.ccmiTolerance#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmitID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiStatus#">
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
    
    <cffunction name="insertCCMCountSchedule" access="public" returntype="struct">
    <cfargument name="ccmiIDPK" type="numeric" required="yes">
    <cfargument name="mfID" type="numeric" required="yes">
    <cfargument name="weekID" type="numeric" required="yes">
    <cfargument name="yearID" type="numeric" required="yes">
    <cfargument name="ccmcsSort" type="numeric" required="yes">
    <cfargument name="ccmcsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getCCMCountSchedule"
    returnvariable="getCheckCCMCountScheduleRet">
    <cfinvokeargument name="ccmiIDPK" value="#ARGUMENTS.ccmiIDPK#"/>
    <cfinvokeargument name="weekID" value="#ARGUMENTS.weekID#"/>
    <cfinvokeargument name="yearID" value="#ARGUMENTS.yearID#"/>
    <cfinvokeargument name="ccmcsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCCMCountScheduleRet.recordcount NEQ 0>
    <cfset result.message = "The count schedule for #getCheckCCMCountScheduleRet.ccmiID# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ccm_count_schedule (ccmiIDPK,mfID,weekID,yearID,ccmcsSort,ccmcsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiIDPK#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.weekID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.yearID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmcsSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmcsStatus#">
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
    
    <cffunction name="insertCCMCountScheduleImport" access="public" returntype="struct">
    <cfargument name="ccmiID" type="string" required="yes">
    <cfargument name="weekID" type="numeric" required="yes">
    <cfargument name="yearID" type="numeric" required="yes">
    <cfargument name="mfID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="ccmiName" type="string" required="yes" default="">
    <cfset result.message = "You have successfully inserted the record(s).">
    <cftry>
    <!---Get the ID for the ccmiID.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getCCMIdentifier"
    returnvariable="getCCMIdentifierRet">
    <cfinvokeargument name="ccmiID" value="#ARGUMENTS.ccmiID#"/>
    <cfinvokeargument name="ccmiName" value="#ARGUMENTS.ccmiName#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="altDeptNo" value="#ARGUMENTS.altDeptNo#"/>
    <cfinvokeargument name="ccmiStatus" value="1,2,3"/>
    </cfinvoke>
    <!---If the identifier does not exist do not proceed.--->
    <cfif getCCMIdentifierRet.recordcount NEQ 0>
    <cfset ccmiIDPK = getCCMIdentifierRet.ID>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getCCMCountSchedule"
    returnvariable="getCheckCCMCountScheduleRet">
    <cfinvokeargument name="ccmiIDPK" value="#ccmiIDPK#"/>
    <cfinvokeargument name="weekID" value="#ARGUMENTS.weekID#"/>
    <cfinvokeargument name="yearID" value="#ARGUMENTS.yearID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ccmcsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCCMCountScheduleRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ccm_count_schedule (ccmiIDPK,mfID,weekID,yearID,ccmcsSort,ccmcsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ccmiIDPK#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.weekID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.yearID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertCCMSiteCountList" access="public" returntype="struct">
    <cfargument name="ccmiIDPK" type="numeric" required="yes">
    <cfargument name="ccmiID" type="string" required="yes">
    <cfargument name="ccmcsID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="weekID" type="numeric" required="yes">
    <cfargument name="yearID" type="numeric" required="yes">
    <cfargument name="ccmscCountID" type="string" required="yes">
    <cfargument name="ccmscDiscrepancy" type="string" required="yes">
    <cfargument name="ccmscInitial" type="string" required="yes">
    <cfargument name="ccmiTolerance" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="ccmscStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully completed the count(s).">
    <!---<cftry>--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ccm_site_count (ccmcsID,ccmiIDPK,siteNo,weekID,yearID,ccmscCountID,ccmscDiscrepancy,ccmscInitial,userID,ccmscStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmcsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiIDPK#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.weekID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.yearID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ccmscCountID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.ccmscDiscrepancy#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ccmscInitial#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmscStatus#">
    )
    </cfquery>
    <!---Send email notification is the discrepancy is greater than tolerance.--->
    <!---Set the tolerance amount to a negitive first.--->
    <cfset ARGUMENTS.ccmiToleranceNeg = '-' & ARGUMENTS.ccmiTolerance>
    <cfif ARGUMENTS.ccmscDiscrepancy LT ARGUMENTS.ccmiToleranceNeg OR ARGUMENTS.ccmscDiscrepancy GT ARGUMENTS.ccmiTolerance>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="ccmscID">
    <cfinvokeargument name="tableName" value="tbl_ccm_site_count"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getSendDiscrepancyEmail"
    returnvariable="getSendDiscrepancyEmailRet">
    <cfinvokeargument name="ID" value="#ccmscID#"/>
    <cfinvokeargument name="ccmiID" value="#ARGUMENTS.ccmiID#"/>
    <cfinvokeargument name="urID" value="#application.ccmDiscrepancyEmailUserRole#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#,#application.ccmDiscrepancyEmailUserDeptList#"/>
    <cfinvokeargument name="altDeptNo" value="#ARGUMENTS.altDeptNo#"/>
    </cfinvoke>
    </cfif>
    </cftransaction>
    <!---
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCCMIdentifier" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ccmiID" type="string" required="yes">
    <cfargument name="ccmiName" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="string" required="yes">
    <cfargument name="msID" type="numeric" required="yes">
    <cfargument name="ccmiTolerance" type="string" required="yes">
    <cfargument name="ccmitID" type="numeric" required="yes">
    <cfargument name="ccmiSort" type="numeric" required="yes">
    <cfargument name="ccmiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getCCMIdentifier"
    returnvariable="getCheckCCMIdentifierRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfif ARGUMENTS.altDeptNo EQ 17>
    <cfinvokeargument name="ccmiName" value="#ARGUMENTS.ccmiName#"/>
    <cfelse>
    <cfinvokeargument name="ccmiID" value="#ARGUMENTS.ccmiID#"/>
    </cfif>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="altDeptNo" value="#ARGUMENTS.altDeptNo#"/>
    <cfinvokeargument name="ccmiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCCMIdentifierRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ccmiName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ccm_identifier SET
    ccmiID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ccmiID#">,
    ccmiName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ccmiName#">,
    ccmiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
	deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    altDeptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    msID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msID#">,
    ccmiTolerance = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.ccmiTolerance#">,
    ccmitID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmitID#">,
    ccmiSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiSort#">,
    ccmiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiStatus#">
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
    
    <cffunction name="updateCCMCountSchedule" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ccmiIDPK" type="numeric" required="yes">
    <cfargument name="mfID" type="numeric" required="yes">
    <cfargument name="weekID" type="numeric" required="yes">
    <cfargument name="yearID" type="string" required="yes">
    <cfargument name="ccmcsSort" type="numeric" required="yes">
    <cfargument name="ccmcsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ccm.CCM"
    method="getCCMCountSchedule"
    returnvariable="getCheckCCMCountScheduleRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ccmiIDPK" value="#ARGUMENTS.ccmiIDPK#"/>
    <cfinvokeargument name="weekID" value="#ARGUMENTS.weekID#"/>
    <cfinvokeargument name="yearID" value="#ARGUMENTS.yearID#"/>
    <cfinvokeargument name="ccmcsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCCMCountScheduleRet.recordcount NEQ 0>
    <cfset result.message = "The count schedule for #getCheckCCMCountScheduleRet.ccmiID# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ccm_count_schedule SET
    ccmiIDPK = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiIDPK#">,
    ccmcsDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    mfID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfID#">,
    weekID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.weekID#">,
    yearID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.yearID#">,
    ccmcsSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmcsSort#">,
    ccmcsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmcsStatus#">
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
    
    <cffunction name="updateCCMIdentifierList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ccmiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ccm_identifier SET
    ccmiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmiStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCCMCountScheduleList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ccmcsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ccm_count_schedule SET
    ccmcsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ccmcsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCCMIdentifier" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ccm_identifier
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteCCMCountSchedule" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ccm_count_schedule
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCCMSiteCount" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ccm_site_count
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