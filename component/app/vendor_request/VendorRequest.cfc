<cfcomponent>
    <cffunction name="getVendorRequest" access="public" returntype="query" hint="Get Vendor Request data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vrName" type="string" required="yes" default="">
    <cfargument name="userStatus" type="string" required="no" default="1">
    <cfargument name="vrtStatus" type="string" required="no" default="1">
    <cfargument name="vrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vrName">
    <cfset var rsVendorRequest = "" >
    <cftry>
    <cfquery name="rsVendorRequest" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vendor_request WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.vrName NEQ "">
    AND UPPER(vrName) = <cfqueryparam value="#UCASE(ARGUMENTS.vrName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND vrtStatus IN (<cfqueryparam value="#ARGUMENTS.vrtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND vrStatus IN (<cfqueryparam value="#ARGUMENTS.vrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorRequest = StructNew()>
    <cfset rsVendorRequest.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorRequest>
    </cffunction>
    
    <cffunction name="getVendorRequestType" access="public" returntype="query" hint="Get Vendor Request Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vrtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vrtSort">
    <cfset var rsVendorRequestType = "" >
    <cftry>
    <cfquery name="rsVendorRequestType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_vr_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vrtStatus IN (<cfqueryparam value="#ARGUMENTS.vrtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorRequestType = StructNew()>
    <cfset rsVendorRequestType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorRequestType>
    </cffunction>
    
    <cffunction name="getVendorRequestStatus" access="public" returntype="query" hint="Get Vendor Request Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vrsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vrsName">
    <cfset var rsVendorRequestStatus = "" >
    <cftry>
    <cfquery name="rsVendorRequestStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_vr_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vrsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vrsStatus IN (<cfqueryparam value="#ARGUMENTS.vrsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorRequestStatus = StructNew()>
    <cfset rsVendorRequestStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorRequestStatus>
    </cffunction>
    
    <cffunction name="getVendorRequestErpOrg" access="public" returntype="query" hint="Get Vendor Request ERP Org data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="erpoStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="erpoName">
    <cfset var rsVendorRequestErpOrg = "" >
    <cftry>
    <cfquery name="rsVendorRequestErpOrg" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_erp_org WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(erpoName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND erpoStatus IN (<cfqueryparam value="#ARGUMENTS.erpoStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorRequestErpOrg = StructNew()>
    <cfset rsVendorRequestErpOrg.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorRequestErpOrg>
    </cffunction>
    
    <cffunction name="getVendorRequestReport" access="public" returntype="query" hint="Get Vendor Request Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="vrName">
    <cfset var rsVendorRequestReport = "" >
    <cftry>
    <cfquery name="rsVendorRequestReport" datasource="#application.mcmsDSN#">
    SELECT vrName AS Name, siteName AS Site, vrtName AS Type, vrRetailID AS Emp_Tomax_ID, vrerpID AS Oracle_ID, erpoName As Erp_Org, userfName || ' ' || userlName AS Requestee, sname AS Status FROM v_vendor_request WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(vrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorRequestReport = StructNew()>
    <cfset rsVendorRequestReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorRequestReport>
    </cffunction>
    
    <cffunction name="insertVendorRequest" access="public" returntype="struct">
    <cfargument name="vrName" type="string" required="yes">
    <cfargument name="vrAddress" type="string" required="yes">
    <cfargument name="vrAddressExt" type="string" required="yes">
    <cfargument name="vrCity" type="string" required="yes">
    <cfargument name="vrStateProv" type="string" required="yes">
    <cfargument name="vrZipCode" type="string" required="yes">
    <cfargument name="vrZipCodeExt" type="string" required="yes">
    <cfargument name="vrCountry" type="string" required="yes">
    <cfargument name="vrTelephone" type="string" required="yes">
    <cfargument name="vrFax" type="string" required="yes">
    <cfargument name="vrReason" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="vrRetailID" type="string" required="yes">
    <cfargument name="vrerpID" type="string" required="yes">
    <cfargument name="vrPayment" type="numeric" required="yes">
    <cfargument name="vrtID" type="numeric" required="yes">
    <cfargument name="erpoID" type="numeric" required="yes">
    <cfargument name="vrPayGroup" type="string" required="yes">
    <cfargument name="vrTerms" type="string" required="yes">
    <cfargument name="vrFreightTerms" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="vrsID" type="numeric" required="yes">
    <cfargument name="vrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.vrName)#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vendor_request (vrName,vrAddress,vrAddressExt,vrCity,vrStateProv,vrZipCode,vrZipCodeExt,vrCountry,vrTelephone,vrFax,vrReason,siteNo,vrRetailID,vrerpID,vrPayment,vrtID,erpoID,vrPayGroup,vrTerms,vrFreightTerms,userID,vrsID,vrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrAddress)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrAddressExt)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrCity)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrstateProv)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrZipCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrZipCodeExt)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrCountry)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrTelephone)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrFax)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrReason)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrRetailID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrerpID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrPayment)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrtID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.erpoID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrPayGroup)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrTerms)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrFreightTerms)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vrsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vrStatus#">
    )
    </cfquery>
    
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.vendor_request.VendorRequest"
    method="getVendorRequestType"
    returnvariable="getVendorRequestTypeRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.vrtID#"/>
    <cfinvokeargument name="vrtStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.vendor_request.VendorRequest"
    method="getVendorRequestStatus"
    returnvariable="getVendorRequestStatusRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.vrsID#"/>
    <cfinvokeargument name="vrsStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.vendor_request.VendorRequest"
    method="getVendorRequestErpOrg"
    returnvariable="getVendorRequestErpOrgRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.erpoID#"/>
    <cfinvokeargument name="erpoStatus" value="1"/>
    </cfinvoke>
    <cfset colWidth = 150>
    <cfset this.messageBody = '
	<cfoutput>
	<h2>"#getVendorRequestTypeRet.vrtName# Vendor Request for #ARGUMENTS.vrName#" Confirmation</h2>
	<table id="mainTableAlt">
	<tr>
    <td><strong>#LSDateFormat(Now())#</strong></td>
    </tr>
	<tr>
	<td>You have successfully submitted a #getVendorRequestTypeRet.vrtName# Vendor Request for #ARGUMENTS.vrName# at Site No. #ARGUMENTS.siteNo#. Thank you.</td>
	</tr>
	<tr>
	<td colspan="2"><h1>Vendor/Employee Information</h1></td>
	</tr>
	<tr>
	<td>
	<table id="mainTableAlt">
	<tr>
	<td class="bold" style="width:#colWidth#">Type:</td>
	<td>#Iif(getVendorRequestTypeRet.vrtName NEQ "", DE(getVendorRequestTypeRet.vrtName), DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Site No:</td>
	<td>#Iif(ARGUMENTS.siteNo NEQ "",DE(ARGUMENTS.siteNo),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Emp/#application.erpSystemVendor# ID:</td>
	<td>#Iif(ARGUMENTS.vrerpID NEQ "",DE(ARGUMENTS.vrerpID),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">#application.retailSystemVendor#:</td>
	<td>#Iif(ARGUMENTS.vrRetailID NEQ "",DE(ARGUMENTS.vrRetailID),DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Name/Company:</td>
	<td>#Iif(ARGUMENTS.vrName NEQ "",DE(ARGUMENTS.vrName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Address:</td>
	<td>#Iif(ARGUMENTS.vrAddress NEQ "",DE(ARGUMENTS.vrAddress),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Address Ext.:</td>
	<td>#Iif(ARGUMENTS.vrAddressExt NEQ "",DE(ARGUMENTS.vrAddressExt),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">City:</td>
	<td>#Iif(ARGUMENTS.vrCity NEQ "",DE(ARGUMENTS.vrCity),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">State:</td>
	<td>#Iif(ARGUMENTS.vrStateProv NEQ "",DE(ARGUMENTS.vrStateProv),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Zip Code:</td>
	<td>#Iif(ARGUMENTS.vrZipCode NEQ "",DE(ARGUMENTS.vrZipCode),DE('N/A'))# #Iif(ARGUMENTS.vrZipCodeExt NEQ "", DE('-'), DE(''))# #ARGUMENTS.vrZipCodeExt#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Country:</td>
	<td>#Iif(ARGUMENTS.vrCountry NEQ "",DE(ARGUMENTS.vrCountry),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Telephone:</td>
	<td>#Iif(ARGUMENTS.vrTelephone NEQ "",DE(ARGUMENTS.vrTelephone),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Fax:</td>
	<td>#Iif(ARGUMENTS.vrFax NEQ "",DE(ARGUMENTS.vrFax),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Request Reason:</td>
	<td>#Iif(ARGUMENTS.vrReason NEQ "",DE(ARGUMENTS.vrReason),DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Status:</td>
	<td>#Iif(getVendorRequestStatusRet.vrsName NEQ "",DE(getVendorRequestStatusRet.vrsName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Erp Org:</td>
	<td>#Iif(getVendorRequestErpOrgRet.erpoName NEQ "",DE(getVendorRequestErpOrgRet.erpoName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">One Time Payment: </td>
	<td>#Iif(ARGUMENTS.vrPayment EQ 1, DE('Yes'), DE('No'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Pay Group: </td>
	<td>#Iif(ARGUMENTS.vrPayGroup NEQ "",DE(ARGUMENTS.vrPayGroup),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Payment Terms: </td>
	<td>#Iif(ARGUMENTS.vrTerms NEQ "",DE(ARGUMENTS.vrTerms),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Freight Terms: </td>
	<td>#Iif(ARGUMENTS.vrFreightTerms NEQ "",DE(ARGUMENTS.vrFreightTerms),DE('N/A'))#</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
	</cfoutput>
	'>  
    <!--- Send a confirmation email to the user that submitted the request --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Merchandise Vendor Request Confirmation"/>
    <cfinvokeargument name="to" value="#getUserRet.userEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.messageBody#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
	<cfset this.messageBody = '
	<cfoutput>
	<h2>"#getVendorRequestTypeRet.vrtName# Vendor Request for #ARGUMENTS.vrName#" Submission Report</h2>
	<table id="mainTableAlt">
	<tr>
    <td><strong>#LSDateFormat(Now())#</strong></td>
    </tr>
	<tr>
	<td>A "<span class="required"><cfoutput>#getVendorRequestTypeRet.vrtName# Vendor Request for #ARGUMENTS.vrName#</span>" has been submitted by <a href="mailto:#getUserRet.userEmail#">#getUserRet.userfName# #getUserRet.userlName#</a> at Telephone Number #getUserRet.userTelephone# and requires your attention.</td>
	</tr>
	<tr>
	<td colspan="2"><h1>Vendor/Employee Information</h1></td>
	</tr>
	<tr>
	<td>
	<table id="mainTableAlt">
	<tr>
	<td class="bold" style="width:#colWidth#">Type:</td>
	<td>#Iif(getVendorRequestTypeRet.vrtName NEQ "", DE(getVendorRequestTypeRet.vrtName), DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Site No:</td>
	<td>#Iif(ARGUMENTS.siteNo NEQ "",DE(ARGUMENTS.siteNo),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Emp/#application.erpSystemVendor# ID:</td>
	<td>#Iif(ARGUMENTS.vrerpID NEQ "",DE(ARGUMENTS.vrerpID),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">#application.retailSystemVendor#:</td>
	<td>#Iif(ARGUMENTS.vrRetailID NEQ "",DE(ARGUMENTS.vrRetailID),DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Name/Company:</td>
	<td>#Iif(ARGUMENTS.vrName NEQ "",DE(ARGUMENTS.vrName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Address:</td>
	<td>#Iif(ARGUMENTS.vrAddress NEQ "",DE(ARGUMENTS.vrAddress),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Address Ext.:</td>
	<td>#Iif(ARGUMENTS.vrAddressExt NEQ "",DE(ARGUMENTS.vrAddressExt),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">City:</td>
	<td>#Iif(ARGUMENTS.vrCity NEQ "",DE(ARGUMENTS.vrCity),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">State:</td>
	<td>#Iif(ARGUMENTS.vrStateProv NEQ "",DE(ARGUMENTS.vrStateProv),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Zip Code:</td>
	<td>#Iif(ARGUMENTS.vrZipCode NEQ "",DE(ARGUMENTS.vrZipCode),DE('N/A'))# #Iif(ARGUMENTS.vrZipCodeExt NEQ "", DE('-'), DE(''))# #ARGUMENTS.vrZipCodeExt#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Country:</td>
	<td>#Iif(ARGUMENTS.vrCountry NEQ "",DE(ARGUMENTS.vrCountry),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Telephone:</td>
	<td>#Iif(ARGUMENTS.vrTelephone NEQ "",DE(ARGUMENTS.vrTelephone),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Fax:</td>
	<td>#Iif(ARGUMENTS.vrFax NEQ "",DE(ARGUMENTS.vrFax),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Request Reason:</td>
	<td>#Iif(ARGUMENTS.vrReason NEQ "",DE(ARGUMENTS.vrReason),DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Status:</td>
	<td>#Iif(getVendorRequestStatusRet.vrsName NEQ "",DE(getVendorRequestStatusRet.vrsName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Erp Org:</td>
	<td>#Iif(getVendorRequestErpOrgRet.erpoName NEQ "",DE(getVendorRequestErpOrgRet.erpoName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">One Time Payment: </td>
	<td>#Iif(ARGUMENTS.vrPayment EQ 1, DE('Yes'), DE('No'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Pay Group: </td>
	<td>#Iif(ARGUMENTS.vrPayGroup NEQ "",DE(ARGUMENTS.vrPayGroup),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Payment Terms: </td>
	<td>#Iif(ARGUMENTS.vrTerms NEQ "",DE(ARGUMENTS.vrTerms),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Freight Terms: </td>
	<td>#Iif(ARGUMENTS.vrFreightTerms NEQ "",DE(ARGUMENTS.vrFreightTerms),DE('N/A'))#</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
	</cfoutput>
	'>
    <!--- Send an email to those in the vendorRequestEmail list --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Merchandise Vendor Request for #form.vrName#"/>
    <cfinvokeargument name="to" value="#application.vendorRequestEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.messageBody#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateVendorRequest" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vrName" type="string" required="yes">
    <cfargument name="vrAddress" type="string" required="yes">
    <cfargument name="vrAddressExt" type="string" required="yes">
    <cfargument name="vrCity" type="string" required="yes">
    <cfargument name="vrStateProv" type="string" required="yes">
    <cfargument name="vrZipCode" type="string" required="yes">
    <cfargument name="vrZipCodeExt" type="string" required="yes">
    <cfargument name="vrCountry" type="string" required="yes">
    <cfargument name="vrTelephone" type="string" required="yes">
    <cfargument name="vrFax" type="string" required="yes">
    <cfargument name="vrReason" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="vrRetailID" type="string" required="yes">
    <cfargument name="vrerpID" type="string" required="yes">
    <cfargument name="vrPayment" type="numeric" required="yes">
    <cfargument name="vrtID" type="numeric" required="yes">
    <cfargument name="erpoID" type="numeric" required="yes">
    <cfargument name="vrPayGroup" type="string" required="yes">
    <cfargument name="vrTerms" type="string" required="yes">
    <cfargument name="vrFreightTerms" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="vrsID" type="numeric" required="yes">
    <cfargument name="vrStatus" type="numeric" required="yes">
    <cfif ARGUMENTS.vrsID EQ 4>
    <cfset result.message = "You have successfully updated the record and an email has been sent to the requestee.">
    <cfelse>
    <cfset result.message = "You have successfully updated the record.">
    </cfif>
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.vrName)#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vendor_request SET
    vrName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrName)#">,
    vrAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrAddress)#">,
    vrAddressExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrAddressExt)#">,
    vrCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrCity)#">,
    vrStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrStateProv)#">,
    vrZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrZipCode)#">,
    vrZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrZipCodeExt)#">,
    vrCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrCountry)#">,
    vrTelephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrTelephone)#">,
    vrFax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrFax)#">,
    vrReason = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrReason)#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siteNo#">,
    vrRetailID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrRetailID)#">,
    vrerpid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrerpid)#">,
    vrPayment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrPayment)#">,
    vrtID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrtID)#">,
    erpoID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.erpoID)#">,
    vrPayGroup = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrPayGroup)#">,
    vrTerms = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrTerms)#">,
    vrFreightTerms = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrFreightTerms)#">,
    userID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.userID)#">,
    vrsID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vrsID)#">,
    vrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.vrsID EQ 4>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.vendor_request.VendorRequest"
    method="getVendorRequestType"
    returnvariable="getVendorRequestTypeRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.vrtID#"/>
    <cfinvokeargument name="vrtStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.vendor_request.VendorRequest"
    method="getVendorRequestStatus"
    returnvariable="getVendorRequestStatusRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.vrsID#"/>
    <cfinvokeargument name="vrsStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.vendor_request.VendorRequest"
    method="getVendorRequestErpOrg"
    returnvariable="getVendorRequestErpOrgRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.erpoID#"/>
    <cfinvokeargument name="erpoStatus" value="1"/>
    </cfinvoke>
    <cfset colWidth = 150>
    <cfset this.messageBody = '
	<cfoutput>
	<h2>"#getVendorRequestTypeRet.vrtName# Vendor Request for #ARGUMENTS.vrName#" Complete</h2>
	<table id="mainTableAlt">
	<tr>
    <td><strong>#LSDateFormat(Now())#</strong></td>
    </tr>
	<tr>
	<td colspan="2"><h1>Vendor/Employee Information</h1></td>
	</tr>
	<tr>
	<td>
	<table id="mainTableAlt">
	<tr>
	<td class="bold" style="width:#colWidth#">Type:</td>
	<td>#Iif(getVendorRequestTypeRet.vrtName NEQ "", DE(getVendorRequestTypeRet.vrtName), DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Site No:</td>
	<td>#Iif(ARGUMENTS.siteNo NEQ "",DE(ARGUMENTS.siteNo),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Emp/#application.erpSystemVendor# ID:</td>
	<td>#Iif(ARGUMENTS.vrerpID NEQ "",DE(ARGUMENTS.vrerpID),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">#application.retailSystemVendor#:</td>
	<td>#Iif(ARGUMENTS.vrRetailID NEQ "",DE(ARGUMENTS.vrRetailID),DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Name/Company:</td>
	<td>#Iif(ARGUMENTS.vrName NEQ "",DE(ARGUMENTS.vrName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Address:</td>
	<td>#Iif(ARGUMENTS.vrAddress NEQ "",DE(ARGUMENTS.vrAddress),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Address Ext.:</td>
	<td>#Iif(ARGUMENTS.vrAddressExt NEQ "",DE(ARGUMENTS.vrAddressExt),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">City:</td>
	<td>#Iif(ARGUMENTS.vrCity NEQ "",DE(ARGUMENTS.vrCity),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">State:</td>
	<td>#Iif(ARGUMENTS.vrStateProv NEQ "",DE(ARGUMENTS.vrStateProv),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Zip Code:</td>
	<td>#Iif(ARGUMENTS.vrZipCode NEQ "",DE(ARGUMENTS.vrZipCode),DE('N/A'))# #Iif(ARGUMENTS.vrZipCodeExt NEQ "", DE('-'), DE(''))# #ARGUMENTS.vrZipCodeExt#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Country:</td>
	<td>#Iif(ARGUMENTS.vrCountry NEQ "",DE(ARGUMENTS.vrCountry),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Telephone:</td>
	<td>#Iif(ARGUMENTS.vrTelephone NEQ "",DE(ARGUMENTS.vrTelephone),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Fax:</td>
	<td>#Iif(ARGUMENTS.vrFax NEQ "",DE(ARGUMENTS.vrFax),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Comments:</td>
	<td>#Iif(ARGUMENTS.vrReason NEQ "",DE(ARGUMENTS.vrReason),DE('N/A'))#</td>
	</tr>
    <tr>
	<td class="bold" style="width:#colWidth#">Status:</td>
	<td>#Iif(getVendorRequestStatusRet.vrsName NEQ "",DE(getVendorRequestStatusRet.vrsName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Erp Org:</td>
	<td>#Iif(getVendorRequestErpOrgRet.erpoName NEQ "",DE(getVendorRequestErpOrgRet.erpoName),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">One Time Payment: </td>
	<td>#Iif(ARGUMENTS.vrPayment EQ 1, DE('Yes'), DE('No'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Pay Group: </td>
	<td>#Iif(ARGUMENTS.vrPayGroup NEQ "",DE(ARGUMENTS.vrPayGroup),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Payment Terms: </td>
	<td>#Iif(ARGUMENTS.vrTerms NEQ "",DE(ARGUMENTS.vrTerms),DE('N/A'))#</td>
	</tr>
	<tr>
	<td class="bold" style="width:#colWidth#">Freight Terms: </td>
	<td>#Iif(ARGUMENTS.vrFreightTerms NEQ "",DE(ARGUMENTS.vrFreightTerms),DE('N/A'))#</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
	</cfoutput>
	'>
    <!--- Send an email to those in the vendorRequestEmail list --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Merchandise Vendor Request for #form.vrName#"/>
    <cfinvokeargument name="to" value="#getUserRet.userEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.messageBody#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateVendorRequestList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vendor_request SET
    vrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVendorRequest" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vendor_request
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