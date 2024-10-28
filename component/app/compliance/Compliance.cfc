<cfcomponent>   
    <cffunction name="getComplianceSkuManager" access="public" returntype="query" hint="Get compliance/regular results for the Sku Manager.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="paeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="numeric" required="yes" default="0">
    <cfset var result = "" >
    <cfset this.pIDList = 0>
    <cftry>
	<!---Begin filtering results by various methods.--->
    <cfif ARGUMENTS.deptNo NEQ 0 OR ARGUMENTS.bID NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getDistinctSkuDepartmentRel"
    returnvariable="getDistinctSkuDepartmentRelRet">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getDistinctSkuDepartmentRelRet.recordcount NEQ 0>
    <cfset this.pIDList = ValueList(getDistinctSkuDepartmentRelRet.pID)>
    </cfif>
    </cfif>
    <cfif ARGUMENTS.paeID NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getDistinctProductAttributeExtRel"
    returnvariable="getDistinctProductAttributeExtRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paeID" value="#ARGUMENTS.paeID#"/>
    <cfinvokeargument name="paerValue" value="18"/>
    <cfinvokeargument name="paerStatus" value="1,3"/>
    </cfinvoke>
    <cfif getDistinctProductAttributeExtRelRet.recordcount NEQ 0>
    <cfset this.pIDList = this.pIDList & ',' & ValueList(getDistinctProductAttributeExtRelRet.pID)>
    </cfif>
	<!---Check for sku attribute values to determine if the sku has been completed or is not the value requiring compliance. This prevents returning results that may not be important to the compliance team.--->
    <cfquery name="rsCheckSkuForComplianceRet" datasource="#application.mcmsDSN#">
    SELECT pID FROM v_product_sku_attribute_rel WHERE 0=0
    AND (pavValue IS NULL OR pavValue = '0')
    AND paID IN (<cfqueryparam value="#application.complianceAuthorizationAttributeList#" list="yes" cfsqltype="cf_sql_integer">)
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY pID
    </cfquery>
    <cfif rsCheckSkuForComplianceRet.recordcount NEQ 0>
    <cfset this.pIDList = ValueList(rsCheckSkuForComplianceRet.pID)>
    <cfelse>
    <cfset this.pIDList = this.pIDList>
    </cfif>
    </cfif>
    <!---Now use the various filtered methods.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="result">
    <cfinvokeargument name="keywords" value="#form.keywords#"/>
    <cfif this.pIDList NEQ ''>
    <cfinvokeargument name="pID" value="#LEFT(ListRemoveDuplicates(this.pIDList),1000)#">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    </cfif>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    <cfinvokeargument name="orderBy" value="pID"/>
    </cfinvoke>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = StructNew()>
    <cfset result.message = "There was an error with the Compliance Sku Manager query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateComplianceSkuManagerList" access="public" returntype="struct">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="purchaseRestrictionID" type="numeric" required="yes">
    <cfargument name="purchaseRestrictionValue" type="string" required="yes">
    <cfargument name="purchaseRestrictionCodeID" type="numeric" required="yes">
    <cfargument name="purchaseRestrictionCodeValue" type="string" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSkuAttributeRel">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="paID" value="211,212"/>
    </cfinvoke>
    <cfset this.paIDList = '#ARGUMENTS.purchaseRestrictionID#,#ARGUMENTS.purchaseRestrictionCodeID#'>
    <cfset this.pavIDList = '#ARGUMENTS.purchaseRestrictionValue#,#ARGUMENTS.purchaseRestrictionCodeValue#'>
    <!---Match the value up to an existing product attribute value.--->
    <cfinvoke 
    component="MCMS.component.app.product_attribute.ProductAttribute"
    method="setProductAttributeValue"
    returnvariable="pavIDListResult">
    <cfinvokeargument name="paIDList" value="#TRIM(this.paIDList)#"/>
    <cfinvokeargument name="pavIDList" value="#TRIM(this.pavIDList)#"/>
    <cfinvokeargument name="psaraltValueList" value="x,x"/>
    <cfinvokeargument name="pavStatus" value="1,2,3"/>
    <cfinvokeargument name="formType" value="byPassComplianceCheck"/>
    </cfinvoke>
    <cfloop index="i" from="1" to="#ListLen(this.paIDList)#">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSkuAttributeRel"
    returnvariable="result">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="#TRIM(ListGetAt(this.paIDList, i))#"/>
    <cfinvokeargument name="pavID" value="#TRIM(ListGetAt(pavIDListResult, i))#"/>
    <cfinvokeargument name="psaraltValue" value=""/>
    <cfinvokeargument name="psarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now check if all skus have been compliance updated to warrant an email to be sent to the product user.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getSkuRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSkuAttributeRel"
    returnvariable="getProductSkuAttributeRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="212"/>
    <cfinvokeargument name="excludepavValue" value="0"/>
    </cfinvoke>
	
    <cfif getSkuRet.recordcount EQ getProductSkuAttributeRelRet.recordcount>
    <cfset result.message = result.message & " " & "Email notification(s) have been sent to any product where the compliance updates are complete.">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Compliance Completed - #getSkuRet.pName# (#getSkuRet.productID#)"/>
    <cfinvokeargument name="to" value="#getSkuRet.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value="#session.userUsername#"/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#getSkuRet.pID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/sku_manager/view/inc_sku_compliance_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>