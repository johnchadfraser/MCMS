<cfcomponent>
    <cffunction name="getVideoPresentation" access="public" returntype="query" hint="Get Video Presentation data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vpName" type="string" required="yes" default="">
    <cfargument name="vpdDirectory" type="string" required="yes" default="">
    <cfargument name="vptID" type="string" required="yes" default="0">
    <cfargument name="vpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vpName">
    <cfset var rsVideoPresentation = "" >
    <cftry>
    <cfquery name="rsVideoPresentation" datasource="#application.mcmsDSN#">
    SELECT * FROM v_video_presentation WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(vpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vpDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.vpName NEQ "">
    AND UPPER(vpName) = <cfqueryparam value="#UCASE(ARGUMENTS.vpName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.vpdDirectory NEQ "">
    AND UPPER(vpdDirectory) = <cfqueryparam value="#UCASE(ARGUMENTS.vpdDirectory)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.vptID NEQ 0>
    AND vptID = <cfqueryparam value="#ARGUMENTS.vptID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND vpStatus IN (<cfqueryparam value="#ARGUMENTS.vpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentation = StructNew()>
    <cfset rsVideoPresentation.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentation>
    </cffunction>
    
    <cffunction name="getVideoPresentationType" access="public" returntype="query" hint="Get Video Presentation Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vptName" type="string" required="yes" default="">
    <cfargument name="vptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vptName">
    <cfset var rsVideoPresentationType = "" >
    <cftry>
    <cfquery name="rsVideoPresentationType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vp_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.vptName NEQ "">
    AND UPPER(vptName) = <cfqueryparam value="#UCASE(ARGUMENTS.vptName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vptStatus IN (<cfqueryparam value="#ARGUMENTS.vptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentationType = StructNew()>
    <cfset rsVideoPresentationType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentationType>
    </cffunction>
    
    <cffunction name="getVideoPresentationDirectory" access="public" returntype="query" hint="Get Video Presentation Directory data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vpdDirectory" type="string" required="yes" default="">
    <cfargument name="vpdStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vpdSort">
    <cfset var rsVideoPresentationDirectory = "" >
    <cftry>
    <cfquery name="rsVideoPresentationDirectory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vp_directory WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vpdDirectory) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.vpdDirectory NEQ "">
    AND UPPER(vpdDirectory) = <cfqueryparam value="#UCASE(ARGUMENTS.vpdDirectory)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vpdStatus IN (<cfqueryparam value="#ARGUMENTS.vpdStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentationDirectory = StructNew()>
    <cfset rsVideoPresentationDirectory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentationDirectory>
    </cffunction>
    
    <cffunction name="getVideoPresentationDocumentRel" access="public" returntype="query" hint="Get Video Presentation Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vpID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="docDateExp" type="string" required="yes" default="">
    <cfargument name="vpStatus" type="string" required="yes" default="1,3">
    <cfargument name="docStatus" type="string" required="yes" default="1,3">
    <cfargument name="vpdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsVideoPresentationDocumentRel = "" >
    <cftry>
    <cfquery name="rsVideoPresentationDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vp_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.vpID NEQ 0>
    AND vpID = <cfqueryparam value="#ARGUMENTS.vpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.docDateExp NEQ "">
    AND docDateExp >= <cfqueryparam value="#ARGUMENTS.docDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND vpStatus IN (<cfqueryparam value="#ARGUMENTS.vpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND (docStatus IN (<cfqueryparam value="#ARGUMENTS.docStatus#" list="yes" cfsqltype="cf_sql_integer">) OR docStatus IS NULL)
    AND vpdrStatus IN (<cfqueryparam value="#ARGUMENTS.vpdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentationDocumentRel = StructNew()>
    <cfset rsVideoPresentationDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentationDocumentRel>
    </cffunction>
    
    <cffunction name="getVideoPresentationDepartmentRel" access="public" returntype="query" hint="Get Video Presentation Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vpID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="99">
    <cfargument name="deptName" type="string" required="yes" default="">
    <cfargument name="vpStatus" type="string" required="yes" default="1,3">
    <cfargument name="deptStatus" type="string" required="yes" default="1,3">
    <cfargument name="vpdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptName">
    <cfset var rsVideoPresentationDepartmentRel = "" >
    <cftry>
    <cfquery name="rsVideoPresentationDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vp_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.vpID NEQ 0>
    AND vpID = <cfqueryparam value="#ARGUMENTS.vpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 99>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptName NEQ "">
    AND UPPER(deptName) = <cfqueryparam value="#UCASE(ARGUMENTS.deptName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vpStatus IN (<cfqueryparam value="#ARGUMENTS.vpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND vpdrStatus IN (<cfqueryparam value="#ARGUMENTS.vpdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentationDepartmentRel = StructNew()>
    <cfset rsVideoPresentationDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentationDepartmentRel>
    </cffunction>
    
    <cffunction name="getTimePartList" access="public" returntype="query" hint="List of Time Parts.">
    <cfargument name="totalCount" type="numeric" required="yes">
    <cfargument name="timeType" type="string" required="yes" default="">
    <cfargument name="timeMaskStart" type="string" required="yes" default="">
    <cfargument name="timeMaskEnd" type="string" required="yes" default="">
    <cfset myQuery = QueryNew("Name, Value", "varchar, varchar")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="id" from="1" to="#ARGUMENTS.totalCount#">
    <cfset temp = QuerySetCell(myQuery, "Name", LSTimeFormat('#ARGUMENTS.timeMaskStart##id##ARGUMENTS.timeMaskEnd#', ARGUMENTS.timeType), id)>
    <cfset temp = QuerySetCell(myQuery, "Value", LSTimeFormat('#ARGUMENTS.timeMaskStart##id##ARGUMENTS.timeMaskEnd#', ARGUMENTS.timeType), id)>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="getFileSize" access="public" returntype="string" output="false" hint="Get Video Presentation flv video file size information.">
	<cfargument name="vpFile" type="string" required="yes"/> 
    <cfargument name="vpmDirectory" type="string" required="yes"/>
    <cfset var rsFileSize = '0 MB'>
    <!---First check the path for the files.--->
    <cfdirectory name="flvFileInfo" action="list" directory="#application.vpFLVUNCPath#/#ARGUMENTS.vpmDirectory#/">
    <!---Query against the struct for the file requested.--->
    <cfquery name="rsFileSize" dbtype="query">
    SELECT * FROM flvFileInfo WHERE UPPER(name) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(ARGUMENTS.vpFile)#"/>
    </cfquery>
    <cfif rsFileSize.recordcount NEQ 0>
    <!---Format the result.--->
    <cfset rsFileSize = DecimalFormat((rsFileSize.size/1024)/1000) & ' MB'>
    <cfelse>
    <cfset rsFileSize = '0 MB'>
    </cfif>
    <cfreturn rsFileSize>
	</cffunction>
    
    <cffunction name="getQueryForm" access="public" returntype="string" output="true" hint="Get Query Form.">
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationDirectory"
    returnvariable="getVideoPresentationDirectoryRet">
    <cfinvokeargument name="vpdStatus" value="1"/>
    </cfinvoke>
    </cfsilent>
    <cfsavecontent variable="queryForm">
    <cfparam name="url.vpdDirectory" default="">
    <cfform method="get" name="queryForm" action="/video_presentation/">
    <cfinput type="hidden" name="mcmsID" value="result">
    <span class="bold">Keywords:</span> <cfinput type="text" name="keywords" id="keywords" maxlength="50" value="#url.keywords#" onFocus="this.value =''">
    <span class="bold">Category:</span> <cfselect name="vpdDirectory" id="vpdDirectory">
    <option value="">All Categories...</option>
    <cfoutput query="getVideoPresentationDirectoryRet">
    <option value="#vpdDirectory#" <cfif url.vpdDirectory EQ vpdDirectory>selected="true"</cfif>>#UCASE(vpdDirectory)#</option>
    </cfoutput>
    </cfselect>
    <cfinput type="submit" name="taskQuery" id="taskQuery" value="Search">
    </cfform>
    </cfsavecontent>
    <cfreturn queryForm>
	</cffunction>
    
    <cffunction name="getPresentationMenu" access="public" returntype="string" output="true" hint="Get Video Presentation Menu.">
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentation"
    returnvariable="getVideoPresentationRet">
    <cfinvokeargument name="keywords" value="#url.keywords#"/>
    <cfinvokeargument name="vpdDirectory" value="#url.vpdDirectory#"/>
    <cfinvokeargument name="vpDateRel" value="#Now()#"/>
    <cfinvokeargument name="vpDateExp" value="#Now()#"/>
    <cfinvokeargument name="vpStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="vpDateRel DESC"/>
    </cfinvoke>
    </cfsilent>
    <cfsavecontent variable="menuData">
    <h2>Presentation Menu</h2>
    <div id="wrapperFrameMenu">
    <table id="mainTable" style="margin-bottom:15px; background-color:##CCCCCC;">
    <cfif getVideoPresentationRet.recordcount NEQ 0>
    <cfoutput query="getVideoPresentationRet">
    <!---Switch the class if it is active.--->
    <cfset className = "hoverMenu">
    <cfif url.ID EQ ID><cfset className = "hoverMenuActive"></cfif>
    <tr class="#className#">
    <td id="##video#ID#" onclick="showDiv('loading#CurrentRow#'); javascript:location.href='?mcmsID=video&ID=#ID#&keywords=#url.keywords#&vpdDirectory=#url.vpdDirectory###video#ID#';" style="cursor:pointer; border-bottom:solid 1px ##FFFFFF; padding-bottom:15px;">    
    <a href="?mcmsID=video&ID=#ID#&keywords=#url.keywords#&vpdDirectory=#url.vpdDirectory###video#ID#" class="bold">#LEFT(vpName, 35)#<cfif LEN(vpName) GT 35>...</cfif> (#vpDuration#) - #vptName#</a><div id="loading#CurrentRow#" style="display:none; font-style:italic; color:##990000;">Loading...Please Wait.</div><br/>
    #DateFormat(vpDateRel, 'mm/dd/yyyy')#<br />
    #LEFT(vpDescription, 128)#<cfif LEN(vpDescription GT 128)>...</cfif>
    </td>
    </tr>
    </cfoutput>
    <cfelse>
    <tr>
    <td>No videos available.</td>
    </tr>
    </cfif>
    </table>
    </div>
    </cfsavecontent>
    <cfreturn menuData>
	</cffunction>
    
    <cffunction name="getConferenceSchedule" access="public" returntype="string" output="true" hint="Get Video Conference Schedules.">
	<cfargument name="startDate" type="string" required="yes"/> 
    <cfargument name="endDate" type="string" required="yes"/>
    <cfargument name="sortBy" type="string" required="no" default="startTime"/>
    <cfargument name="maxRows" type="numeric" required="yes" default="0"/>
    <cftry>
    <!---Connect to the schedule server.--->
    <cfexchangeconnection action="open" connection="myConn" username="#application.vpScheduleUsername#" password="#application.vpScheduleUserPassword#" server="#application.vpScheduleServer#">
    <!---Filter the calendar.--->
    <cfexchangecalendar action="get" name="getExchangeCalendar" connection="myConn">
    <cfexchangefilter name="startTime" from="#ARGUMENTS.startDate#" to="#ARGUMENTS.endDate#">
    </cfexchangecalendar>
    <!---Query against the results.--->
    <cfquery name="getCalendar" dbtype="query">
    SELECT * FROM getExchangeCalendar
    ORDER BY #ARGUMENTS.sortBy#
    </cfquery>
    <cfparam name="PageNum_getCalendar" default="1">
    <cfset MaxRows_getCalendar=IIf(ARGUMENTS.maxRows EQ 0, 100, Evaluate(DE('ARGUMENTS.maxRows')))>
    <cfset StartRow_getCalendar=Min((PageNum_getCalendar-1)*MaxRows_getCalendar+1,Max(getCalendar.RecordCount,1))>
    <cfset EndRow_getCalendar=Min(StartRow_getCalendar+MaxRows_getCalendar-1,getCalendar.RecordCount)>
    <cfset TotalPages_getCalendar=Ceiling(getCalendar.RecordCount/MaxRows_getCalendar)>
    <cfcatch type="any">
    <cfset message = "An error occurred accessing the schedule.">
    </cfcatch>
    </cftry>
    <cfsavecontent variable="scheduleData">
    <h2><cfoutput>#UCASE(application.vpScheduleUsername)#</cfoutput> Schedules <cfif url.mcmsID EQ 'schedule'>(30 Day)</cfif></h2>
    <table id="mainTableSchedule">
    <cfoutput query="getCalendar" startrow="#StartRow_getCalendar#" maxrows="#MaxRows_getCalendar#">
    <tr class="hoverSchedule">
    <td colspan="2" style="margin:0px;">
    <table id="mainTableAlt">
    <tr>
    <th colspan="2" style="color:##FFFFFF;">#LEFT(Subject, 32)#<cfif LEN(Subject GT 32)>...</cfif><cfif DateFormat(StartTime, 'ddd, mmm dd') EQ DateFormat(Now(), 'ddd, mmm dd')>TODAY!</cfif></th>
    </tr>
    <tr>
    <td width="40"> Date(s):<br></td>
    <td>#DateFormat(StartTime, 'ddd, mmm dd')#
    <cfif DateFormat(StartTime, 'ddd, mmm dd') NEQ DateFormat(EndTime, 'ddd, mmm dd')>
    - #DateFormat(EndTime, 'ddd, mmm dd')#
    </cfif>
    </td>
    </tr>
    <tr>
    <td>Time: </td>
    <td>#TimeFormat(StartTime, 'h:mm tt')# - #TimeFormat(EndTime, 'h:mm tt')# MST</td>
    </tr>
    <cfif Resources NEQ "">
    <tr>
    <td>Resources: </td>
    <td>#Resources#</td>
    </tr>
    </cfif>
    <cfif Location NEQ "">
    <tr>
    <td>Location: </td>
    <td>#Location#</td>
    </tr>
    </cfif>
    <cfif url.mcmsID NEQ 'schedule'>
    <tr>
    <td colspan="2" class="bold"><a href="?mcmsID=schedule" style="color:##FFFFFF">[+] View Schedules</a></td>
    </tr>
    </cfif>
    </table>
    </td>
    </tr>
    </cfoutput>
    <cfif getCalendar.RecordCount GT ARGUMENTS.maxRows AND ARGUMENTS.maxRows GT 1>
    <tr>
    <td colspan="7"><a href="?PageNum_getCalendar=1">&raquo;First</a>&nbsp;<a href="?PageNum_getCalendar=#Max(DecrementValue(PageNum_getCalendar),1)#">&raquo;Previous</a>&nbsp;<a href="?PageNum_getCalendar=#Min(IncrementValue(PageNum_getCalendar),TotalPages_getCalendar)#">&raquo;Next</a>&nbsp;<a href="?PageNum_getCalendar=#TotalPages_getCalendar#">&raquo;Last</a></td>
    </tr>
    </cfif>
    </table>
    </cfsavecontent>
    <cfreturn scheduleData>
	</cffunction>
    
    <cffunction name="setVideoWrapper" access="public" returntype="string" output="true" hint="Sets Video Conference wrapper for video.">
	<cfargument name="ID" type="numeric" required="yes" default="0"/> 
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentation"
    returnvariable="getVideoPresentationRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="vpDateRel" value="#Now()#"/>
    <cfinvokeargument name="vpDateExp" value="#Now()#"/>
    <cfinvokeargument name="vpmStatus" value="1"/>
    <cfinvokeargument name="vptStatus" value="1"/>
    <cfinvokeargument name="vpStatus" value="1"/>
    </cfinvoke>
    <!---Get the video flv file size data.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getFileSize"
    returnvariable="getFileSizeRet">
    <cfinvokeargument name="vpFile" value="#getVideoPresentationRet.vpFile#"/>
    <cfinvokeargument name="vpmDirectory" value="#getVideoPresentationRet.vpdDirectory#"/>
    </cfinvoke>
    <!---Path to flv video.--->
    <cfset variables.flvPath = "#application.vpFLVSourcePath#/#getVideoPresentationRet.vpdDirectory#/#getVideoPresentationRet.vpFile#">
    <!---Check to ensure the flv file excists.--->
    <cfset variables.flvVideoAbsPath = "#application.vpFLVUNCPath#\#getVideoPresentationRet.vpdDirectory#\#getVideoPresentationRet.vpFile#">
    <!---Set the default alert for no video.--->
    <cfset variables.noFLV = "No video was found, please try an alternate video.">
    </cfsilent>
    <cfsavecontent variable="wrapperData">
    <cfif getVideoPresentationRet.recordcount EQ 0>
    <div id="wrapperAlert">#variables.noFLV#<br>#variables.flvPath#</div>
    <!---
	<cfelseif NOT FileExists(variables.flvVideoAbsPath)>
    <div id="wrapperTitle">
    #getVideoPresentationRet.vpName# - #getVideoPresentationRet.vptName#
    </div>
    <div id="wrapperAlert">#variables.noFLV#<br>#variables.flvPath#</div>
	--->
    <cfelse>
    <div id="wrapperTitle">
    #getVideoPresentationRet.vpName# - #getVideoPresentationRet.vptName#
    </div>
    <cfoutput query="getVideoPresentationRet" maxrows="1">
    <!---Generate the loader.--->
    <div id="wrapperLoader">
    Loading...Please Wait.
    </div>
    <!---Display the video.--->
	<script language="javascript">
    if (AC_FL_RunContent == 0) {
    alert("This page requires AC_RunActiveContent.js.");
    } else {
    AC_FL_RunContent(
    'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=7,0,0,0',
    'width', '564',
    'height', '440',
    'src', '/video_presentation/wrapper/video_presentation',
    'quality', 'high',
    'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
    'align', 'top',
    'play', 'true',
    'loop', 'true',
    'scale', 'showall',
    'wmode', 'window',
    'devicefont', 'false',
    'id', 'video_presentation',
    'bgcolor', '##ffffff',
    'name', 'video_presentation',
    'menu', 'true',
    'allowFullScreen', 'true',
    'FlashVars', 'mySource=#variables.flvPath#',
    'wmode', 'transparent',
	'buf', '5',
    'allowScriptAccess','sameDomain',
    'movie', '/video_presentation/wrapper/video_presentation',
    'salign', ''
    ); //end AC code
    }
    </script>
    <noscript>
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=7,0,0,0" 
    width="564" height="440" id="video_presentation" align="top">
    <param name="allowScriptAccess" value="sameDomain" />
    <param name="allowFullScreen" value="true" />
    <param name="FlashVars" value="mySource=#variables.flvPath#">
    <param name="wmode" value="transparent">
    <param name="buf" value="10">
    <param name="movie" value="/video_presentation/wrapper/video_presentation.swf" /><param name="quality" value="high" /><param name="bgcolor" value="##ffffff" />	
    <embed src="/video_presentation/wrapper/video_presentation.swf" quality="high" bgcolor="##ffffff" width="564" height="440" name="video_presentation" align="top" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
    </object>
    </noscript>
    <!---Display any description data.--->
    <div id="wrapperDescription">
    <cfif imgFile NEQ "">
    <img src="/#application.mcmsRepositoryDir#/image/#imgtPath#/thumb/#imgFile#" alt="vendor" name="vendorLogo" id="vendorLogo">
    </cfif>
    <p class="textTitle">
    #vpName# (#vpDuration# - #getFileSizeRet#) - #DateFormat(vpDateRel, 'mm/dd/yyyy')# - #vptName#
    </p>
    <span class="small">#variables.flvPath#</span>
    <p>
    #vpDescription#
    </p>
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationDocumentRel"
    returnvariable="getVideoPresentationDocumentRelRet">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="docDateExp" value="#Now()#"/>
    <cfinvokeargument name="docStatus" value="1"/>
    <cfinvokeargument name="vpdStatus" value="1,3"/>
    <cfinvokeargument name="orderBy" value="docName"/>
    </cfinvoke>
    </cfsilent>
    <h3>Resources & Documents</h3>
    <table id="mainTable">
    <cfif getVideoPresentationDocumentRelRet.recordcount NEQ 0>
    <tr>
    <td class="bold">Name</td>
    <td class="bold">Date</td>
    <td class="bold">Author</td>
    </tr>
    <cfloop query="getVideoPresentationDocumentRelRet">
    <cfswitch expression="#RIGHT(docFile, 3)#">
    <cfcase value="doc">
    <cfset docIcon = "doc.gif">
    </cfcase>
    <cfcase value="xls">
    <cfset docIcon = "excel.gif">
    </cfcase>
    <cfcase value="pdf">
    <cfset docIcon = "pdf.gif">
    </cfcase>
    <cfcase value="ppt">
    <cfset docIcon = "ppt.gif">
    </cfcase>
    <cfcase value="jpg">
    <cfset docIcon = "jpg.gif">
    </cfcase>
    <cfdefaultcase>
    <cfset docIcon = "txt.gif">
    </cfdefaultcase>
    </cfswitch>
    <tr>
    <td>
    <a href="/#application.mcmsRepositoryDir#/document/#doctPath#/#URLEncodedFormat(docFile)#" target="_blank" title="#docName# - Description: #docDescription#">
    <img src="/#application.mcmsDir#/assets/icon/#docIcon#" alt="#docName#" name="#docName#" hspace="3" border="0" align="absmiddle" id="#docName#" />
    #LEFT(docName, 35)#<cfif LEN(docName) GT 35>...</cfif></a></td>
    <td>#DateFormat(docDate, 'mm/dd/yyyy')#</td>
    <td>#userFName# #userLName#</td>
    </tr>
    </cfloop>
    <cfelse>
    <tr>
    <td colspan="3">No resources available.</td>
    </tr>
    </cfif>
    </table>
    </div>
    </cfoutput>
    </cfif>
    </cfsavecontent>
    <cfreturn wrapperData>
	</cffunction>

    <cffunction name="getVideoPresentationReport" access="public" returntype="query" hint="Get Video Presentation Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="vpName">
    <cfset var rsVideoPresentationReport = "" >
    <cftry>
    <cfquery name="rsVideoPresentationReport" datasource="#application.mcmsDSN#">
    SELECT vpName AS Name, vpDescription AS Description, TO_CHAR(vpDate, 'MM/DD/YYYY') AS vpDate, TO_CHAR(vpDateRel, 'MM/DD/YYYY') AS Release_Date, TO_CHAR(vpDateExp, 'MM/DD/YYYY') AS Expire_Date, vpFile AS Filename, vpDuration AS Duration, imgName AS Image, vptName AS Type, vpdDirectory AS Directory, sortName AS Sort, sName AS Status FROM v_video_presentation WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(vpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vpDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentationReport = StructNew()>
    <cfset rsVideoPresentationReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentationReport>
    </cffunction>
    
    <cffunction name="getVideoPresentationTypeReport" access="public" returntype="query" hint="Get Video Presentation Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="vptName">
    <cfset var rsVideoPresentationTypeReport = "" >
    <cftry>
    <cfquery name="rsVideoPresentationTypeReport" datasource="#application.mcmsDSN#">
    SELECT vptName AS Name, sortName AS Sort, sName AS Status FROM v_vp_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentationTypeReport = StructNew()>
    <cfset rsVideoPresentationTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentationTypeReport>
    </cffunction>
    
    <cffunction name="getVideoPresentationDirectoryReport" access="public" returntype="query" hint="Get Video Presentation Directory Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="vpdDirectory">
    <cfset var rsVideoPresentationDirectoryReport = "" >
    <cftry>
    <cfquery name="rsVideoPresentationDirectoryReport" datasource="#application.mcmsDSN#">
    SELECT vpdDirectory AS Directory, sortName AS Sort, sName AS Status FROM v_vp_directory WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vpdDirectory) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVideoPresentationDirectoryReport = StructNew()>
    <cfset rsVideoPresentationDirectoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVideoPresentationDirectoryReport>
    </cffunction>
    
    <cffunction name="insertVideoPresentation" access="public" returntype="struct">
    <cfargument name="vpName" type="string" required="yes">
    <cfargument name="vpDescription" type="string" required="yes">
    <cfargument name="vpDateRel" type="string" required="yes">
    <cfargument name="vpDateExp" type="string" required="yes">
    <cfargument name="vpFile" type="string" required="yes">
    <cfargument name="vpDuration" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="vptID" type="numeric" required="yes">
    <cfargument name="vpdID" type="numeric" required="yes">
    <cfargument name="vpSort" type="numeric" required="yes">
    <cfargument name="vpStatus" type="numeric" required="yes">
    <cfargument name="emailNotify" type="string" required="false">
    <!---Relationship arguments.--->
    <cfargument name="docID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.vpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentation"
    returnvariable="getCheckVideoPresentationRet">
    <cfinvokeargument name="vpName" value="#ARGUMENTS.vpName#"/>
    <cfinvokeargument name="vpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.vpName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.vpDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_video_presentation (vpName,vpDescription,vpDateRel,vpDateExp,vpFile,vpDuration,imgID,vptID,vpdID,vpSort,vpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.vpDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.vpDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpFile#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpDuration#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_video_presentation"/>
    </cfinvoke>
    <cfset this.vpID = getMaxValueSQLRet>
    <!---Create document relationships.--->
    <cfloop index="docID" list="#ARGUMENTS.docID#">
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="insertVideoPresentationDocumentRel"
    returnvariable="insertVideoPresentationDocumentRelRet">
    <cfinvokeargument name="vpID" value="#this.vpID#"/>
    <cfinvokeargument name="docID" value="#docID#"/>
    <cfinvokeargument name="vpdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="insertVideoPresentationDepartmentRel"
    returnvariable="insertVideoPresentationDepartmentRelRet">
    <cfinvokeargument name="vpID" value="#this.vpID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="vpdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfif ARGUMENTS.emailNotify EQ true>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="New Video Presentation! #ARGUMENTS.vpName#"/>
    <cfinvokeargument name="to" value="#application.vpNotifyEmailList#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#this.vpID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/video_presentation/view/inc_video_presentation_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertVideoPresentationType" access="public" returntype="struct">
    <cfargument name="vptName" type="string" required="yes">
    <cfargument name="vptSort" type="numeric" required="yes">
    <cfargument name="vptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationType"
    returnvariable="getCheckVideoPresentationTypeRet">
    <cfinvokeargument name="vptName" value="#ARGUMENTS.vptName#"/>
    <cfinvokeargument name="vptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.vptName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vp_type (vptName,vptSort,vptStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vptName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vptSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vptStatus#">
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
    
    <cffunction name="insertVideoPresentationDirectory" access="public" returntype="struct">
    <cfargument name="vpdDirectory" type="string" required="yes">
    <cfargument name="vpdSort" type="numeric" required="yes">
    <cfargument name="vpdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationDirectory"
    returnvariable="getCheckVideoPresentationDirectoryRet">
    <cfinvokeargument name="vpdDirectory" value="#ARGUMENTS.vpdDirectory#"/>
    <cfinvokeargument name="vpdStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationDirectoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.vpdDirectory# already exists, please enter a new directory.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vp_directory (vpdDirectory,vpdSort,vpdStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpdDirectory#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdStatus#">
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
    
    <cffunction name="insertVideoPresentationDocumentRel" access="public" returntype="struct">
    <cfargument name="vpID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="vpdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationDocumentRel"
    returnvariable="getCheckVideoPresentationDocumentRelRet">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.vpID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="vpdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The video presentation document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vp_document_rel (vpID,docID,vpdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdrStatus#">
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
    
    <cffunction name="insertVideoPresentationDepartmentRel" access="public" returntype="struct">
    <cfargument name="vpID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="vpdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationDepartmentRel"
    returnvariable="getCheckVideoPresentationDepartmentRelRet">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.vpID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="vpdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The video presentation department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vp_department_rel (vpID,deptNo,vpdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdrStatus#">
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
    
    <cffunction name="updateVideoPresentation" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="vpName" type="string" required="yes">
    <cfargument name="vpDescription" type="string" required="yes">
    <cfargument name="vpDateRel" type="string" required="yes">
    <cfargument name="vpDateExp" type="string" required="yes">
    <cfargument name="vpFile" type="string" required="yes">
    <cfargument name="vpDuration" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="vptID" type="numeric" required="yes">
    <cfargument name="vpdID" type="numeric" required="yes">
    <cfargument name="vpSort" type="numeric" required="yes">
    <cfargument name="vpStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="docID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.vpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentation"
    returnvariable="getCheckVideoPresentationRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="vpName" value="#ARGUMENTS.vpName#"/>
    <cfinvokeargument name="vpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.vpName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.vpDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_video_presentation SET
    vpName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpName#">,
    vpDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpDescription#">,
    vpDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.vpDateRel#">,
    vpDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.vpDateExp#">,
    vpFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpFile#">,
    vpDuration = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpDuration#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    vptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vptID#">,
    vpdID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdID#">,
    vpSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpSort#">,
		<cfif ARGUMENTS.uaID NEQ 101>
    vpDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    vpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="deleteVideoPresentationDocumentRel"
    returnvariable="deleteVideoPresentationDocumentRelRet">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="deleteVideoPresentationDepartmentRel"
    returnvariable="deleteVideoPresentationDepartmentRelRet">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create document relationships.--->
    <cfloop index="docID" list="#ARGUMENTS.docID#">
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="insertVideoPresentationDocumentRel"
    returnvariable="insertVideoPresentationDocumentRelRet">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="docID" value="#docID#"/>
    <cfinvokeargument name="vpdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="insertVideoPresentationDepartmentRel"
    returnvariable="insertVideoPresentationDepartmentRelRet">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="vpdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfif ARGUMENTS.emailNotify EQ true>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.vpName# - Video Presentation Update"/>
    <cfinvokeargument name="to" value="#application.vpNotifyEmailList#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/video_presentation/view/inc_video_presentation_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateVideoPresentationType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vptName" type="string" required="yes">
    <cfargument name="vptSort" type="numeric" required="yes">
    <cfargument name="vptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationType"
    returnvariable="getCheckVideoPresentationTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="vptName" value="#ARGUMENTS.vptName#"/>
    <cfinvokeargument name="vptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.vptName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vp_type SET
    vptName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vptName#">,
    vptSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vptSort#">,
    vptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vptStatus#">
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
    
    <cffunction name="updateVideoPresentationDirectory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vpdDirectory" type="string" required="yes">
    <cfargument name="vpdSort" type="numeric" required="yes">
    <cfargument name="vpdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="getVideoPresentationDirectory"
    returnvariable="getCheckVideoPresentationDirectoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="vpdDirectory" value="#ARGUMENTS.vpdDirectory#"/>
    <cfinvokeargument name="vptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVideoPresentationDirectoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.vpdDirectory# already exists, please enter a new directory.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vp_directory SET
    vpdDirectory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.vpdDirectory#">,
    vpdSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdSort#">,
    vpdStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdStatus#">
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
    
    <cffunction name="updateVideoPresentationList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_video_presentation SET
    vpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateVideoPresentationTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vp_type SET
    vptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vptStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateVideoPresentationDirectoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vpdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vp_directory SET
    vpdStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vpdStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVideoPresentation" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_video_presentation
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any Document Relationships.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="deleteVideoPresentationDocumentRel"
    returnvariable="result">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete any Department Relationships.--->
    <cfinvoke 
    component="MCMS.component.app.video_presentation.VideoPresentation"
    method="deleteVideoPresentationDepartmentRel"
    returnvariable="result">
    <cfinvokeargument name="vpID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVideoPresentationType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vp_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVideoPresentationDirectory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vp_directory
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVideoPresentationDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="vpID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vp_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR
    vpID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.vpID#">) 
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVideoPresentationDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="vpID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vp_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR
    vpID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.vpID#">) 
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>