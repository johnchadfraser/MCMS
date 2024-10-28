<cfcomponent>
    <cffunction name="getSecurityImage" access="public" returntype="query" hint="Get Security Image data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="siName" type="string" required="yes" default="">
    <cfargument name="imgID" type="string" required="yes" default="0">
    <cfargument name="netID" type="string" required="yes" default="#application.networkID#">
    <cfargument name="siStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siSort, siName">
    <cfset var rsSecurityImage = "" >
    <cftry>
    <cfquery name="rsSecurityImage" datasource="#application.mcmsDSN#">
    SELECT * FROM v_security_image WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(siName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siName NEQ "">
    AND UPPER(siName) = <cfqueryparam value="#UCASE(ARGUMENTS.siName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND siStatus IN (<cfqueryparam value="#ARGUMENTS.siStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecurityImage = StructNew()>
    <cfset rsSecurityImage.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecurityImage>
    </cffunction>
    
    <cffunction name="getPasswordHint" access="public" returntype="query" hint="Get Password Hint data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="phQuestion" type="string" required="yes" default="">
    <cfargument name="phStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="phSort, phQuestion">
    <cfset var rsPasswordHint = "" >
    <cftry>
    <cfquery name="rsPasswordHint" datasource="#application.mcmsDSN#">
    SELECT * FROM v_password_hint WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(phQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.phQuestion NEQ "">
    AND UPPER(phQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.phQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND phStatus IN (<cfqueryparam value="#ARGUMENTS.phStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPasswordHint = StructNew()>
    <cfset rsPasswordHint.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPasswordHint>
    </cffunction>
    
    <cffunction name="getSecurityImageReport" access="public" returntype="query" hint="Get Security Image Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="siSort, siName">
    <cfset var rsSecurityImageReport = "" >
    <cftry>
    <cfquery name="rsSecurityImageReport" datasource="#application.mcmsDSN#">
    SELECT siName AS Name, imgFile AS Image, sortName AS Sort, sName AS Status FROM v_security_image WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(siName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecurityImageReport = StructNew()>
    <cfset rsSecurityImageReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecurityImageReport>
    </cffunction>
    
    <cffunction name="getPasswordHintReport" access="public" returntype="query" hint="Get Password Hint Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="phSort, phQuestion">
    <cfset var rsPasswordHintReport = "" >
    <cftry>
    <cfquery name="rsPasswordHintReport" datasource="#application.mcmsDSN#">
    SELECT phQuestion AS Question, sortName AS Sort, sName AS Status FROM v_password_hint WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(phQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPasswordHintReport = StructNew()>
    <cfset rsPasswordHintReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPasswordHintReport>
    </cffunction>
    
    <cffunction name="setEcryption" access="public" returntype="struct" hint="Set a value to an encrypted value.">
    <cfargument name="value" type="string" required="yes">
    <cfargument name="valuePair" type="string" required="yes" default="1">
    <cfargument name="keyType" type="string" required="yes" default="AES">
    <cfargument name="encryptType" type="string" required="yes" default="RC4">
    <cfset e = StructNew()>
    <cftry>
    <cfset e.encryptKey = GenerateSecretKey(ARGUMENTS.keyType)>
    <cfset e.encryptValuePair = ARGUMENTS.valuePair & ARGUMENTS.value>
    <cfset e.encryptKeyValue = Encrypt(e.encryptValuePair, e.encryptKey, ARGUMENTS.encryptType)> 
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset e = StructNew()>
    <cfset e.message = "There was an error with the encryption.">
    
    </cfcatch>
    </cftry>
    <cfreturn e>
    </cffunction>
    
    <cffunction name="setDecryption" access="public" returntype="string" hint="Set a value for a decrypted value.">
    <cfargument name="encryptKey" type="string" required="yes" default="">
    <cfargument name="encryptKeyValue" type="string" required="yes" default="">
    <cfargument name="encryptType" type="string" required="yes" default="RC4">
    <cfset var decryptValue = "" >
    <cftry>
    <cfset decryptValue = Decrypt(ARGUMENTS.encryptKeyValue, ARGUMENTS.encryptKey, ARGUMENTS.encryptType)>
    <cfset decryptValue = Replace(decryptValue, 'lorem', '', 'ALL')> 
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset decryptValue = StructNew()>
    <cfset decryptValue.message = "There was an error with the encryption.">
    
    </cfcatch>
    </cftry>
    <cfreturn decryptValue>
    </cffunction>
    
    <cffunction name="setTimeoutWarning" access="public" returntype="any" hint="Sets the timeout warning to count down for each request in seconds.">
    <cfargument name="args" type="struct" required="yes" default="">
    <cfset var result = "">
    <cftry>
    <cfinvoke 
    component="MCMS.component.utility.Xml"
    method="wddxFileToXML"
    returnvariable="timeout">
    <cfinvokeargument name="wddxFilePath" value="#ARGUMENTS.args.wddxFilePath#"/>
    <cfinvokeargument name="rootElement" value="#ARGUMENTS.args.rootElement#"/>
    </cfinvoke>
    <cfset timeout = CreateTimeSpan(ListGetAt(timeout, 1),ListGetAt(timeout, 2),ListGetAt(timeout, 3),ListGetAt(timeout, 4))>
    <cfset timeoutHour = DatePart('h', timeout)*3600>
    <cfset timeoutMinute = DatePart('n', timeout)*60>
    <cfset timeoutSecond = DatePart('s', timeout)>
    <cfset result = timeoutHour+timeoutMinute+timeoutSecond>
    <cfreturn result>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = StructNew()>
    <cfset result.message = "There was an error with the encryption.">
    <cfdump var="#CFCATCH#">
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="insertSecurityImage" access="public" returntype="struct">
    <cfargument name="siName" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="siSort" type="numeric" required="yes">
    <cfargument name="siStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="getSecurityImage"
    returnvariable="getCheckSecurityImageRet">
    <cfinvokeargument name="siName" value="#ARGUMENTS.siName#"/>
    <cfinvokeargument name="siStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSecurityImageRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.siName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_security_image (siName,imgID,siSort,siStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siStatus#">
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
    
    <cffunction name="insertPasswordHint" access="public" returntype="struct">
    <cfargument name="phQuestion" type="string" required="yes">
    <cfargument name="phSort" type="numeric" required="yes">
    <cfargument name="phStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="getPasswordHint"
    returnvariable="getCheckPasswordHintRet">
    <cfinvokeargument name="phQuestion" value="#ARGUMENTS.phQuestion#"/>
    <cfinvokeargument name="phStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPasswordHintRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.phQuestion# already exists, please enter a new question.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_password_hint (phQuestion,phSort,phStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.phQuestion#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.phSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.phStatus#">
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
    
    <cffunction name="updateSecurityImage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siName" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="siSort" type="numeric" required="yes">
    <cfargument name="siStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="getSecurityImage"
    returnvariable="getCheckSecurityImageRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siName" value="#ARGUMENTS.siName#"/>
    <cfinvokeargument name="siStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSecurityImageRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.siName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_security_image SET
    siName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siName#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    siSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siSort#">,
    siStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siStatus#">
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
    
    <cffunction name="updatePasswordHint" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="phQuestion" type="string" required="yes">
    <cfargument name="phSort" type="numeric" required="yes">
    <cfargument name="phStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="getPasswordHint"
    returnvariable="getCheckPasswordHintRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="phQuestion" value="#ARGUMENTS.phQuestion#"/>
    <cfinvokeargument name="phStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPasswordHintRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.phQuestion# already exists, please enter a new question.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_password_hint SET
    phQuestion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.phQuestion#">,
    phSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.phSort#">,
    phStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.phStatus#">
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
    
    <cffunction name="updateSecurityImageList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_security_image SET
    siStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePasswordHintList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="phStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_password_hint SET
    phStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.phStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSecurityImage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_security_image
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deletePasswordHint" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_password_hint
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