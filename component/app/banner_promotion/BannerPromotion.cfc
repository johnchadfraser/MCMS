<cfcomponent>
    <cffunction name="getBannerPromotion" access="public" returntype="query" hint="Get Banner Promotion data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bpTitle" type="string" required="yes" default="">
    <cfargument name="bpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bpSort, bpTitle">
    <cfset var rsBannerPromotion = "" >
    <cftry>
    <cfquery name="rsBannerPromotion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_banner_promotion WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bpTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bpDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.bpTitle NEQ "">
    AND UPPER(bpTitle) = <cfqueryparam value="#UCASE(ARGUMENTS.bpTitle)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND bpStatus IN (<cfqueryparam value="#ARGUMENTS.bpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBannerPromotion = StructNew()>
    <cfset rsBannerPromotion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBannerPromotion>
    </cffunction>
    
    <cffunction name="getBannerPromotionAttribute" access="public" returntype="query" hint="Get Banner Promotion Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bpaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bpaName">
    <cfset var rsBannerPromotionAttribute = "" >
    <cftry>
    <cfquery name="rsBannerPromotionAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_banner_promotion_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(bpaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND bpaStatus IN (<cfqueryparam value="#ARGUMENTS.bpaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBannerPromotionAttribute = StructNew()>
    <cfset rsBannerPromotionAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBannerPromotionAttribute>
    </cffunction>
    
    <cffunction name="getBannerPromotionMotion" access="public" returntype="query" hint="Get Banner Promotion Motion data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bpaID" type="numeric" required="yes" default="0">
    <cfargument name="bpmName" type="string" required="yes" default="">
    <cfargument name="bpmStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bpmName">
    <cfset var rsBannerPromotionMotion = "" >
    <cftry>
    <cfquery name="rsBannerPromotionMotion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_banner_promotion_motion WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bpmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bpmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.bpaID NEQ 0>
    AND bpaID = <cfqueryparam value="#ARGUMENTS.bpaID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bpmName NEQ "">
    AND UPPER(bpmName) = <cfqueryparam value="#UCASE(ARGUMENTS.bpmName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND bpmStatus IN (<cfqueryparam value="#ARGUMENTS.bpmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBannerPromotionMotion = StructNew()>
    <cfset rsBannerPromotionMotion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBannerPromotionMotion>
    </cffunction>
    
    <cffunction name="getBannerPromotionReport" access="public" returntype="query" hint="Get Banner Promotion Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="bpTitle">
    <cfset var rsBannerPromotionReport = "" >
    <cftry>
    <cfquery name="rsBannerPromotionReport" datasource="#application.mcmsDSN#">
    SELECT bpTitle, bpDescription FROM v_banner_promotion WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bpTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bpDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBannerPromotionReport = StructNew()>
    <cfset rsBannerPromotionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBannerPromotionReport>
    </cffunction>
    
    <cffunction name="getBannerPromotionAttributeReport" access="public" returntype="query" hint="Get Banner Promotion Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="bpaName">
    <cfset var rsBannerPromotionAttributeReport = "" >
    <cftry>
    <cfquery name="rsBannerPromotionAttributeReport" datasource="#application.mcmsDSN#">
    SELECT bpaName FROM tbl_banner_promotion_attribute WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(bpaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBannerPromotionAttributeReport = StructNew()>
    <cfset rsBannerPromotionAttributeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBannerPromotionAttributeReport>
    </cffunction>
    
    <cffunction name="getBannerPromotionMotionReport" access="public" returntype="query" hint="Get Banner Promotion Motion Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="bpTitle">
    <cfset var rsBannerPromotionMotionReport = "" >
    <cftry>
    <cfquery name="rsBannerPromotionMotionReport" datasource="#application.mcmsDSN#">
    SELECT bpmName, bpmDescription, bpaName FROM v_banner_promotion_motion WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bpmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bpmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBannerPromotionMotionReport = StructNew()>
    <cfset rsBannerPromotionMotionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBannerPromotionMotionReport>
    </cffunction>
    
    <cffunction name="insertBannerPromotion" access="public" returntype="struct">
    <cfargument name="bpTitle" type="string" required="yes">
    <cfargument name="bpDescription" type="string" required="yes">
    <cfargument name="bpURL" type="string" required="yes">
    <cfargument name="bpTarget" type="string" required="yes">
    <cfargument name="imgIDImage" type="numeric" required="yes">
    <cfargument name="imgIDBackground" type="numeric" required="yes">
    <cfargument name="bpmIDTitle" type="numeric" required="yes">
    <cfargument name="bpmIDDescription" type="numeric" required="yes">
    <cfargument name="bpmIDImage" type="numeric" required="yes">
    <cfargument name="bpDuration" type="numeric" required="yes">
    <cfargument name="bpDateRel" type="date" required="yes">
    <cfargument name="bpDateExp" type="date" required="yes">
    <cfargument name="bpSort" type="numeric" required="yes">
    <cfargument name="bpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.bpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.banner_promotion.BannerPromotion"
    method="getBannerPromotion"
    returnvariable="getCheckBannerPromotionRet">
    <cfinvokeargument name="bpTitle" value="#ARGUMENTS.bpTitle#"/>
    <cfinvokeargument name="bpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBannerPromotionRet.recordcount NEQ 0>
    <cfset result.message = "The title #ARGUMENTS.bpTitle# already exists, please enter a new title.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.bpDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_banner_promotion (bpTitle,bpDescription,bpURL,bpTarget,imgIDImage,imgIDBackground,bpmIDTitle,bpmIDDescription,bpmIDImage,bpDuration,bpDateRel,bpDateExp,bpSort,bpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpTitle#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpTarget#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgIDImage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgIDBackground#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmIDTitle#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmIDDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmIDImage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpDuration#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bpDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bpDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpStatus#">
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
    
    <cffunction name="updateBannerPromotion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bpTitle" type="string" required="yes">
    <cfargument name="bpDescription" type="string" required="yes">
    <cfargument name="bpURL" type="string" required="yes">
    <cfargument name="bpTarget" type="string" required="yes">
    <cfargument name="imgIDImage" type="numeric" required="yes">
    <cfargument name="imgIDBackground" type="numeric" required="yes">
    <cfargument name="bpmIDTitle" type="numeric" required="yes">
    <cfargument name="bpmIDDescription" type="numeric" required="yes">
    <cfargument name="bpmIDImage" type="numeric" required="yes">
    <cfargument name="bpDuration" type="numeric" required="yes">
    <cfargument name="bpDateRel" type="date" required="yes">
    <cfargument name="bpDateExp" type="date" required="yes">
    <cfargument name="bpSort" type="numeric" required="yes">
    <cfargument name="bpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.bpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.banner_promotion.BannerPromotion"
    method="getBannerPromotion"
    returnvariable="getCheckBannerPromotionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="bpTitle" value="#ARGUMENTS.bpTitle#"/>
    <cfinvokeargument name="bpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBannerPromotionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.bpTitle# already exists, please enter a new title.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.bpDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_banner_promotion SET
    bpTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpTitle#">,
    bpDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpDescription#">,
    bpURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpURL#">,
    bpTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpTarget#">,
    imgIDImage = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgIDImage#">,
    imgIDBackground = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgIDBackground#">,
    bpmIDTitle = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmIDTitle#">,
    bpmIDDescription = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmIDDescription#">,
    bpmIDImage = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmIDImage#">,
    bpDuration = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpDuration#">,
    bpDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bpDateRel#">,
    bpDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bpDateExp#">,
    bpSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpSort#">,
    bpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpStatus#">
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
    
    <cffunction name="updateBannerPromotionMotion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bpmName" type="string" required="yes">
    <cfargument name="bpmDescription" type="string" required="yes">
    <cfargument name="bpaID" type="numeric" required="yes">
    <cfargument name="startX" type="numeric" required="yes">
    <cfargument name="startY" type="numeric" required="yes">
    <cfargument name="endX" type="numeric" required="yes">
    <cfargument name="endY" type="numeric" required="yes">
    <cfargument name="startScale" type="string" required="yes">
    <cfargument name="endScale" type="string" required="yes">
    <cfargument name="startAlpha" type="string" required="yes">
    <cfargument name="endAlpha" type="string" required="yes">
    <cfargument name="motionDelay" type="string" required="yes">
    <cfargument name="motionDuration" type="string" required="yes">
    <cfargument name="bpmColor" type="string" required="yes">
    <cfargument name="bpmSize" type="string" required="yes">
    
    <cfargument name="bpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.bpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.banner_promotion.BannerPromotion"
    method="getBannerPromotionMotion"
    returnvariable="getCheckBannerPromotionMotionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="bpmName" value="#ARGUMENTS.bpmName#"/>
    <cfinvokeargument name="bpmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBannerPromotionMotionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.bpmName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.bpmDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_banner_promotion_motion SET
    bpmName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpmName#">,
    bpmDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpmDescription#">,
    bpaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpaID#">,
    startX = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.startX#">,
    startY = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.startY#">,
    endX = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.endX#">,
    endY = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.endY#">,
    startScale = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.startScale#">,
    endScale = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.endScale#">,
    startAlpha = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.endScale#">,
    endAlpha = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.endAlpha#">,
    motionDelay = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.motionDelay#">,
    motionDuration = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.motionDuration#">,
    bpmColor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpmColor#">,
    bpmSize = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmSize#">,
    bpmdsDistance = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bpmdsDistance#">,
    bpmdsAngle = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmdsAngle#">,
    bpmdsColor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpmdsColor#">,
    bpmdsAlpha = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bpmdsAlpha#">,
    bpmdsBlur = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bpmdsBlur#">,
    bpmgColor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bpmgColor#">,
    bpmgAlpha = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bpmgAlpha#">,
    bpmgBlur = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bpmgBlur#">,
    bpmDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    bpmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmStatus#">
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
    
    <cffunction name="updateBannerPromotionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_banner_promotion SET
    bpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateBannerPromotionMotionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bpmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_banner_promotion_motion SET
    bpmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bpmStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteBannerPromotion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_banner_promotion
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteBannerPromotionMotion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_banner_promotion_motion
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