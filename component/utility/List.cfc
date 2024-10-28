<cfcomponent>
    <cffunction name="getYesNoList" access="public" returntype="query" hint="List of Yes/No.">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset totalCount = 2>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "Yes", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", 1, 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "No", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", 0, 2)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getTrueFalseList" access="public" returntype="query" hint="List of True/False.">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset totalCount = 2>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "True", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", 0, 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "False", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", 1, 2)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getURLTarget" access="public" returntype="query" hint="List of web link target options.">
    <cfset myQuery = QueryNew("Name, Value", "varchar, varchar")>
    <cfset totalCount = 2>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "New Window", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", "_blank", 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "This Window", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", "_parent", 2)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getHalfSecondList" access="public" returntype="query" hint="List of Half Seconds.">
    <cfargument name="totalCount" type="numeric" default="20">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, double")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="#ARGUMENTS.startCount#" to="#ARGUMENTS.totalCount#">
    <cfif i EQ 1>
    <cfset temp = QuerySetCell(myQuery, "Name", "None", i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Name", i-1.5, i)>
    </cfif>
    <cfset temp = QuerySetCell(myQuery, "Value", i-1.5, i)>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getScaleList" access="public" returntype="query" hint="List of Scale X/Y.">
    <cfargument name="totalCount" type="numeric" default="40">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="#ARGUMENTS.startCount#" to="#ARGUMENTS.totalCount#">
    <cfset temp = QuerySetCell(myQuery, "Name", i*10-20, i)>
    <cfset temp = QuerySetCell(myQuery, "Value", i*10-20, i)>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getNumericList" access="public" returntype="query" hint="List of Numbers.">
    <cfargument name="totalCount" type="numeric" default="10">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="#ARGUMENTS.startCount#" to="#ARGUMENTS.totalCount#">
    <cfset temp = QuerySetCell(myQuery, "Name", i, i)>
    <cfset temp = QuerySetCell(myQuery, "Value", i, i)>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getPercentNumericList" access="public" returntype="query" hint="List of Numbers in Percentage.">
    <cfargument name="totalCount" type="numeric" default="11">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="#ARGUMENTS.startCount#" to="#ARGUMENTS.totalCount#">
    <cfif i EQ 1>
    <cfset temp = QuerySetCell(myQuery, "Name", "None", i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Name", i*10-10 & '%', i)>
    </cfif>
    <cfset temp = QuerySetCell(myQuery, "Value", i-1, i)>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getPercentList" access="public" returntype="query" hint="List of Percentages.">
    <cfargument name="totalCount" type="numeric" default="11">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="#ARGUMENTS.startCount#" to="#ARGUMENTS.totalCount#">
    <cfif i EQ 1>
    <cfset temp = QuerySetCell(myQuery, "Name", "None", i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Name", i*10-10 & '%', i)>
    </cfif>
    <cfif i EQ ARGUMENTS.totalCount>
    <cfset temp = QuerySetCell(myQuery, "Value", "100", i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Value", "#RIGHT('#i#*10-10', 2)#", i)>
    </cfif>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getFloatList" access="public" returntype="query" hint="List of Float values 0.1 - 1.">
    <cfargument name="totalCount" type="numeric" default="11">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, varchar")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="#ARGUMENTS.startCount#" to="#ARGUMENTS.totalCount#">
    <cfif i EQ 1>
    <cfset temp = QuerySetCell(myQuery, "Name", "None", i)>
    <cfelseif i GT 10>
    <cfset temp = QuerySetCell(myQuery, "Name", i-10, i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Name", "#RIGHT('0.#i-1#', 2)#", i)>
    </cfif>
    <cfif i EQ 1>
    <cfset temp = QuerySetCell(myQuery, "Value", 0, i)>
    <cfelseif i GT 10>
    <cfset temp = QuerySetCell(myQuery, "Value", i-10, i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Value", "#RIGHT('0.#i-1#', 2)#", i)>
    </cfif>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getPercentFloatList" access="public" returntype="query" hint="List of Percent Float values 0.1 - 1.">
    <cfargument name="totalCount" type="numeric" default="11">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, varchar")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="#ARGUMENTS.startCount#" to="#ARGUMENTS.totalCount#">
    <cfif i EQ 1>
    <cfset temp = QuerySetCell(myQuery, "Name", "None", i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Name", i*10-10 & '%', i)>
    </cfif>
    <cfif i EQ ARGUMENTS.totalCount>
    <cfset temp = QuerySetCell(myQuery, "Value", "1", i)>
    <cfelse>
    <cfset temp = QuerySetCell(myQuery, "Value", "#RIGHT('0.#i-1#', 2)#", i)>
    </cfif>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getLowHighList" access="public" returntype="query" hint="List of Low - High values 0, 5, 10">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset totalCount = 3>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "Low", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", "0", 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "Medium", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", "5", 2)>
    <cfset temp = QuerySetCell(myQuery, "Name", "High", 3)>
    <cfset temp = QuerySetCell(myQuery, "Value", "10", 3)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getDistanceList" access="public" returntype="query" hint="List of Distance in Miles.">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset totalCount = 9>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "Any miles", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", 0, 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "5 miles", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", 5, 2)>
    <cfset temp = QuerySetCell(myQuery, "Name", "10 miles", 3)>
    <cfset temp = QuerySetCell(myQuery, "Value", 10, 3)>
    <cfset temp = QuerySetCell(myQuery, "Name", "25 miles", 4)>
    <cfset temp = QuerySetCell(myQuery, "Value", 25, 4)>
    <cfset temp = QuerySetCell(myQuery, "Name", "50 miles", 5)>
    <cfset temp = QuerySetCell(myQuery, "Value", 50, 5)>
    <cfset temp = QuerySetCell(myQuery, "Name", "75 miles", 6)>
    <cfset temp = QuerySetCell(myQuery, "Value", 75, 6)>
    <cfset temp = QuerySetCell(myQuery, "Name", "100 miles", 7)>
    <cfset temp = QuerySetCell(myQuery, "Value", 100, 7)>
    <cfset temp = QuerySetCell(myQuery, "Name", "150 miles", 8)>
    <cfset temp = QuerySetCell(myQuery, "Value", 150, 8)>
    <cfset temp = QuerySetCell(myQuery, "Name", "200 miles", 9)>
    <cfset temp = QuerySetCell(myQuery, "Value", 200, 9)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getFontSizeList" access="public" returntype="query" hint="List of Font Sizes.">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset totalCount = 13>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "None", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", 0, 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "9pt", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", 9, 2)>
    <cfset temp = QuerySetCell(myQuery, "Name", "10pt", 3)>
    <cfset temp = QuerySetCell(myQuery, "Value", 10, 3)>
    <cfset temp = QuerySetCell(myQuery, "Name", "12pt", 4)>
    <cfset temp = QuerySetCell(myQuery, "Value", 12, 4)>
    <cfset temp = QuerySetCell(myQuery, "Name", "14pt", 5)>
    <cfset temp = QuerySetCell(myQuery, "Value", 14, 5)>
    <cfset temp = QuerySetCell(myQuery, "Name", "16pt", 6)>
    <cfset temp = QuerySetCell(myQuery, "Value", 16, 6)>
    <cfset temp = QuerySetCell(myQuery, "Name", "18pt", 7)>
    <cfset temp = QuerySetCell(myQuery, "Value", 18, 7)>
    <cfset temp = QuerySetCell(myQuery, "Name", "21pt", 8)>
    <cfset temp = QuerySetCell(myQuery, "Value", 21, 8)>
    <cfset temp = QuerySetCell(myQuery, "Name", "24pt", 9)>
    <cfset temp = QuerySetCell(myQuery, "Value", 24, 9)>
    <cfset temp = QuerySetCell(myQuery, "Name", "27pt", 10)>
    <cfset temp = QuerySetCell(myQuery, "Value", 27, 10)>
    <cfset temp = QuerySetCell(myQuery, "Name", "32pt", 11)>
    <cfset temp = QuerySetCell(myQuery, "Value", 32, 11)>
    <cfset temp = QuerySetCell(myQuery, "Name", "36pt", 12)>
    <cfset temp = QuerySetCell(myQuery, "Value", 36, 12)>
    <cfset temp = QuerySetCell(myQuery, "Name", "42pt", 13)>
    <cfset temp = QuerySetCell(myQuery, "Value", 42, 13)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getAngleList" access="public" returntype="query" hint="List of Angles.">
    <cfset myQuery = QueryNew("Name, Value", "varchar, varchar")>
    <cfset totalCount = 16>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "0&deg;", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", 0, 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "22.5&deg;", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", 22.5, 2)>
    <cfset temp = QuerySetCell(myQuery, "Name", "45&deg;", 3)>
    <cfset temp = QuerySetCell(myQuery, "Value", 45, 3)>
    <cfset temp = QuerySetCell(myQuery, "Name", "67.5&deg;", 4)>
    <cfset temp = QuerySetCell(myQuery, "Value", 67.5, 4)>
    <cfset temp = QuerySetCell(myQuery, "Name", "90&deg;", 5)>
    <cfset temp = QuerySetCell(myQuery, "Value", 90, 5)>
    <cfset temp = QuerySetCell(myQuery, "Name", "112.5&deg;", 6)>
    <cfset temp = QuerySetCell(myQuery, "Value", 112.5, 6)>
    <cfset temp = QuerySetCell(myQuery, "Name", "135&deg;", 7)>
    <cfset temp = QuerySetCell(myQuery, "Value", 135, 7)>
    <cfset temp = QuerySetCell(myQuery, "Name", "157.5&deg;", 8)>
    <cfset temp = QuerySetCell(myQuery, "Value", 157.5, 8)>
    <cfset temp = QuerySetCell(myQuery, "Name", "180&deg;", 9)>
    <cfset temp = QuerySetCell(myQuery, "Value", 180, 9)>
    <cfset temp = QuerySetCell(myQuery, "Name", "202.5&deg;", 10)>
    <cfset temp = QuerySetCell(myQuery, "Value", 202.5, 10)>
    <cfset temp = QuerySetCell(myQuery, "Name", "225&deg;", 11)>
    <cfset temp = QuerySetCell(myQuery, "Value", 225, 11)>
    <cfset temp = QuerySetCell(myQuery, "Name", "247.5&deg;", 12)>
    <cfset temp = QuerySetCell(myQuery, "Value", 247.5, 12)>
    <cfset temp = QuerySetCell(myQuery, "Name", "270&deg;", 13)>
    <cfset temp = QuerySetCell(myQuery, "Value", 270, 13)>
    <cfset temp = QuerySetCell(myQuery, "Name", "292.5&deg;", 14)>
    <cfset temp = QuerySetCell(myQuery, "Value", 292.5, 14)>
    <cfset temp = QuerySetCell(myQuery, "Name", "315&deg;", 15)>
    <cfset temp = QuerySetCell(myQuery, "Value", 315, 15)>
    <cfset temp = QuerySetCell(myQuery, "Name", "337.5&deg;", 16)>
    <cfset temp = QuerySetCell(myQuery, "Value", 337.5, 16)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getFiscalYearByWeekList" access="public" returntype="query" hint="List of Weeks by Fiscal Year to begin Sundays.">
    <cfargument name="fiscalMonthStart" type="numeric" default="1" required="yes" hint="Month to Begin new fiscal year.">
    <cfargument name="fiscalYear" type="numeric" default="#Year(Now())#" required="yes" hint="The year to begin.">
    <cfargument name="fiscalWeekRange" type="numeric" default="1" required="yes" hint="Number of week in range from 52 backward.">
    <cfargument name="fiscalWeekRangeForward" type="numeric" default="4" required="yes" hint="Number of week in range from 52 forward.">
    <!---Get the first week for the fiscal year.--->
    <cfset this.fiscalStartDate = DateFormat(ARGUMENTS.fiscalMonthStart & '/' & 1 & '/' & ARGUMENTS.fiscalYear, 'mm/dd/yyyy')>
    <!---Find the first Sunday of the month.--->
    <cfset this.fiscalStartDayOfWeek = DayOfWeek(this.fiscalStartDate)>
    <cfset this.startDay = 8-DayOfWeek(this.fiscalStartDate)>
    <!---Find the first week start and end dates for the fiscal year.--->
    <cfset this.fiscalStartWeekDay = DateFormat(DateAdd('d', this.startDay, this.fiscalStartDate), 'mm/dd/yyyy')>
    <cfset this.fiscalEndWeekDay = DateFormat(DateAdd('d', 6, this.fiscalStartWeekDay), 'mm/dd/yyyy')>
    <!---Create a query to return results.--->
    <cfset myQuery = QueryNew("ID, startDate, endDate, weekID, yearID", "integer, varchar, varchar, integer, integer")>
    <!--- Make rows for the query. --->
    <cfset newRow = QueryAddRow(myQuery, 52*2)>
    <!---Begin creation of the query.--->
    <cfset startDate = this.fiscalStartWeekDay>
    <cfset endDate = this.fiscalEndWeekDay>
    <cfset weekID = 0>
    <cfset yearID = ARGUMENTS.fiscalYear>
     <!---Get the current week based on non-fiscal year.--->
    <cfset currentWeek = Week(Now())>
    <!---Calculate the differnce between a fiscal week and a none fiscal week number.--->
    <cfset weekRangeMid = currentWeek - DateDiff('ww', '01/01/#Year(this.fiscalStartWeekDay)#', this.fiscalStartWeekDay)>
    <!---Filter by range using endRow and beginRow.--->
    <cfset endRow = (52+weekRangeMid)+ARGUMENTS.fiscalWeekRangeForward>
    <cfset beginRow = (endRow-ARGUMENTS.fiscalWeekRange)-ARGUMENTS.fiscalWeekRange>
    <!---Create Week ID's based on fiscal year.--->
    <cfloop index="i" from="1" to="#52*2#">
    <cfif weekID GT 51>
    <cfset weekID = 0>
    <cfset yearID = yearID+1>
    </cfif>
    <cfset weekID = weekID+1>
    <cfif i GT 1>
    <cfset startDate = DateFormat(DateAdd('d', 7, startDate), 'mm/dd/yyyy')>
    <cfset endDate = DateFormat(DateAdd('d', 7, endDate), 'mm/dd/yyyy')>
    </cfif>
    <!--- Set the values of the cells in the query --->
    <cfset temp = QuerySetCell(myQuery, "ID", i, i)>
	<cfset temp = QuerySetCell(myQuery, "startDate", startDate, i)>
    <cfset temp = QuerySetCell(myQuery, "endDate", endDate, i)>
    <cfset temp = QuerySetCell(myQuery, "weekID", weekID, i)>
    <cfset temp = QuerySetCell(myQuery, "yearID", yearID, i)>
    </cfloop>
    <cfquery name="myQuery" dbtype="query">
    SELECT * FROM myQuery WHERE 0=0
    AND ID >= <cfqueryparam value="#beginRow#" cfsqltype="cf_sql_integer">
    AND ID <= <cfqueryparam value="#endRow#" cfsqltype="cf_sql_integer"> 
    ORDER BY yearID, weekID
    </cfquery>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getCountry" access="public" returntype="query" hint="Get a list of countries.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="cntryName" type="string" required="yes" default="">
    <cfargument name="cntryAbbreviation" type="string" required="yes" default="">
    <cfargument name="cntryStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cntryName">
    <cfset var rsCountry = "" >
    <cftry>
    <cfquery name="rsCountry" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_country WHERE 0 = 0 
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND cntryName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.cntryName NEQ "">
    AND cntryName = <cfqueryparam value="#ARGUMENTS.cntryName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cntryAbbreviation NEQ "">
    AND cntryAbbreviation = <cfqueryparam value="#ARGUMENTS.cntryAbbreviation#" cfsqltype="cf_sql_varchar">	  
    </cfif>
    AND cntryStatus IN (<cfqueryparam value="#ARGUMENTS.cntryStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCountry = StructNew()>
    <cfset rsCountry.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCountry>
    </cffunction>
    
    <cffunction name="getStateProv" access="public" returntype="query" hint="Get a list State Prov's.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cntryID" type="numeric" required="yes" default="0">
    <cfargument name="spName" type="string" required="yes" default="">
    <cfargument name="spStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="spName">
    <cfset var rsStateProv = "" >
    <cftry>
    <cfquery name="rsStateProv" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_state_prov WHERE 0 = 0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(spName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cntryID NEQ 0>
    AND cntryID IN (<cfqueryparam value="#ARGUMENTS.cntryID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.spName NEQ "">
    AND UPPER(spName) = <cfqueryparam value="#UCASE(ARGUMENTS.spName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND spStatus IN (<cfqueryparam value="#ARGUMENTS.spStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsStateProv = StructNew()>
    <cfset rsStateProv.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsStateProv>
    </cffunction>
    
    <cffunction name="getDay" access="public" returntype="query" hint="Get a list of Days.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dayStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="daySort">
    <cfset var rsDay = "" >
    <cftry>
    <cfquery name="rsDay" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_day WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    AND dayStatus IN (<cfqueryparam value="#ARGUMENTS.dayStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDay = StructNew()>
    <cfset rsDay.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDay>
    </cffunction>
    
    <cffunction name="getSQLVerb" access="public" returntype="query" hint="Get a list of SQL Verbs.">
    <cfargument name="sqlvStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="daySort">
    <cfset var rsSQLVerb = "" >
    <cftry>
    <cfquery name="rsSQLVerb" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_sql_verb WHERE 0=0
    AND sqlvStatus IN (<cfqueryparam value="#ARGUMENTS.sqlvStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSQLVerb = StructNew()>
    <cfset rsSQLVerb.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSQLVerb>
    </cffunction>
    
    <cffunction name="getDataType" access="public" returntype="query" hint="Get a list of Data Types.">
    <cfargument name="dtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dtName">
    <cfset var rsDataType = "" >
    <cftry>
    <cfquery name="rsDataType" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_data_type WHERE 0=0
    AND dtStatus IN (<cfqueryparam value="#ARGUMENTS.dtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDataType = StructNew()>
    <cfset rsDataType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDataType>
    </cffunction>
    
    <cffunction name="getDataTypeFormat" access="public" returntype="query" hint="Get a list of Data Type Formats.">
    <cfargument name="dtfStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dtfName">
    <cfset var rsDataTypeFormat = "" >
    <cftry>
    <cfquery name="rsDataTypeFormat" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_data_type_format WHERE 0=0
    AND dtfStatus IN (<cfqueryparam value="#ARGUMENTS.dtfStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDataTypeFormat = StructNew()>
    <cfset rsDataTypeFormat.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDataTypeFormat>
    </cffunction>
    
    <cffunction name="getMonth" access="public" returntype="query" hint="Get a list of Months.">
    <cfset myQuery = QueryNew("Name, Value")>
    <cfset totalCount = 12>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "January", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", 1, 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "February", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", 2, 2)>
    <cfset temp = QuerySetCell(myQuery, "Name", "March", 3)>
    <cfset temp = QuerySetCell(myQuery, "Value", 3, 3)>
    <cfset temp = QuerySetCell(myQuery, "Name", "April", 4)>
    <cfset temp = QuerySetCell(myQuery, "Value", 4, 4)>
    <cfset temp = QuerySetCell(myQuery, "Name", "May", 5)>
    <cfset temp = QuerySetCell(myQuery, "Value", 5, 5)>
    <cfset temp = QuerySetCell(myQuery, "Name", "June", 6)>
    <cfset temp = QuerySetCell(myQuery, "Value", 6, 6)>
    <cfset temp = QuerySetCell(myQuery, "Name", "July", 7)>
    <cfset temp = QuerySetCell(myQuery, "Value", 7, 7)>
    <cfset temp = QuerySetCell(myQuery, "Name", "August", 8)>
    <cfset temp = QuerySetCell(myQuery, "Value", 8, 8)>
    <cfset temp = QuerySetCell(myQuery, "Name", "September", 9)>
    <cfset temp = QuerySetCell(myQuery, "Value", 9, 9)>
    <cfset temp = QuerySetCell(myQuery, "Name", "October", 10)>
    <cfset temp = QuerySetCell(myQuery, "Value", 10, 10)>
    <cfset temp = QuerySetCell(myQuery, "Name", "November", 11)>
    <cfset temp = QuerySetCell(myQuery, "Value", 11, 11)>
    <cfset temp = QuerySetCell(myQuery, "Name", "December", 12)>
    <cfset temp = QuerySetCell(myQuery, "Value", 12, 12)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getYear" access="public" returntype="query" hint="Get a list of Years.">
    <cfargument name="totalCount" type="numeric" default="10">
    <cfargument name="startCount" type="numeric" default="1">
    <cfset myQuery = QueryNew("Name, Value", "varchar, integer")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="i" from="1" to="#ARGUMENTS.totalCount#">
    <cfset temp = QuerySetCell(myQuery, "Name", startCount+i, i)>
    <cfset temp = QuerySetCell(myQuery, "Value", startCount+i, i)>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getTime" access="public" returntype="query" hint="Get a list of Times.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="timeStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="timeSort">
    <cfset var rsTime = "" >
    <cftry>
    <cfquery name="rsTime" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_time WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    AND timeStatus IN (<cfqueryparam value="#ARGUMENTS.timeStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTime = StructNew()>
    <cfset rsTime.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTime>
    </cffunction>
    
    <cffunction name="getUOM" access="public" returntype="query" hint="Get a list of UOM.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="uomName" type="string" required="yes" default="">
    <cfargument name="uomStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="uomSort, uomName">
    <cfset var rsUOM = "" >
    <cftry>
    <cfquery name="rsUOM" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_uom WHERE 0 = 0 
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND uomName LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.uomName NEQ "">
    AND UPPER(uomName) = <cfqueryparam value="#UCASE(ARGUMENTS.uomName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND uomStatus IN (<cfqueryparam value="#ARGUMENTS.uomStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUOM = StructNew()>
    <cfset rsUOM.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUOM>
    </cffunction>
    
    <cffunction name="getPOSRegister" access="public" returntype="query" hint="Get a list of POS Registers.">
    <cfset myQuery = QueryNew("Name, Value")>
    <cfset totalCount = 20>
    <cfset newRow = QueryAddRow(myQuery, totalCount)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG1", 1)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG1", 1)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG2", 2)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG2", 2)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG3", 3)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG3", 3)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG4", 4)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG4", 4)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG5", 5)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG5", 5)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG6", 6)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG6", 6)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG7", 7)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG7", 7)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG8", 8)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG8", 8)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG9", 9)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG9", 9)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG10", 10)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG10", 10)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG11", 11)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG11", 11)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG12", 12)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG12", 12)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG13", 13)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG13", 13)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG14", 14)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG14", 14)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG15", 15)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG15", 15)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG16", 16)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG16", 16)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG17", 17)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG17", 17)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG18", 18)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG18", 18)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG19", 19)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG19", 19)>
    <cfset temp = QuerySetCell(myQuery, "Name", "REG20", 20)>
    <cfset temp = QuerySetCell(myQuery, "Value", "REG20", 20)>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getSort" access="public" returntype="query" hint="Get a list of Sort Options.">
    <cfargument name="sortStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSort = "" >
    <cftry>
    <cfquery name="rsSort" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_sort WHERE 0=0
    AND sortStatus IN (<cfqueryparam value="#ARGUMENTS.sortStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSort = StructNew()>
    <cfset rsSort.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSort>
    </cffunction>
    
    <cffunction name="getStatus" access="public" returntype="query" hint="Get a list of Status Types for making a record active or inactive etc.">
    <cfargument name="sStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsStatus = "" >
    <cftry>
    <cfquery name="rsStatus" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
    SELECT * FROM tbl_status WHERE 0=0
    AND sStatus IN (<cfqueryparam value="#ARGUMENTS.sStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsStatus = StructNew()>
    <cfset rsStatua.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsStatus>
    </cffunction>
    
    <cffunction name="insertrecordcountry" access="public">
    <cfargument name="cntryName" type="string" required="yes">
    <cfargument name="cntryAbbreviation" type="string" required="yes">
    <cfargument name="cntrySurcharge" type="numeric" required="yes">
    <cfargument name="cntryImporterTaxNumber" type="string" required="yes">
    <cfargument name="cntrySort" type="numeric" required="yes">
    <cfargument name="cntryStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.utility.List"
    method="getCountry"
    returnvariable="getCheckCountryRet">
    <cfinvokeargument name="cntryName" value="#ARGUMENTS.cntryName#"/>
    <cfinvokeargument name="cntryAbbreviation" value="#ARGUMENTS.cntryAbbreviation#"/>
    <cfinvokeargument name="cntryStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCountryRet.recordcount NEQ 0>
    <cfset result.message = "The country you have submitted already exists, please choose an alternate.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_country (cntryName,cntryAbbreviation,cntryStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cntryName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cntryAbbreviation#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cntryStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>

    <cffunction name="insertRecordStateProv" access="public">
    <cfargument name="cntryID" type="numeric" required="yes">
    <cfargument name="spName" type="string" required="yes">
    <cfargument name="spAbbreviation" type="string" required="yes">
    <cfargument name="spStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.utility.List"
    method="getStateProv"
    returnvariable="getStateProvRet">
    <cfinvokeargument name="spName" value="#ARGUMENTS.spName#"/>
    <cfinvokeargument name="spAbbreviation" value="#ARGUMENTS.spAbbreviation#"/>
    <cfinvokeargument name="spStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckStateProvRet.recordcount NEQ 0>
    <cfset result.message = "The state/prov you have submitted already exists, please choose an alternate.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_stateprov (cntryID,spName,spAbbreviation,spStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cntryID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.spName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.spAbbreviation#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.spStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="updaterecordcountry" access="public">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cntrySort" type="numeric" required="yes">
    <cfargument name="cntryStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_country SET
    cntrySort = <cfqueryparam cfsqltype="cf_sql_smallint" value="#ARGUMENTS.cntrySort#">,
    cntryStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cntryStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="updaterecordcountryList" access="public">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cntryStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_country SET
    cntryStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cntryStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="updateRecordStateProv" access="public">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="spName" type="string" required="yes">
    <cfargument name="spAbbreviation" type="string" required="yes">
    <cfargument name="spStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.utility.List"
    method="getStateProv"
    returnvariable="getCheckStateProvRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="spName" value="#ARGUMENTS.spName#"/>
    <cfinvokeargument name="spAbbreviation" value="#ARGUMENTS.spAbbreviation#"/>
    <cfinvokeargument name="spStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckStateProvRet.recordcount NEQ 0>
    <cfset result.message = "The state/prov you have submitted already exists, please choose an alternate.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_stateprov SET
    spName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.spName#">,
    spAbbreviation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.spAbbreviation#">,
    spStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.spStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="updateRecordStateProvList" access="public">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="spStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_stateprov SET
    spStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.spStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="deleteCountry" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_country
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteStateProv" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_state_prov
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