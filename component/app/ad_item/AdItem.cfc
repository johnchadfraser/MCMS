<cfcomponent>
    <cffunction name="getAdItem" access="public" returntype="query" hint="Get Ad Item data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="ainID" type="numeric" required="yes" default="0">
    <cfargument name="aiDate" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ainStatus" type="string" required="no" default="0">
    <cfargument name="aiStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aiDate DESC, pName">
    <cfset var rsAdItem = "" >
    <cftry>
    <cfquery name="rsAdItem" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ad_item WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ainName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ainID NEQ 0>
    AND ainID = <cfqueryparam value="#ARGUMENTS.ainID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.aiDate NEQ ''>
    AND TO_CHAR(aiDateUpdate, 'YYYY') >= <cfqueryparam value="#ARGUMENTS.aiDate#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ainStatus NEQ 0>
    AND ainStatus IN (<cfqueryparam value="#ARGUMENTS.ainStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND aiStatus IN (<cfqueryparam value="#ARGUMENTS.aiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItem = StructNew()>
    <cfset rsAdItem.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItem>
    </cffunction>
    
    <cffunction name="getAdItemQuestion" access="public" returntype="query" hint="Get Ad Item Question data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aiqQuestion" type="string" required="yes" default="">
    <cfargument name="aiqStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aiqQuestion">
    <cfset var rsAdItemQuestion = "" >
    <cftry>
    <cfquery name="rsAdItemQuestion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ad_item_question WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(aiqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.aiqQuestion NEQ "">
    AND UPPER(aiqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.aiqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND aiqStatus IN (<cfqueryparam value="#ARGUMENTS.aiqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemQuestion = StructNew()>
    <cfset rsAdItemQuestion.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemQuestion>
    </cffunction>
    
    <cffunction name="getAdItemRegion" access="public" returntype="query" hint="Get Ad Item Region data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="airName" type="string" required="yes" default="">
    <cfargument name="airStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="airName">
    <cfset var rsAdItemRegion = "" >
    <cftry>
    <cfquery name="rsAdItemRegion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ad_item_region WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(airName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.airName NEQ "">
    AND UPPER(airName) = <cfqueryparam value="#UCASE(ARGUMENTS.airName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND airStatus IN (<cfqueryparam value="#ARGUMENTS.airStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemRegion = StructNew()>
    <cfset rsAdItemRegion.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemRegion>
    </cffunction>
    
    <cffunction name="getAdItemName" access="public" returntype="query" hint="Get Ad Item Name data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ainName" type="string" required="yes" default="">
    <cfargument name="ainDateStart" type="string" required="yes" default="">
    <cfargument name="ainDateEnd" type="string" required="yes" default="">
    <cfargument name="ainStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ainName">
    <cfset var rsAdItemName = "" >
    <cftry>
    <cfquery name="rsAdItemName" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ad_item_name WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ainName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ainName NEQ "">
    AND UPPER(ainName) = <cfqueryparam value="#UCASE(ARGUMENTS.ainName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ainDateStart NEQ "">
    AND ainDateStart <= <cfqueryparam value="#ARGUMENTS.ainDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ainDateEnd NEQ "">
    AND ainDateEnd >= <cfqueryparam value="#ARGUMENTS.ainDateEnd#" cfsqltype="cf_sql_date">
    </cfif>
    AND ainStatus IN (<cfqueryparam value="#ARGUMENTS.ainStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemName = StructNew()>
    <cfset rsAdItemName.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemName>
    </cffunction>
    
    <cffunction name="getAdItemRegionRel" access="public" returntype="query" hint="Get Ad Item Region Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aiID" type="numeric" required="yes" default="0">
    <cfargument name="airID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="airrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="airName">
    <cfset var rsAdItemRegionRel = "" >
    <cftry>
    <cfquery name="rsAdItemRegionRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ad_item_region_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(airName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.aiID NEQ 0>
    AND aiID = <cfqueryparam value="#ARGUMENTS.aiID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.airID NEQ 0>
    AND airID = <cfqueryparam value="#ARGUMENTS.airID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND airrStatus IN (<cfqueryparam value="#ARGUMENTS.airrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemRegionRel = StructNew()>
    <cfset rsAdItemRegionRel.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemRegionRel>
    </cffunction>
    
    <cffunction name="getAdItemQuestionResult" access="public" returntype="query" hint="Get Ad Item Question Result data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aiID" type="numeric" required="yes" default="0">
    <cfargument name="aiqID" type="numeric" required="yes" default="0">
    <cfargument name="aiqrAnswer" type="string" required="yes" default="">
    <cfargument name="aiqStatus" type="string" required="yes" default="1,3">
    <cfargument name="aiqrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aiqrAnswer">
    <cfset var rsAdItemQuestionResult = "" >
    <cftry>
    <cfquery name="rsAdItemQuestionResult" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ad_item_question_result WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND aiID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.aiID NEQ 0>
    AND aiID = <cfqueryparam value="#UCASE(ARGUMENTS.aiID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.aiqID NEQ 0>
    AND aiqID = <cfqueryparam value="#UCASE(ARGUMENTS.aiqID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.aiqrAnswer NEQ "">
    AND UPPER(aiqrAnswer) = <cfqueryparam value="#UCASE(ARGUMENTS.aiqrAnswer)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND aiqStatus IN (<cfqueryparam value="#ARGUMENTS.aiqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND aiqrStatus IN (<cfqueryparam value="#ARGUMENTS.aiqrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemQuestionResult = StructNew()>
    <cfset rsAdItemQuestionResult.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemQuestionResult>
    </cffunction>
    
    <cffunction name="getAdItemReport" access="public" returntype="query" hint="Get Ad Item Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="aiStatus" type="string" required="yes" default="1">
    <cfargument name="orderBy" type="string" required="yes" default="ID DESC, ainName, pName">
    <cfset var rsAdItemReport = "" >
    <cftry>
    <cfquery name="rsAdItemReport" datasource="#application.mcmsDSN#">
    SELECT productID, pID, pName As Name, ainName as Ad_Name, TO_CHAR(aiDate, 'mm/dd/yyyy') As AI_Date, deptName As Department, aiSkuList, aiMPNList, aiListPriceL48 AS List_Price_L48, aiListPriceAK AS List_Price_AK, aiListPriceCA AS List_Price_CA, aiListPriceCO AS List_Price_CO, aiSalePriceL48 AS Sale_Price_L48, aiSalePriceAK AS Sale_Price_AK, aiSalePriceCA AS Sale_Price_CA, aiSalePriceCO AS Sale_Price_CO, TO_CHAR(pDescription) AS Product_Description, pBulletPoint AS Product_Bullet_Points, aiBulletPoint AS Ad_Item_Bullet_Points, vName AS Vendor, bName AS Brand, aiMonth As Month, sName As Status FROM v_ad_item WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ainName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND ainID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    AND aiStatus IN (<cfqueryparam value="#ARGUMENTS.aiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemReport = StructNew()>
    <cfset rsAdItemReport.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemReport>
    </cffunction>
    
    <cffunction name="getAdItemWordQuickReport" access="public" returntype="any" hint="Get Ad Item WORD Quick Report data.">
    <cfargument name="args" type="string" required="yes" default="0">
	<cfset var rsAdItemWordQuickReport = "" >
    <cftry>
    <cfsavecontent variable="rsAdItemWordQuickReport">
    <cfcontent type="application/vnd.ms-word">
    <cfheader name="content-disposition" value="inline;filename=Ad_Item_#DateFormat(Now(), application.dateFormat)#.doc">
    <cfinclude template="/#application.mcmsAppAdminPath#/ad_item/inc/inc_ad_item_quick_report.cfm">
    </cfsavecontent>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemWordQuickReport = StructNew()>
    <cfset rsAdItemWordQuickReport.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemWordQuickReport>
    </cffunction>
    
    <cffunction name="getAdItemQuestionReport" access="public" returntype="query" hint="Get Ad Item Question Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="aiqQuestion">
    <cfset var rsAdItemQuestionReport = "" >
    <cftry>
    <cfquery name="rsAdItemQuestionReport" datasource="#application.mcmsDSN#">
    SELECT aiqQuestion As Question, TO_CHAR(aiqDate,'MM/DD/YYYY') AS Question_Date, DECODE(aiqRequired,1,'Yes', 'No') As Required, DECODE(aiqtID,1,'Radio', 'Text') As Question_Type, sortName As Sort, sName As Status FROM v_ad_item_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(aiqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemQuestionReport = StructNew()>
    <cfset rsAdItemQuestionReport.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemQuestionReport>
    </cffunction>
    
    <cffunction name="getAdItemRegionReport" access="public" returntype="query" hint="Get Ad Item Region Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="airName">
    <cfset var rsAdItemRegionReport = "" >
    <cftry>
    <cfquery name="rsAdItemRegionReport" datasource="#application.mcmsDSN#">
    SELECT airName As Name, sortName As Sort, sName As status FROM v_ad_item_region WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(airName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemRegionReport = StructNew()>
    <cfset rsAdItemRegionReport.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemRegionReport>
    </cffunction>
    
    <cffunction name="getAdItemNameReport" access="public" returntype="query" hint="Get Ad Item Name Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ainName">
    <cfset var rsAdItemNameReport = "" >
    <cftry>
    <cfquery name="rsAdItemNameReport" datasource="#application.mcmsDSN#">
    SELECT ainName As Name, TO_CHAR(ainDateStart,'MM/DD/YYYY') AS Start_Date, TO_CHAR(ainDateEnd,'MM/DD/YYYY') AS End_Date, sName As Status FROM v_ad_item_name WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ainName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAdItemNameReport = StructNew()>
    <cfset rsAdItemNameReport.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsAdItemNameReport>
    </cffunction>
    
    <cffunction name="insertAdItem" access="public" returntype="struct">
    <cfargument name="ainID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="aiMonth" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="aiSkuList" type="string" required="yes" default="">
    <cfargument name="aiMPNList" type="string" required="yes" default="">
    <cfargument name="docFile" type="string" required="yes" default="">
    <cfargument name="pBulletPoint" type="string" required="yes" default="">
    <cfargument name="aiListPriceL48" type="string" required="yes" default="">
    <cfargument name="aiListPriceAK" type="string" required="yes" default="">
    <cfargument name="aiListPriceCA" type="string" required="yes" default="">
    <cfargument name="aiListPriceCO" type="string" required="yes" default="">
    <cfargument name="aiSalePriceL48" type="string" required="yes" default="">
    <cfargument name="aiSalePriceAK" type="string" required="yes" default="">
    <cfargument name="aiSalePriceCA" type="string" required="yes" default="">
    <cfargument name="aiSalePriceCO" type="string" required="yes" default="">
    <cfargument name="vcName" type="string" required="yes" default="">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="vcEmail" type="string" required="yes" default="">
    <cfargument name="vcTelArea" type="string" required="yes" default="">
    <cfargument name="vcTelPrefix" type="string" required="yes" default="">
    <cfargument name="vcTelSuffix" type="string" required="yes" default="">
    <cfargument name="airID" type="string" required="yes" default="0">
    <cfargument name="aiComment" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="aiStatus" type="numeric" required="yes" default="1">
    <cfargument name="questionCount" type="numeric" required="yes">
    <cfargument name="emailSubject" type="string" required="yes" default="Ad Item Submission">
    <cfargument name="emailFrom" type="string" required="yes" default="#session.userUserName#">
    <cfargument name="emailTo" type="string" required="yes" default="#application.adItemEmail#">
    <cfargument name="emailCC" type="string" required="yes" default="#session.userUserName#">
    <cfargument name="emailBCC" type="string" required="yes" default="">
    <cfargument name="emailType" type="string" required="yes" default="html">
    <cfargument name="ainIDNew" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully inserted the record. Either enter a new product for this ad or continue with Ad Items.">
   	<cfset VAR.pID = ARGUMENTS.pID>
    <cfset VAR.vID = ARGUMENTS.vID>
    <cfset VAR.vcID = 0>
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItem"
    returnvariable="getCheckAdItemRet">
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="ainID" value="#ARGUMENTS.ainID#"/>
    <cfinvokeargument name="aiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemRet.Recordcount NEQ 0>
    <cfset result.message = "The ad item already exists, please search for this ad item in your results and update it this ad. The ad title and ad cannot match.">
    <cfelse>
    
    <!---Insert the sku file if it exists.--->
    <cfif form.docFile NEQ ''>
    <cfinvoke 
    component="cfc.document" 
    method="insertDocument" 
    >
    <cfinvokeargument name="docName" value="#ARGUMENTS.pName#">
    <cfinvokeargument name="docDescription" value="#ARGUMENTS.pName#"> 
    <cfinvokeargument name="docFile" value="#form.docFile#">
    <cfinvokeargument name="docDateRel" value="#DateFormat(Now(), application.dateFormat)#">
    <cfinvokeargument name="docDateExp" value="#DateFormat(DateAdd('d', '90', Now()), application.dateFormat)#">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#">
    <cfinvokeargument name="doctID" value="#application.adItemDocumentType#">
    <cfinvokeargument name="netID" value="#application.networkID#">
    <cfinvokeargument name="docSort" value="1">
    <cfinvokeargument name="docStatus" value="1">
    <!---Email arguments.--->
    <cfinvokeargument name="emailNotify" value="false">
    <!---Relationship arguments.--->
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#">
    <cfinvokeargument name="siteNo" value="100">
    <cfinvokeargument name="deptNo" value="#form.deptNo#">                    
    </cfinvoke>
    <!---Get latest ad item id.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="docIDValue">
    <cfinvokeargument name="tableName" value="tbl_document"/>
    </cfinvoke>
    <cfset VAR.docID = docIDValue>
    <cfelse>
    <cfset VAR.docID = 0>
    </cfif>
    
    
    <!---Get existing Vendor Contact if applicable.--->
    <cfif ARGUMENTS.vcName NEQ '' AND ARGUMENTS.vID EQ 0>
    <cfinvoke 
    component="cfc.vendor" 
    method="getVendorContact" 
    returnvariable="getVendorContactRet"
    >
    <cfinvokeargument name="vcName" value="#ARGUMENTS.vcName#"> 
    <cfinvokeargument name="vcStatus" value="1,3">                   
    </cfinvoke>
    <cfif getVendorContactRet.Recordcount NEQ 0>
    <cfset VAR.vID = getVendorContactRet.vID>
    <cfset VAR.vcID = getVendorContactRet.ID>
    </cfif>
    </cfif>
    
    <!---Create a new Vendor Contact if applicable.--->
    <cfif ARGUMENTS.vID NEQ 0 AND ARGUMENTS.vcfName NEQ '' AND ARGUMENTS.vclName NEQ '' AND ARGUMENTS.vcEmail NEQ '' AND ARGUMENTS.vcName EQ ''>
    <cfset VAR.vID = ARGUMENTS.vID>
    <cfinvoke 
    component="cfc.vendor" 
    method="insertVendorContact" 
    >
    <cfinvokeargument name="vID" value="#VAR.vID#">
    <cfinvokeargument name="vcfName" value="#ARGUMENTS.vcfName#"> 
    <cfinvokeargument name="vclName" value="#ARGUMENTS.vclName#">
    <cfinvokeargument name="vcAddress" value="Source: Custom Ad Item">
    <cfinvokeargument name="vcAddressExt" value="">
    <cfinvokeargument name="vcCity" value="">
    <cfinvokeargument name="vcStateProv" value="">
    <cfinvokeargument name="vcZipCode" value="">
    <cfinvokeargument name="vcZipCodeExt" value="">
    <cfinvokeargument name="vcCountry" value="">
    <cfinvokeargument name="vcTelArea" value="#ARGUMENTS.vcTelArea#">
    <cfinvokeargument name="vcTelPrefix" value="#ARGUMENTS.vcTelPrefix#">
    <cfinvokeargument name="vcTelSuffix" value="#ARGUMENTS.vcTelSuffix#">
    <cfinvokeargument name="vcFaxArea" value="">
    <cfinvokeargument name="vcFaxPrefix" value="">
    <cfinvokeargument name="vcFaxSuffix" value="">
    <cfinvokeargument name="vcEmail" value="#ARGUMENTS.vcEmail#">
    <cfinvokeargument name="vcUrl" value="">
    <cfinvokeargument name="vcSourceUsername" value="">
    <cfinvokeargument name="vcSourcePassword" value="">
    <cfinvokeargument name="vcSourceUrl" value="">
    <cfinvokeargument name="vcSort" value="1">
    <cfinvokeargument name="vcStatus" value="1">                     
    </cfinvoke>
    <!---Get latest ad item id.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="vcIDRecord">
    <cfinvokeargument name="tableName" value="tbl_vendor_contact"/>
    </cfinvoke>
    <cfset VAR.vcID = vcIDRecord>
    </cfif>
    
    <cfif ARGUMENTS.pID EQ 0>
    <!---Begin by inserting the product record from the Ad Title and assigning it a product type of "Custom Ad Item".--->
    <cfinvoke 
    component="cfc.ad_item"
    method="insertProduct"
    returnvariable="result">
    <cfinvokeargument name="vID" value="#VAR.vID#"/>
    <cfinvokeargument name="bID" value="0"/>
    <cfinvokeargument name="pesID" value="101"/>
    <cfinvokeargument name="ppID" value="101"/>
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="pPageTitle" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="pBulletPoint" value="#ARGUMENTS.pBulletPoint#"/>
    <cfinvokeargument name="pKeyword" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="pDescription" value="Ad Item Sku(s):#ARGUMENTS.aiSkuList#"/>
    <cfinvokeargument name="pMetaDescription" value="#ARGUMENTS.aiComment#"/>
    <cfinvokeargument name="pDateRel" value="#DateFormat(Now(), application.dateFormat)#"/>
    <cfinvokeargument name="pDateExp" value="#DateFormat(DateAdd('d', '90', Now()), application.dateFormat)#"/>
    <cfinvokeargument name="pCSL" value="0"/>
    <cfinvokeargument name="pMPN" value="0"/>
    <cfinvokeargument name="pstID" value="0"/>
    <cfinvokeargument name="ptID" value="6"/>
    <cfinvokeargument name="pSort" value="1"/>
    <cfinvokeargument name="pStatus" value="3"/>
    <!---Catalog relationships.--->
    <cfinvokeargument name="cID" value="103"/>
    <!---Ad Item relationships.--->
    <cfinvokeargument name="ainID" value="#ARGUMENTS.ainID#"/>
    <!---Document relationships.--->
    <cfinvokeargument name="docID" value="#VAR.docID#"/>
    <!---Department relationships.--->
    <cfinvokeargument name="deptNo" value="#form.deptNo#"/>
    <!---Product Template relationships.--->
    <cfinvokeargument name="ptempID" value="0"/>
    </cfinvoke>
    <!---Get latest ad item id.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="pIDValue">
    <cfinvokeargument name="tableName" value="tbl_product"/>
    </cfinvoke>
    <cfset VAR.pID = pIDValue>
    </cfif>
    <!---Create bullet point tags.--->
    <cfinvoke 
    component="cfc.list"
    method="setBulletList"
    returnvariable="setBulletListRet">
    <cfinvokeargument name="listValue" value="#TRIM(ARGUMENTS.pBulletPoint)#"/>
    <cfinvokeargument name="type" value="unordered"/>
    </cfinvoke>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item (
    ainID,
    pID,
    vID,
    vcID,
    deptNo,
    aiMonth,
    aiBulletPoint,
    aiSkuList,
    aiMPNList,
    docID,
    aiListPriceL48,
    aiListPriceAK,
    aiListPriceCA,
    aiListPriceCO,
    aiSalePriceL48,
    aiSalePriceAK,
    aiSalePriceCA,
    aiSalePriceCO,
    aiComment,
    userID,
    aiStatus
    ) VALUES (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.pID NEQ 0, DE(ARGUMENTS.pID), DE(VAR.pID))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#VAR.vID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#VAR.vcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiMonth#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#setBulletListRet#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiSkuList#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiMPNList#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#VAR.docID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceL48 EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceL48))#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceAK EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceAK))#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceCA EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceCA))#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceCO EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceCO))#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceL48 EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceL48))#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceAK EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceAK))#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceCA EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceCA))#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceCO EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceCO))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiComment#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiStatus#">
    )
    </cfquery>
    <!---Now insert product ad item name relationship.--->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_ad_item_rel (ainID,pID,pairStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.pID NEQ 0, DE(ARGUMENTS.pID), DE(VAR.pID))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    <!---Get latest ad item id.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="aiID">
    <cfinvokeargument name="tableName" value="tbl_ad_item"/>
    </cfinvoke>
    <cfset VAR.aiID = aiID>
    <cfloop list="#ARGUMENTS.airID#" index="i">
    <!---Now insert product ad item region relationship.--->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item_region_rel (aiID,airID,airrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#VAR.aiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#i#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cfloop>
    <!---Complete the Question Result insert.--->
    <cfloop index="questionID" from="1" to="#ARGUMENTS.questionCount#">
    <cfif IsDefined('form.aiqrAnswer#questionID#')>
    <cfinvoke 
    component="cfc.ad_item"
    method="insertAdItemQuestionResult"
    returnvariable="result">
    <cfinvokeargument name="aiID" value="#VAR.aiID#"/>
    <cfinvokeargument name="aiqID" value="#Evaluate('form.aiqID#questionID#')#"/>
    <cfinvokeargument name="aiqrAnswer" value="#Evaluate('form.aiqrAnswer#questionID#')#"/>
    <cfinvokeargument name="aiqrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <!---Reformat for bullet points.--->
    <cfif Evaluate('form.aiqtID#questionID#') EQ 3>
    <cfset bulletedQuestion = 'xxxxx'>
    <cfloop index="ii" from="1" to="#application.adItemBulletCount#">
    <cfset bulletedQuestion = ListPrepend(Evaluate('form.aiqrAnswer#questionID#x#ii#'), bulletedQuestion, '|')>
	</cfloop>
    <!---Cleanup string.--->
    <cfset bulletedQuestion = Replace(bulletedQuestion, 'xxxxx|', '', 'All')>
	<cfinvoke 
    component="cfc.ad_item"
    method="insertAdItemQuestionResult"
    returnvariable="result">
    <cfinvokeargument name="aiID" value="#VAR.aiID#"/>
    <cfinvokeargument name="aiqID" value="#Evaluate('form.aiqID#questionID#')#"/>
    <cfinvokeargument name="aiqrAnswer" value="#bulletedQuestion#"/>
    <cfinvokeargument name="aiqrStatus" value="1"/>
    </cfinvoke>
	</cfif>
    <!--- Send special email notification based on questions. --->
    <cfswitch expression="#Evaluate('form.aiqtID#questionID#')#">
    <cfcase value="110">
    <cfinvoke 
    component="cfc.email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.emailSubject# - #ARGUMENTS.pName# - Special Pricing"/>
    <cfinvokeargument name="to" value="#application.adItemEmailAlt#"/>
    <cfinvokeargument name="from" value="#ARGUMENTS.emailFrom#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#VAR.aiID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ad_item/inc/inc_ad_item_email_template.cfm"/>
    </cfinvoke>
    </cfcase>
    </cfswitch>
    </cfloop>
    <!--- Send email notification. --->
    <cfinvoke 
    component="cfc.email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.emailSubject# - #ARGUMENTS.pName#"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.emailTo#"/>
    <cfinvokeargument name="from" value="#ARGUMENTS.emailFrom#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#VAR.aiID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ad_item/inc/inc_ad_item_email_template.cfm"/>
    </cfinvoke>
    <!---Revert back to update screen with new ad.--->
    <cfif ARGUMENTS.ainIDNew NEQ 0>
    <cflocation url="#CGI.SCRIPT_NAME#?appID=#url.appID#&taskPageID=AdItem&taskID=update&ID=#VAR.aiID#&ainIDNew=#ARGUMENTS.ainIDNew#" addtoken="no">
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProduct" access="public" returntype="struct">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="pesID" type="numeric" required="yes">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="pPageTitle" type="string" required="yes">
    <cfargument name="pDateRel" type="string" required="yes" default="#Now()#">
    <cfargument name="pDateExp" type="string" required="yes" default="#DateAdd('yyyy', 10, Now())#">
    <cfargument name="pBulletPoint" type="string" required="yes" default="">
    <cfargument name="pDescription" type="string" required="yes">
    <cfargument name="pKeyword" type="string" required="yes">
    <cfargument name="pMetaDescription" type="string" required="yes">
    <cfargument name="pCSL" type="string" required="yes">
    <cfargument name="pMPN" type="string" required="yes">
    <cfargument name="pstID" type="numeric" required="yes">
    <cfargument name="ptID" type="numeric" required="yes">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="ptempID" type="numeric" required="yes">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="pSort" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <!---Include relationships--->
    <cfargument name="docID" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Get the actual product ID.--->
    <cfinvoke 
    component="cfc.product"
    method="setProductID"
    returnvariable="setProductID">
    </cfinvoke>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="cfc.regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.product"
    method="getProduct"
    returnvariable="getCheckProductRet">
    <cfinvokeargument name="pName" value="#TRIM(ARGUMENTS.pName)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductRet.Recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pBulletPoint) GT 2048>
    <cfset result.message = "The bullet points are longer than 2048 characters, please enter new bullet points under 255 characters.">
    <cfelseif LEN(ARGUMENTS.pMetaDescription) GT 512>
    <cfset result.message = "The meta description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <!---Create bullet point tags.--->
    <cfinvoke 
    component="cfc.list"
    method="setBulletList"
    returnvariable="setBulletListRet">
    <cfinvokeargument name="listValue" value="#TRIM(ARGUMENTS.pBulletPoint)#"/>
    <cfinvokeargument name="type" value="unordered"/>
    </cfinvoke>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product (productID,vID,bID,pesID,pDateRel,pDateExp,pName,pPageTitle,pBulletPoint,pDescription,pKeyword,pMetaDescription,pCSL,pMPN,pstID,userID,ptID,ppID,pSort,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(setProductID)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pesID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pDateRel, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pDateExp, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pPageTitle)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#setBulletListRet#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pKeyword)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pMetaDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pCSL)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pMPN)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Set a result ID to be included with a link to the update form.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_product"/>
    </cfinvoke>
    <cfset result.ID = getMaxValueSQLRet>
    
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="cfc.product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#result.ID#">
    <cfinvokeargument name="pwfID" value="101">
    <cfinvokeargument name="pwfcComment" value="New Product Request created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    <!---Insert Relationships--->
    <!---Insert Detail (Default) relationships.--->
    <cfinvoke 
    component="cfc.product"
    method="insertProductDetail"
    >
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="pdName" value="Detail"/>
    <cfinvokeargument name="pdDescription" value="#ARGUMENTS.pDescription#"/>
    <cfinvokeargument name="pdDateRel" value="#ARGUMENTS.pDateRel#"/>
    <cfinvokeargument name="pdDateExp" value="#ARGUMENTS.pDateExp#"/>
    <cfinvokeargument name="pdtID" value="1"/>
    <cfinvokeargument name="pdSort" value="1"/>
    <cfinvokeargument name="pdStatus" value="1"/>
    </cfinvoke>
    <cfloop index="catalogID" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <!---Insert Catalog relationships.--->
    <cfinvoke 
    component="cfc.catalog"
    method="insertCatalogProductRel">
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    <cfinvokeargument name="cprDiscount" value="0"/>
    <cfinvokeargument name="cprDateExp" value="#DateFormat(ARGUMENTS.pDateExp, application.dateFormat)#"/>
    <cfinvokeargument name="cprStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert Product Department Relationships.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <!---Insert Product Department relationships.--->
    <cfinvoke 
    component="cfc.product"
    method="insertProductDepartmentRel">
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, i)#"/>
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="deptNo" value="#ListGetAt(ARGUMENTS.deptNo, ii)#"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfloop>

	<!---Set product document relationship.--->
    <cfinvoke 
    component="cfc.product"
    method="insertProductDocumentRel"
    >
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    
    <!---Insert new product request.--->
    <cfinvoke 
    component="cfc.product_workflow"
    method="insertProductWorkflowRequest"
    >
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="pwfID" value="111"/>
    <cfinvokeargument name="pwfrRequest" value="New Product Request for #ARGUMENTS.pName#."/>
    <cfinvokeargument name="pwfrtID" value="9"/>
    <cfinvokeargument name="pwfrDateRequired" value="#ARGUMENTS.pDateRel#"/>
    <cfinvokeargument name="pwfrsID" value="1"/>
    <cfinvokeargument name="pwfrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertAdItemQuestion" access="public" returntype="struct">
    <cfargument name="aiqQuestion" type="string" required="yes">
    <cfargument name="aiqRequired" type="numeric" required="yes">
    <cfargument name="aiqMessage" type="string" required="yes">
    <cfargument name="aiqtID" type="numeric" required="yes">
    <cfargument name="aiqSort" type="numeric" required="yes">
    <cfargument name="aiqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemQuestion"
    returnvariable="getCheckAdItemQuestionRet">
    <cfinvokeargument name="aiqQuestion" value="#ARGUMENTS.aiqQuestion#"/>
    <cfinvokeargument name="aiqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemQuestionRet.Recordcount NEQ 0>
    <cfset result.message = "The question #ARGUMENTS.aiqQuestion# already exists, please enter a new question.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item_question (aiqQuestion,aiqRequired,aiqMessage,aiqtID,aiqSort,aiqStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiqQuestion#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiqMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertAdItemQuestionResult" access="public" returntype="struct">
    <cfargument name="aiID" type="numeric" required="yes">
    <cfargument name="aiqID" type="numeric" required="yes">
    <cfargument name="aiqrAnswer" type="string" required="yes">
    <cfargument name="aiqrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemQuestionResult"
    returnvariable="getCheckAdItemQuestionResultRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="aiqID" value="#ARGUMENTS.aiqID#"/>
    <cfinvokeargument name="aiqrAnswer" value="#ARGUMENTS.aiqrAnswer#"/>
    <cfinvokeargument name="aiqrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemQuestionResultRet.Recordcount NEQ 0>
    <cfset result.message = "The question result already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item_question_result (aiID,aiqID,aiqrAnswer,aiqrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiqrAnswer#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqrStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertAdItemRegion" access="public" returntype="struct">
    <cfargument name="airName" type="string" required="yes">
    <cfargument name="airSort" type="numeric" required="yes">
    <cfargument name="airStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="cfc.regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.airName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemRegion"
    returnvariable="getCheckAdItemRegionRet">
    <cfinvokeargument name="airName" value="#ARGUMENTS.airName#"/>
    <cfinvokeargument name="airStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemRegionRet.Recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.airName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item_region (airName,airSort,airStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.airName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.airSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.airStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertAdItemName" access="public" returntype="struct">
    <cfargument name="ainName" type="string" required="yes">
    <cfargument name="ainDateStart" type="date" required="yes">
    <cfargument name="ainDateEnd" type="date" required="yes">
    <cfargument name="ainDateDue" type="date" required="yes">
    <cfargument name="ainStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="cfc.regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ainName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemName"
    returnvariable="getCheckAdItemNameRet">
    <cfinvokeargument name="ainName" value="#ARGUMENTS.ainName#"/>
    <cfinvokeargument name="ainDateStart" value="#ARGUMENTS.ainDateStart#"/>
    <cfinvokeargument name="ainDateEnd" value="#ARGUMENTS.ainDateEnd#"/>
    <cfinvokeargument name="ainStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemNameRet.Recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ainName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item_name (ainName,ainDateStart,ainDateEnd,ainStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ainName#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ainDateStart#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ainDateEnd#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <!---Get a list of users based on roles to inform them of a document being added.--->
    <cfif ARGUMENTS.urID NEQ 100 AND ARGUMENTS.emailNotify EQ 'true'> 
    <cfinvoke 
    component="cfc.user"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfset this.emailContent =
	"A new ad named '#ARGUMENTS.ainName#' has been created by #session.userName#. Please complete your Ad Item Submissions - <a href='http://#CGI.HTTP_HOST#/'>click here.</a><br/><br/>This ad will run from #ARGUMENTS.ainDateStart# - #ARGUMENTS.ainDateEnd#.  <u>Ad Items should be submitted no later than #ARGUMENTS.ainDateDue# for this ad.</u>"
	>
    <cfloop query="getUserRet" startrow="1" endrow="#getUserRet.RecordCount#">
    <cfinvoke 
    component="cfc.email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="NEW! Ad - #ARGUMENTS.ainName# - Ready for Ad Item Submissions"/>
    <cfinvokeargument name="to" value="#getUserRet.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItem" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ainID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="aiMonth" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="aiSkuList" type="string" required="yes" default="">
    <cfargument name="aiMPNList" type="string" required="yes" default="">
    <cfargument name="docFile" type="string" required="yes" default="">
    <cfargument name="docID" type="string" required="yes" default="0">
    <cfargument name="pBulletPoint" type="string" required="yes" default="">
    <cfargument name="aiListPriceL48" type="string" required="yes" default="">
    <cfargument name="aiListPriceAK" type="string" required="yes" default="">
    <cfargument name="aiListPriceCA" type="string" required="yes" default="">
    <cfargument name="aiListPriceCO" type="string" required="yes" default="">
    <cfargument name="aiSalePriceL48" type="string" required="yes" default="">
    <cfargument name="aiSalePriceAK" type="string" required="yes" default="">
    <cfargument name="aiSalePriceCA" type="string" required="yes" default="">
    <cfargument name="aiSalePriceCO" type="string" required="yes" default="">
    <cfargument name="vcName" type="string" required="yes" default="">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="vcEmail" type="string" required="yes" default="">
    <cfargument name="vcTelArea" type="string" required="yes" default="">
    <cfargument name="vcTelPrefix" type="string" required="yes" default="">
    <cfargument name="vcTelSuffix" type="string" required="yes" default="">
    <cfargument name="airID" type="string" required="yes" default="0">
    <cfargument name="aiComment" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="aiStatus" type="numeric" required="yes" default="1">
    <cfargument name="questionCount" type="numeric" required="yes">
    <cfargument name="emailSubject" type="string" required="yes" default="Updated Ad Item Submission">
    <cfargument name="emailFrom" type="string" required="yes" default="#session.userUserName#">
    <cfargument name="emailTo" type="string" required="yes" default="#application.adItemEmail#">
    <cfargument name="emailCC" type="string" required="yes" default="#session.userUserName#">
    <cfargument name="emailBCC" type="string" required="yes" default="">
    <cfargument name="emailType" type="string" required="yes" default="html">
    <!---See if ad item changed.--->
    <cfargument name="ainIDNew" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfif ARGUMENTS.ainIDNew NEQ 0>
    <!---Insert a new ad item based on changed ainID.--->
    <cfinvoke 
    component="cfc.ad_item" 
    method="insertAdItem" 
    returnvariable="result">
    <cfinvokeargument name="ainID" value="#ARGUMENTS.ainIDNew#">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">   
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#">
    <cfinvokeargument name="aiMonth" value="#ARGUMENTS.aiMonth#">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#">
    <cfinvokeargument name="aiSkuList" value="#ARGUMENTS.aiSkuList#">
    <cfinvokeargument name="aiMPNList" value="#ARGUMENTS.aiMPNList#">
    <cfinvokeargument name="docFile" value="#form.docFile#">
    <cfinvokeargument name="pBulletPoint" value="#ARGUMENTS.pBulletPoint#">
    <cfinvokeargument name="aiListPriceL48" value="#ARGUMENTS.aiListPriceL48#">
    <cfinvokeargument name="aiListPriceAK" value="#ARGUMENTS.aiListPriceAK#">
    <cfinvokeargument name="aiListPriceCA" value="#ARGUMENTS.aiListPriceCA#">
    <cfinvokeargument name="aiListPriceCO" value="#ARGUMENTS.aiListPriceCO#">
    <cfinvokeargument name="aiSalePriceL48" value="#ARGUMENTS.aiSalePriceL48#">
    <cfinvokeargument name="aiSalePriceAK" value="#ARGUMENTS.aiSalePriceAK#">
    <cfinvokeargument name="aiSalePriceCA" value="#ARGUMENTS.aiSalePriceCA#">
    <cfinvokeargument name="aiSalePriceCO" value="#ARGUMENTS.aiSalePriceCO#">
    <cfinvokeargument name="vcName" value="#ARGUMENTS.vcName#">
    <cfinvokeargument name="vID" value="#ARGUMENTS.vID#">
    <cfinvokeargument name="vcfName" value="#ARGUMENTS.vcfName#">
    <cfinvokeargument name="vclName" value="#ARGUMENTS.vclName#">
    <cfinvokeargument name="vcEmail" value="#ARGUMENTS.vcEmail#">
    <cfinvokeargument name="vcTelArea" value="#ARGUMENTS.vcTelArea#">
    <cfinvokeargument name="vcTelPrefix" value="#ARGUMENTS.vcTelPrefix#">
    <cfinvokeargument name="vcTelSuffix" value="#ARGUMENTS.vcTelSuffix#">
    <cfinvokeargument name="airID" value="#ARGUMENTS.airID#">  
    <cfinvokeargument name="aiComment" value="#ARGUMENTS.aiComment#">
    <cfinvokeargument name="userID" value="#session.userID#"> 
    <cfinvokeargument name="urID" value="#session.urID#">
    <cfinvokeargument name="aiStatus" value="1">
    <cfinvokeargument name="questionCount" value="#ARGUMENTS.questionCount#"/>
    <cfinvokeargument name="ainIDNew" value="#ARGUMENTS.ainIDNew#">                    
    </cfinvoke>
    <!---Get the ID of the ad item just added.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_ad_item"/>
    </cfinvoke>
    <cfset ARGUMENTS.ID = getMaxValueSQLRet>
    
    <cfelse>
    
    <!---Update the ad item.--->
    <cfset VAR.pID = ARGUMENTS.pID>
    <cfset VAR.vID = ARGUMENTS.vID>
    <cfset VAR.vcID = 0>
    <!---Insert the sku file if it exists.--->
    <cfif form.docFile NEQ ''>
    <cfif ARGUMENTS.docID NEQ 0>
    <cfinvoke 
    component="cfc.document"
    method="deleteDocument"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.docID#"/>
    </cfinvoke>
    </cfif>
    <cfinvoke 
    component="cfc.document" 
    method="insertDocument" 
    >
    <cfinvokeargument name="docName" value="#ARGUMENTS.pName#">
    <cfinvokeargument name="docDescription" value="#ARGUMENTS.pName#"> 
    <cfinvokeargument name="docFile" value="#form.docFile#">
    <cfinvokeargument name="docDateRel" value="#DateFormat(Now(), application.dateFormat)#">
    <cfinvokeargument name="docDateExp" value="#DateFormat(DateAdd('d', '90', Now()), application.dateFormat)#">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#">
    <cfinvokeargument name="doctID" value="#application.adItemDocumentType#">
    <cfinvokeargument name="netID" value="#application.networkID#">
    <cfinvokeargument name="docSort" value="1">
    <cfinvokeargument name="docStatus" value="1">
    <!---Email arguments.--->
    <cfinvokeargument name="emailNotify" value="false">
    <!---Relationship arguments.--->
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#">
    <cfinvokeargument name="siteNo" value="100">
    <cfinvokeargument name="deptNo" value="#form.deptNo#">                    
    </cfinvoke>
    <!---Get latest ad item id.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="docIDValue">
    <cfinvokeargument name="tableName" value="tbl_document"/>
    </cfinvoke>
    <cfset VAR.docID = docIDValue>
    <cfelse>
    <cfset VAR.docID = ARGUMENTS.docID>
    </cfif>
    
    
    <!---Get existing Vendor Contact if applicable.--->
    <cfif ARGUMENTS.vcName NEQ '' AND ARGUMENTS.vID EQ 0>
    <cfinvoke 
    component="cfc.vendor" 
    method="getVendorContact" 
    returnvariable="getVendorContactRet"
    >
    <cfinvokeargument name="vcName" value="#ARGUMENTS.vcName#"> 
    <cfinvokeargument name="vcStatus" value="1,3">                   
    </cfinvoke>
    <cfif getVendorContactRet.Recordcount NEQ 0>
    <cfset VAR.vID = getVendorContactRet.vID>
    <cfset VAR.vcID = getVendorContactRet.ID>
    </cfif>
    </cfif>
    
    <!---Create a new Vendor Contact if applicable.--->
    <cfif ARGUMENTS.vID NEQ 0 AND ARGUMENTS.vcfName NEQ '' AND ARGUMENTS.vclName NEQ '' AND ARGUMENTS.vcEmail NEQ '' AND ARGUMENTS.vcName EQ ''>
    <cfset VAR.vID = ARGUMENTS.vID>
    <cfinvoke 
    component="cfc.vendor" 
    method="insertVendorContact" 
    >
    <cfinvokeargument name="vID" value="#VAR.vID#">
    <cfinvokeargument name="vcfName" value="#ARGUMENTS.vcfName#"> 
    <cfinvokeargument name="vclName" value="#ARGUMENTS.vclName#">
    <cfinvokeargument name="vcAddress" value="Source: Custom Ad Item">
    <cfinvokeargument name="vcAddressExt" value="">
    <cfinvokeargument name="vcCity" value="">
    <cfinvokeargument name="vcStateProv" value="">
    <cfinvokeargument name="vcZipCode" value="">
    <cfinvokeargument name="vcZipCodeExt" value="">
    <cfinvokeargument name="vcCountry" value="">
    <cfinvokeargument name="vcTelArea" value="#ARGUMENTS.vcTelArea#">
    <cfinvokeargument name="vcTelPrefix" value="#ARGUMENTS.vcTelPrefix#">
    <cfinvokeargument name="vcTelSuffix" value="#ARGUMENTS.vcTelSuffix#">
    <cfinvokeargument name="vcFaxArea" value="">
    <cfinvokeargument name="vcFaxPrefix" value="">
    <cfinvokeargument name="vcFaxSuffix" value="">
    <cfinvokeargument name="vcEmail" value="#ARGUMENTS.vcEmail#">
    <cfinvokeargument name="vcUrl" value="">
    <cfinvokeargument name="vcSourceUsername" value="">
    <cfinvokeargument name="vcSourcePassword" value="">
    <cfinvokeargument name="vcSourceUrl" value="">
    <cfinvokeargument name="vcSort" value="1">
    <cfinvokeargument name="vcStatus" value="1">                     
    </cfinvoke>
    <!---Get latest ad item id.--->
    <cfinvoke 
    component="cfc.cms"
    method="getMaxValueSQL"
    returnvariable="vcIDRecord">
    <cfinvokeargument name="tableName" value="tbl_vendor_contact"/>
    </cfinvoke>
    <cfset VAR.vcID = vcIDRecord>
    </cfif>
    
    <!---Create bullet point tags.--->
    <cfinvoke 
    component="cfc.list"
    method="setBulletList"
    returnvariable="setBulletListRet">
    <cfinvokeargument name="listValue" value="#TRIM(ARGUMENTS.pBulletPoint)#"/>
    <cfinvokeargument name="type" value="unordered"/>
    </cfinvoke>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item SET
    ainID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">,
    vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#VAR.vID#">,
    vcID = <cfqueryparam cfsqltype="cf_sql_integer" value="#VAR.vcID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    aiMonth = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiMonth#">,
    aiBulletPoint = <cfqueryparam cfsqltype="cf_sql_varchar" value="#setBulletListRet#">,
    aiSkuList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiSkuList#">,
    aiMPNList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiMPNList#">,
    docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#VAR.docID#">,
    aiDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    aiListPriceL48 = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceL48 EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceL48))#">,
    aiListPriceAK = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceAK EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceAK))#">,
    aiListPriceCA = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceCA EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceCA))#">,
    aiListPriceCO = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiListPriceCO EQ '', DE('0.00'), DE(ARGUMENTS.aiListPriceCO))#">,
    aiSalePriceL48 = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceL48 EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceL48))#">,
    aiSalePriceAK = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceAK EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceAK))#">,
    aiSalePriceCA = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceCA EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceCA))#">,
    aiSalePriceCO = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.aiSalePriceCO EQ '', DE('0.00'), DE(ARGUMENTS.aiSalePriceCO))#">,
	aiComment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiComment#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    aiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="cfc.ad_item"
    method="deleteAdItemRegionRel"
    returnvariable="deleteAdItemRegionRelRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfloop list="#ARGUMENTS.airID#" index="i">
    <!---Now insert product ad item region relationship.--->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item_region_rel (aiID,airID,airrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#i#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cfloop>
    <cfinvoke 
    component="cfc.ad_item"
    method="deleteAdItemQuestionResult"
    returnvariable="deleteAdItemQuestionResultRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Complete the Question Result insert.--->
    <cfloop index="questionID" from="1" to="#ARGUMENTS.questionCount#">
    <cfif IsDefined("form.aiqrAnswer#questionID#")>
    <cfinvoke 
    component="cfc.ad_item"
    method="insertAdItemQuestionResult"
    >
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiqID" value="#Evaluate('form.aiqID#questionID#')#"/>
    <cfinvokeargument name="aiqrAnswer" value="#Evaluate('form.aiqrAnswer#questionID#')#"/>
    <cfinvokeargument name="aiqrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <!---Reformat for bullet points.--->
    <cfif Evaluate('form.aiqtID#questionID#') EQ 3>
    <cfset bulletedQuestion = 'xxxxx'>
    <cfloop index="ii" from="1" to="#application.adItemBulletCount#">
    <cfif IsDefined('form.aiqrAnswer#questionID#x#ii#')>
    <cfset bulletedQuestion = ListPrepend(Evaluate('form.aiqrAnswer#questionID#x#ii#'), bulletedQuestion, '|')>
    </cfif>
	</cfloop>
    <!---Cleanup string.--->
    <cfset bulletedQuestion = Replace(bulletedQuestion, 'xxxxx|', '', 'All')>
	<cfinvoke 
    component="cfc.ad_item"
    method="insertAdItemQuestionResult"
    returnvariable="result">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiqID" value="#Evaluate('form.aiqID#questionID#')#"/>
    <cfinvokeargument name="aiqrAnswer" value="#bulletedQuestion#"/>
    <cfinvokeargument name="aiqrStatus" value="1"/>
    </cfinvoke>
	</cfif>
    <!--- Send special email notification based on questions. --->
    <cfswitch expression="#Evaluate('form.aiqtID#questionID#')#">
    <cfcase value="110">
    <cfinvoke 
    component="cfc.email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.emailSubject# - #ARGUMENTS.pName# - Special Pricing"/>
    <cfinvokeargument name="to" value="#application.adItemEmailAlt#"/>
    <cfinvokeargument name="from" value="#ARGUMENTS.emailFrom#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#VAR.aiID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ad_item/inc/inc_ad_item_email_template.cfm"/>
    </cfinvoke>
    </cfcase>
    </cfswitch>
    </cfloop>
    </cfif>   
    <!--- Send email notification. --->
    <cfinvoke 
    component="cfc.email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.emailSubject# - #ARGUMENTS.pName#"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.emailTo#"/>
    <cfinvokeargument name="from" value="#ARGUMENTS.emailFrom#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ad_item/inc/inc_ad_item_email_template.cfm"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemQuestionResult" access="public" returntype="struct">
    <cfargument name="aiID" type="numeric" required="yes">
    <cfargument name="aiqID" type="numeric" required="yes">
    <cfargument name="aiqrAnswer" type="string" required="yes">
    <cfargument name="aiqrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemQuestionResult"
    returnvariable="getCheckAdItemQuestionResultRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="aiqID" value="#ARGUMENTS.aiqID#"/>
    <cfinvokeargument name="aiqrAnswer" value="#ARGUMENTS.aiqrAnswer#"/>
    <cfinvokeargument name="aiqrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemQuestionResultRet.Recordcount NEQ 0>
    <cfset result.message = "The question result already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item_question_result SET
    aiID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">,
    aiqID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqID#">,
    aiqrAnswer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiqrAnswer#">,
    aiqrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqrStatus#">
    WHERE aiID = <cfqueryparam value="#ARGUMENTS.aiID#" cfsqltype="cf_sql_integer"> AND aiqID = <cfqueryparam value="#ARGUMENTS.aiqID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiqQuestion" type="string" required="yes">
    <cfargument name="aiqRequired" type="numeric" required="yes">
    <cfargument name="aiqMessage" type="string" required="yes">
    <cfargument name="aiqtID" type="numeric" required="yes">
    <cfargument name="aiqSort" type="numeric" required="yes">
    <cfargument name="aiqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemQuestion"
    returnvariable="getCheckAdItemQuestionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiqQuestion" value="#ARGUMENTS.aiqQuestion#"/>
    <cfinvokeargument name="aiqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemQuestionRet.Recordcount NEQ 0>
    <cfset result.message = "The question #ARGUMENTS.aiqQuestion# already exists, please enter a new question.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item_question SET
    aiqQuestion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiqQuestion#">,
    aiqRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqRequired#">,
    aiqMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiqMessage#">,
    aiqtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqtID#">,
    aiqSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqSort#">,
    aiqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemRegion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="airName" type="string" required="yes">
    <cfargument name="airSort" type="numeric" required="yes">
    <cfargument name="airStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="cfc.regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.airName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemRegion"
    returnvariable="getCheckAdItemRegionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="airName" value="#ARGUMENTS.airName#"/>
    <cfinvokeargument name="airStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAdItemRegionRet.Recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.airName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item_region SET
    airName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.airName#">,
    airSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.airSort#">,
    airStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.airStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemName" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ainName" type="string" required="yes">
    <cfargument name="ainDateStart" type="date" required="yes">
    <cfargument name="ainDateEnd" type="date" required="yes">
    <cfargument name="ainStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="cfc.regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ainName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.ad_item"
    method="getAdItemName"
    returnvariable="getCheckAddItemNameRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ainName" value="#ARGUMENTS.ainName#"/>
    <cfinvokeargument name="ainDateStart" value="#ARGUMENTS.ainDateStart#"/>
    <cfinvokeargument name="ainDateEnd" value="#ARGUMENTS.ainDateEnd#"/>
    <cfinvokeargument name="ainStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAddItemNameRet.Recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ainName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item_name SET
    ainName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ainName#">,
    ainDateStart = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ainDateStart#">,
    ainDateEnd = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ainDateEnd#">,
    ainStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Get a list of users based on roles to inform them of a document being added.--->
    <cfif ARGUMENTS.urID NEQ 100 AND ARGUMENTS.emailNotify EQ 'true'> 
    <cfinvoke 
    component="cfc.user"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfset this.emailContent =
	"'#ARGUMENTS.ainName#' has been updated by #session.userName#. Please complete your Ad Item Submissions - <a href='http://#CGI.HTTP_HOST#/'>click here.</a><br/><br/>This ad will run from #ARGUMENTS.ainDateStart# - #ARGUMENTS.ainDateEnd#.  <u>Ad Items should be submitted no later than #ARGUMENTS.ainDateDue# for this ad.</u>"
	>
    <cfloop query="getUserRet" startrow="1" endrow="#getUserRet.RecordCount#">
    <cfinvoke 
    component="cfc.email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="UPDATED! Ad - #ARGUMENTS.ainName# - Ready for Ad Item Submissions"/>
    <cfinvokeargument name="to" value="#getUserRet.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item SET
    aiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemQuestionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item_question SET
    aiqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemRegionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="airStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item_region SET
    airStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.airStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAdItemNameList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ainStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ad_item_name SET
    ainStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAdItem" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ad_item
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="cfc.ad_item"
    method="deleteAdItemBullet"
    returnvariable="deleteAdItemBulletRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.ad_item"
    method="deleteAdItemRegionRel"
    returnvariable="deleteAdItemRegionRelRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.ad_item"
    method="deleteAdItemQuestionResult"
    returnvariable="deleteAdItemQuestionResultRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAdItemQuestionResult" access="public" returntype="struct">
    <cfargument name="aiID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ad_item_question_result
    WHERE aiID = <cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.aiID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAdItemQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ad_item_question
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteAdItemRegion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ad_item_region
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ad_item_region_rel
    WHERE airID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteAdItemRegionRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aiID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ad_item_region_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aiID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.aiID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAdItemName" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ad_item_name
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>