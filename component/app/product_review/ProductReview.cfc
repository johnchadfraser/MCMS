<cfcomponent>
    <cffunction name="getProductReview" access="public" returntype="query" hint="Get ProductReview data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="proName" type="string" required="yes" default="">
    <cfargument name="proID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="prStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="proName">
    <cfset var rsProductReview = "" >
    <cftry>
    <cfquery name="rsProductReview" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_review WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(proName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(prDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(prName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.proName NEQ "">
    AND UPPER(proName) = <cfqueryparam value="#UCASE(ARGUMENTS.proName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.proID NEQ 0>
    AND proID = <cfqueryparam value="#ARGUMENTS.proID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND prStatus IN (<cfqueryparam value="#ARGUMENTS.prStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductReview = StructNew()>
    <cfset rsProductReview.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductReview>
    </cffunction>
    
    <cffunction name="getProductReviewReport" access="public" returntype="query" hint="Get ProductReview Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="status" type="string" required="yes" default="1,2,3">
    <cfargument name="orderBy" type="string" required="yes" default="proName">
    <cfset var rsProductReviewReport = "" >
    <cftry>
    <cfquery name="rsProductReviewReport" datasource="#application.mcmsDSN#">
    SELECT proID AS Product_ID, proName AS Product_Name, deptName AS Department, deptNo AS Dept_No, TO_CHAR(prDescription) AS Description, prName AS Name, prCity AS City, prStateProv AS State_Prov, TO_CHAR(prDate, 'MM/DD/YYYY') AS Review_Date, TO_CHAR(prDateExp, 'MM/DD/YYYY') AS Exp_Date, prrateID AS Rating, sName AS Status FROM v_product_review WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(proName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(prDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(prName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND prStatus IN (<cfqueryparam value="#ARGUMENTS.status#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductReviewReport = StructNew()>
    <cfset rsProductReviewReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductReviewReport>
    </cffunction>
    
    <cffunction name="insertProductReview" access="public" returntype="struct">
    <cfargument name="proID" type="string" required="yes">
    <cfargument name="catID" type="string" required="yes">
    <cfargument name="proName" type="string" required="yes">
    <cfargument name="prName" type="string" required="yes">
    <cfargument name="prCity" type="string" required="yes">
    <cfargument name="prStateProv" type="string" required="yes">
    <cfargument name="prDescription" type="string" required="yes">
    <cfargument name="prDateExp" type="date" required="yes">
    <cfargument name="imgFile" type="string" required="yes">
    <cfargument name="prrecID" type="numeric" required="yes">
    <cfargument name="prrateID" type="numeric" required="yes">
    <cfargument name="prStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.prDescription)#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.prDescription) GT 4096>
    <cfset result.message = "The description is longer than 4096 characters, please enter a new name under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_review (proID,catID,proName,prName,prCity,prStateProv,prDescription,prDateExp,imgFile,prrecID,prrateID,prStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.proID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.catID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.proName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prCity)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prStateProv)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.prDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.imgFile)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prrecID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prrateID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prStatus#">
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
    
    <cffunction name="updateProductReview" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="proID" type="string" required="yes">
    <cfargument name="catID" type="string" required="yes">
    <cfargument name="proName" type="string" required="yes">
    <cfargument name="prName" type="string" required="yes">
    <cfargument name="prCity" type="string" required="yes">
    <cfargument name="prStateProv" type="string" required="yes">
    <cfargument name="prDescription" type="string" required="yes">
    <cfargument name="prDateExp" type="date" required="yes">
    <cfargument name="imgFile" type="string" required="yes">
    <cfargument name="prrecID" type="numeric" required="yes">
    <cfargument name="prrateID" type="numeric" required="yes">
    <cfargument name="prStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check length restriction.--->
    <cfif LEN(ARGUMENTS.prDescription) GT 4096>
    <cfset result.message = "The description is longer than 4096 characters, please enter a new name under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_review SET
    proID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.proID#">,
    catID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.catID#">,
    proName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.proName)#">,
    prName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prName)#">,
    prCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prCity)#">,
    prStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prStateProv)#">,
    prDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.prDescription)#">,
    prDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.prDateExp#">,
    imgFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.imgFile)#">,
    prrecID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prrecID#">,
    prrateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prrateID#">,
		<cfif ARGUMENTS.uaID NEQ 101>
    prDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    prStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prStatus#">
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
    
    <cffunction name="updateProductReviewList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="prStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_review SET
    prStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductReview" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_review
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