<cfcomponent hint="Export component for ATG Product data export.">
    <cffunction name="getProductExport" access="public" returntype="void" hint="Process to excute functions to populate product export/interface table.">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfthread name="productExport" siteDSN="#application.mcmsDSN#" cID="#ARGUMENTS.cID#">
    <cftry>
    <cfset product = StructNew()>
	<cfset application.mcmsDSN = siteDSN> 
    <cfset ARGUMENTS.cID = cID>
    <!---Get a list of products that are export approved.--->
    <cfinvoke 
    component="cfc.product"
    method="getProductDepartmentRel"
    returnvariable="getProductExportApprovedRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pesID" value="103"/>
    <cfinvokeargument name="pStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="ID"/>
    </cfinvoke>
    <cfif getProductExportApprovedRet.recordcount NEQ 0>
    <cfset this.pIDList = ValueList(getProductExportApprovedRet.pID)>
    <cfloop list="#this.pIDList#" index="pID">
    <!---Product Description.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProduct" 
    returnvariable="getProductRet">
    <cfinvokeargument name="ID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'ID', getProductRet.productID)>
    <cfset StructInsert(product, 'displayName', getProductRet.pName)>
    <cfset StructInsert(product, 'pageTitle', getProductRet.pPageTitle)>
    <cfset StructInsert(product, 'startDate', DateFormat(getProductRet.pDateRel, 'm/d/yyyy'))>
    <cfset StructInsert(product, 'endDate', DateFormat(getProductRet.pDateExp, 'm/d/yyyy'))>
    <!---HTML cleanup.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="getHTMLRegEx" 
    returnvariable="longDescription">
    <cfinvokeargument name="string" value="#getProductRet.pDescription#">
    </cfinvoke>
    <cfset StructInsert(product, 'longDescription', longDescription)>
    
    <!---HTML cleanup.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="getHTMLRegEx" 
    returnvariable="description">
    <cfinvokeargument name="string" value="#getProductRet.pMetaDescription#">
    </cfinvoke>

	<!---Display a banner if one is related.--->
    <cfinvoke 
    component="cfc.banner"
    method="getBannerProductRel"
    returnvariable="getBannerProductRelRet">
    <cfinvokeargument name="pID" value="#getProductRet.ID#"/>
    <cfinvokeargument name="bprStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getBannerProductRelRet.recordcount EQ 0>
    <cfset StructInsert(product, 'description', description)>
    <cfelse>
    <cfset this.bID = getBannerProductRelRet.bID>
    <cfinvoke
    component="cfc.banner"
    method="getBanner"
    returnvariable="getBannerRet">
    <cfinvokeargument name="ID" value="#this.bID#"/>
    <cfinvokeargument name="bDateRel" value="#Now()#"/>
    <cfinvokeargument name="bDateExp" value="#Now()#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getBannerRet.recordcount NEQ 0>
    <cfset bannerSnippet = '
	<br/>
    <a href="#getBannerRet.bURL#" target="#getBannerRet.bTarget#"><img src="/img/callouts/#Replace(getBannerRet.imgFile, '_tb', '_og')#" alt="#getBannerRet.bName#" width="#getBannerRet.btWidth#" height="#getBannerRet.btHeight#" vspace="5" border="#getBannerRet.bBorder#" name="#getBannerRet.bName#" style="border-color:##000000;" /></a>
	'>
    <cfset StructInsert(product, 'description', '#description##bannerSnippet#')>
    </cfif>
    </cfif>

    <cfset StructInsert(product, 'brand', getProductRet.bName)>
    <!---Build bullet points for features.--->
    <cfsavecontent variable="bulletpoints">
    <cfif ListLen(getProductRet.pBulletPoint, '|') GTE 1>
    <cfloop index="i" from="1" to="#application.productBulletCount#">
    <cfif ListLen(getProductRet.pBulletPoint, '|') GTE i>
    <cfoutput>#ListGetAt(getProductRet.pBulletPoint, i, '|')#</cfoutput>
    </cfif>
    </cfloop>
    </cfif>
    </cfsavecontent>
    
    <cfset StructInsert(product, 'features', bulletpoints)>
    <cfset StructInsert(product, 'productSpecs', '')>
    
    <!---Auxiliary Media.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductAuxiliaryMedia" 
    returnvariable="setProductAuxiliaryMediaRet">
    <cfinvokeargument name="vID" value="#getProductRet.vID#">
    <cfinvokeargument name="bID" value="#getProductRet.bID#">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'auxiliaryMedia', setProductAuxiliaryMediaRet)>
    
    <!---Age Restriction.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductAgeRestriction" 
    returnvariable="setProductAgeRestrictionRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'ageRestriction', setProductAgeRestrictionRet)>
    
    <!---Best Seller.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductBestSeller" 
    returnvariable="setProductBestSellerRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'bestSeller', LCASE(setProductBestSellerRet))>
    
    <!---Disallow As Recommended.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductDisallowAsRecommendation" 
    returnvariable="setProductDisallowAsRecommendationRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'disallowAsRecommendation', LCASE(setProductDisallowAsRecommendationRet))>
    
    <!---Gun Type.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductGunType" 
    returnvariable="setProductGunTypeRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'gunType', setProductGunTypeRet)>
    
    <!---Include First.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductIncludeFirst" 
    returnvariable="setProductIncludeFirstRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'includeFirst', LCASE(setProductIncludeFirstRet))>
    
    <!---Non-Returnable.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductNonReturnable" 
    returnvariable="setProductNonReturnableRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'nonReturnable', LCASE(setProductNonReturnableRet))>
    
    <!---On Sale Alert.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setOnSaleAlert" 
    returnvariable="setOnSaleAlertRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'onSaleAlert', LCASE(setOnSaleAlertRet))>
    
    <!---Fixed Related Products.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductFixedRelatedProducts" 
    returnvariable="setProductFixedRelatedProductsRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'fixedRelatedProducts', setProductFixedRelatedProductsRet)>
    
    <!---Shipping Type.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductShippingType" 
    returnvariable="setProductShippingTypeRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'shippingType', setProductShippingTypeRet)>
    
    <!---Special Handling.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductSpecialHandling" 
    returnvariable="setProductSpecialHandlingRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'specialHandling', setProductSpecialHandlingRet)>
    
    <!---Template.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductTemplate" 
    returnvariable="setProductTemplateRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'template', setProductTemplateRet)>
    
    <!---Video Title.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductVideoTitle" 
    returnvariable="setProductVideoTitleRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'videoTitle', setProductVideoTitleRet)>
    
    <!---Video Title II.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductVideoTitle2" 
    returnvariable="setProductVideoTitle2Ret">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'videoTitle2', setProductVideoTitle2Ret)>
    
    <!---Video Comments.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductVideoComments" 
    returnvariable="setProductVideoCommentsRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'videoComments', setProductVideoCommentsRet)>
    
    <!---Video Comments 2.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductVideoComments2" 
    returnvariable="setProductVideoComments2Ret">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'videoComments2', setProductVideoComments2Ret)>
    
    <!---Video url.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductVideoURL" 
    returnvariable="setProductVideoURLRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'videoURL', setProductVideoURLRet)>
    
    <!---Video URL II.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductVideoURL2" 
    returnvariable="setProductVideoURL2Ret">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'videoURL2', setProductVideoURL2Ret)>
    
    <!---Warning Alerts.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductWarningAlerts" 
    returnvariable="setProductWarningAlertsRet">
    <cfinvokeargument name="pID" value="#pID#">
    <cfinvokeargument name="ageRestriction" value="#product.ageRestriction#">
    </cfinvoke>
    <cfset StructInsert(product, 'warningAlerts', setProductWarningAlertsRet)>
    
    <!---Parent Category.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductParentCategory" 
    returnvariable="setProductParentCategoryRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'parentCategoriesForCatalog', setProductParentCategoryRet)>
    
    
    <!---Product Image.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductImage" 
    returnvariable="setProductImageRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'originalImage', setProductImageRet & 'og')>
    <cfset StructInsert(product, 'largeImage', setProductImageRet & 'lg')>
    <cfset StructInsert(product, 'smallImage', setProductImageRet & 'sm')>
    <cfset StructInsert(product, 'thumbnailImage', setProductImageRet & 'tb')>
    
    <!---Child SKUs.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductChildSkus" 
    returnvariable="setProductChildSkusRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'childSKUs', setProductChildSkusRet)>
    
    <!---Limit Cart Quantity To.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductLimitCartQuantityTo" 
    returnvariable="setProductLimitCartQuantityToRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'limitcartquantityto', setProductLimitCartQuantityToRet)>
    
    <!---Marketing.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductMarketing" 
    returnvariable="setProductMarketingRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'marketing', setProductMarketingRet)>
    
    <!---Is Ship To Store Only.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductIsShipToStoreOnly" 
    returnvariable="setProductIsShipToStoreOnlyRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'isshiptostoreonly', setProductIsShipToStoreOnlyRet)>
    
    <!---Is Store Restriction.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductIsStoreRestriction" 
    returnvariable="setProductIsStoreRestrictionRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(product, 'isstorerestriction', setProductIsStoreRestrictionRet)>
    
    <!---Discontinued Flag.---> 
    <cfset StructInsert(product, 'discontinuedflag', 'false')>
    
    <!---Insert structure data into export table.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG"
    method="insertExportProductATG"
    >
    <cfinvokeargument name="pID" value="#pID#">
    <cfinvokeargument name="ID" value="#product.ID#">
    <cfinvokeargument name="ageRestriction" value="#product.ageRestriction#">
    <cfinvokeargument name="auxiliaryMedia" value="#product.auxiliaryMedia#">
    <cfinvokeargument name="bestSeller" value="#product.bestSeller#">
    <cfinvokeargument name="brand" value="#product.brand#">
    <cfinvokeargument name="parentCategoriesForCatalog" value="#product.parentCategoriesForCatalog#">
    <cfinvokeargument name="description" value="#product.description#">
    <cfinvokeargument name="disallowAsRecommendation" value="#product.disallowAsRecommendation#">
    <cfinvokeargument name="endDate" value="#product.endDate#">
    <cfinvokeargument name="features" value="#product.features#">
    <cfinvokeargument name="gunType" value="#product.gunType#">
    <cfinvokeargument name="includeFirst" value="#product.includeFirst#">
    <cfinvokeargument name="largeImage" value="#product.largeImage#">
    <cfinvokeargument name="longDescription" value="#product.longDescription#">
    <cfinvokeargument name="displayName" value="#product.displayName#">
    <cfinvokeargument name="nonReturnable" value="#product.nonReturnable#">
    <cfinvokeargument name="onSaleAlert" value="#product.onSaleAlert#">
    <cfinvokeargument name="originalImage" value="#product.originalImage#">
    <cfinvokeargument name="pageTitle" value="#product.pageTitle#">
    <cfinvokeargument name="productSpecs" value="#product.productSpecs#">
    <cfinvokeargument name="fixedRelatedProducts" value="#product.fixedRelatedProducts#">
    <cfinvokeargument name="childSkus" value="#product.childSkus#">
    <cfinvokeargument name="shippingType" value="#product.shippingType#">
    <cfinvokeargument name="smallImage" value="#product.smallImage#">
    <cfinvokeargument name="specialHandling" value="#product.specialHandling#">
    <cfinvokeargument name="startDate" value="#product.startDate#">
    <cfinvokeargument name="template" value="#product.template#">
    <cfinvokeargument name="thumbnailImage" value="#product.thumbnailImage#">
    <cfinvokeargument name="videoTitle" value="#product.videoTitle#">
    <cfinvokeargument name="videoTitle2" value="#product.videoTitle2#">
    <cfinvokeargument name="videoComments2" value="#product.videoComments2#">
    <cfinvokeargument name="videoComments" value="#product.videoComments#">
    <cfinvokeargument name="videoURL" value="#product.videoURL#">
    <cfinvokeargument name="videoURL2" value="#product.videoURL2#">
    <cfinvokeargument name="warningAlerts" value="#product.warningAlerts#">
    <cfinvokeargument name="limitCartQuantityTo" value="#product.limitcartquantityto#">
    <cfinvokeargument name="marketing" value="#product.marketing#">
    <cfinvokeargument name="isShipToStoreOnly" value="#product.isshiptostoreonly#">
    <cfinvokeargument name="isStoreRestriction" value="#product.isstorerestriction#">
    <cfinvokeargument name="discontinuedFlag" value="#product.discontinuedflag#">
    </cfinvoke>
    <!---Clear the structure for the next record.--->
    <cfscript>
	StructClear(product);
    </cfscript>   
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Export! Check pID: #pID# - #ID# - #CFCATCH#" type="error"/>
    </cfcatch>
    </cftry>
    </cfthread>
    </cffunction>
    
    <cffunction name="getExportProductATG" access="public" returntype="query" hint="Get Export Product ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportProductATG = "" >
    <cftry>
    <cfquery name="rsExportProductATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_product_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pesID NEQ 0>
    AND pesID IN (<cfqueryparam value="#ARGUMENTS.pesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: getExportProductATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportProductATG>
    </cffunction>
    
    <cffunction name="getExportProductATGExcel" access="public" returntype="any" hint="Get Export Product ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0,0,0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pesID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <!---Control the sql pulled for the excel report.--->
    <cfargument name="getSQL" type="string" required="yes" default="false">
    <cfset var rsExportProductATG = "" >
    <cftry>
    <cfquery name="rsExportProductATG" datasource="#application.mcmsDSN#">
    SELECT ID, ageRestriction, auxiliaryMedia, bestSeller, startDate, endDate, brand, parentCategoriesForCatalog, TO_CHAR(description) AS description, disallowAsRecommendation, features, gunType, LOWER(includeFirst) AS includeFirst,
    largeImage, TO_CHAR(longDescription) AS longDescription, displayName, nonreturnable, onSaleAlert, originalImage, pageTitle, productSpecs, fixedRelatedProducts, childSKUs, shippingType, smallImage,
    specialHandling, template, thumbnailImage, videoTitle, videoComments, videoUrl, videoTitle2, videoComments2, videoUrl2, warningAlerts, limitCartQuantityTo, marketing, isShipToStoreOnly, isStoreRestriction, discontinuedFlag FROM v_export_product_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND pesID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif ARGUMENTS.getSQL EQ 'true'>
    <!---Now return the SQL list of columns in camel case.--->
    <cfset rsExportProductATG = 'ID,ageRestriction,auxiliaryMedia,bestSeller,startDate,endDate,brand,parentCategoriesForCatalog,description,disallowAsRecommendation,features,gunType,includeFirst,largeImage,longDescription,displayName,nonreturnable,onSaleAlert,originalImage,pageTitle,productSpecs,fixedRelatedProducts,childSKUs,shippingType,smallImage,specialHandling,template,thumbnailImage,videoTitle,videoComments,videoUrl,videoTitle2,videoComments2,videoUrl2,warningAlerts,limitCartQuantityTo,marketing,isShipToStoreOnly, isStoreRestriction,discontinuedFlag'>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: getExportProductATGExcel" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportProductATG>
    </cffunction>
    
    <cffunction name="insertExportProductATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="ageRestriction" type="string" required="yes" default="">
    <cfargument name="auxiliaryMedia" type="string" required="yes" default="">
    <cfargument name="bestSeller" type="string" required="yes" default="false">
    <cfargument name="brand" type="string" required="yes" default="">
    <cfargument name="parentCategoriesForCatalog" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="disallowAsRecommendation" type="string" required="yes" default="false">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')#">
    <cfargument name="features" type="string" required="yes" default="">
    <cfargument name="gunType" type="string" required="yes" default="">
    <cfargument name="includeFirst" type="string" required="yes" default="false">
    <cfargument name="largeImage" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="nonReturnable" type="string" required="yes" default="false">
    <cfargument name="onSaleAlert" type="string" required="yes" default="">
    <cfargument name="originalImage" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="productSpecs" type="string" required="yes" default="">
    <cfargument name="fixedRelatedProducts" type="string" required="yes" default="">
    <cfargument name="childSkus" type="string" required="yes" default="">
    <cfargument name="shippingType" type="string" required="yes" default="">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="specialHandling" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')#">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="thumbnailImage" type="string" required="yes" default="">
    <cfargument name="videoTitle" type="string" required="yes" default="">
    <cfargument name="videoComments" type="string" required="yes" default="">
    <cfargument name="videoURL" type="string" required="yes" default="">
    <cfargument name="videoTitle2" type="string" required="yes" default="">
    <cfargument name="videoComments2" type="string" required="yes" default="">
    <cfargument name="videoURL2" type="string" required="yes" default="">
    <cfargument name="warningAlerts" type="string" required="yes" default="">
    <cfargument name="limitCartQuantityTo" type="string" required="yes" default="">
    <cfargument name="marketing" type="string" required="yes" default="">
    <cfargument name="isShipToStoreOnly" type="string" required="yes" default="false">
    <cfargument name="isStoreRestriction" type="string" required="yes" default="false">
    <cfargument name="discontinuedFlag" type="string" required="yes" default="false">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG"
    method="getExportProductATG"
    returnvariable="getCheckExportProductATGRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfif getCheckExportProductATGRet.recordcount NEQ 0>
    <!---Update the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG"
    method="updateExportProductATG"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="ageRestriction" value="#ARGUMENTS.ageRestriction#">
    <cfinvokeargument name="auxiliaryMedia" value="#ARGUMENTS.auxiliaryMedia#">
    <cfinvokeargument name="bestSeller" value="#ARGUMENTS.bestSeller#">
    <cfinvokeargument name="brand" value="#ARGUMENTS.brand#">
    <cfinvokeargument name="parentCategoriesForCatalog" value="#ARGUMENTS.parentCategoriesForCatalog#">
    <cfinvokeargument name="description" value="#ARGUMENTS.description#">
    <cfinvokeargument name="disallowAsRecommendation" value="#ARGUMENTS.disallowAsRecommendation#">
    <cfinvokeargument name="endDate" value="#DateFormat(ARGUMENTS.endDate, 'm/d/yyyy')#">
    <cfinvokeargument name="features" value="#ARGUMENTS.features#">
    <cfinvokeargument name="gunType" value="#ARGUMENTS.gunType#">
    <cfinvokeargument name="includeFirst" value="#ARGUMENTS.includeFirst#">
    <cfinvokeargument name="largeImage" value="#ARGUMENTS.largeImage#">
    <cfinvokeargument name="longDescription" value="#ARGUMENTS.longDescription#">
    <cfinvokeargument name="displayName" value="#ARGUMENTS.displayName#">
    <cfinvokeargument name="nonReturnable" value="#ARGUMENTS.nonReturnable#">
    <cfinvokeargument name="onSaleAlert" value="#ARGUMENTS.onSaleAlert#">
    <cfinvokeargument name="originalImage" value="#ARGUMENTS.originalImage#">
    <cfinvokeargument name="pageTitle" value="#ARGUMENTS.pageTitle#">
    <cfinvokeargument name="productSpecs" value="#ARGUMENTS.productSpecs#">
    <cfinvokeargument name="fixedRelatedProducts" value="#ARGUMENTS.fixedRelatedProducts#">
    <cfinvokeargument name="childSkus" value="#ARGUMENTS.childSkus#">
    <cfinvokeargument name="shippingType" value="#ARGUMENTS.shippingType#">
    <cfinvokeargument name="smallImage" value="#ARGUMENTS.smallImage#">
    <cfinvokeargument name="specialHandling" value="#ARGUMENTS.specialHandling#">
    <cfinvokeargument name="startDate" value="#DateFormat(ARGUMENTS.startDate, 'm/d/yyyy')#">
    <cfinvokeargument name="template" value="#ARGUMENTS.template#">
    <cfinvokeargument name="thumbnailImage" value="#ARGUMENTS.thumbnailImage#">
    <cfinvokeargument name="videoTitle" value="#ARGUMENTS.videoTitle#">
    <cfinvokeargument name="videoComments" value="#ARGUMENTS.videoComments#">
    <cfinvokeargument name="videoURL" value="#ARGUMENTS.videoURL#">
    <cfinvokeargument name="videoTitle2" value="#ARGUMENTS.videoTitle2#">
    <cfinvokeargument name="videoComments2" value="#ARGUMENTS.videoComments2#">
    <cfinvokeargument name="videoURL2" value="#ARGUMENTS.videoURL2#">
    <cfinvokeargument name="warningAlerts" value="#ARGUMENTS.warningAlerts#">
    <cfinvokeargument name="limitCartQuantityTo" value="#ARGUMENTS.limitCartQuantityTo#">
    <cfinvokeargument name="marketing" value="#ARGUMENTS.marketing#">
    <cfinvokeargument name="isShipToStoreOnly" value="#ARGUMENTS.isShipToStoreOnly#">
    <cfinvokeargument name="isStoreRestriction" value="#ARGUMENTS.isStoreRestriction#">
    <cfinvokeargument name="discontinuedFlag" value="#ARGUMENTS.discontinuedFlag#">
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_export_product_atg (ID,pID,userID,epaDateUpdated,ageRestriction,auxiliaryMedia,bestSeller,brand,parentCategoriesForCatalog,description,disallowAsRecommendation,endDate,features,gunType,includeFirst,largeImage,longDescription,displayName,nonReturnable,onSaleAlert,originalImage,pageTitle,productSpecs,fixedRelatedProducts,childSkus,shippingType,smallImage,specialHandling,startDate,template,thumbnailImage,videoTitle,videoComments,videoURL,videoTitle2,videoComments2,videoURL2,warningAlerts,limitcartquantityto,marketing,isshiptostoreonly,isstorerestriction,discontinuedflag,epaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ageRestriction#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.auxiliaryMedia#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bestSeller#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.brand#" maxlength="64">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategoriesForCatalog#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.disallowAsRecommendation#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.endDate, 'm/d/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.features#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gunType#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.includeFirst#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.largeImage#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nonReturnable#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.onSaleAlert#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.originalImage#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pageTitle#" maxlength="128">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.productSpecs#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fixedRelatedProducts#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.childSkus#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.shippingType#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.specialHandling#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.startDate, 'm/d/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.thumbnailImage#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoTitle#" maxlength="64">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoComments#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoURL#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoTitle2#" maxlength="64">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoComments2#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoURL2#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.warningAlerts#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.limitCartQuantityTo#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.marketing#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStoreOnly#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isStoreRestriction#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.discontinuedFlag#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1" maxlength="8"> 
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cflog file="export_product_atg" text="Error: insertExportProductATG. Check pID: #ARGUMENTS.pID# - #ARGUMENTS.ID#" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateExportProductATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="ageRestriction" type="string" required="yes" default="">
    <cfargument name="auxiliaryMedia" type="string" required="yes" default="">
    <cfargument name="bestSeller" type="string" required="yes" default="false">
    <cfargument name="brand" type="string" required="yes" default="">
    <cfargument name="parentCategoriesForCatalog" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="disallowAsRecommendation" type="string" required="yes" default="false">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')#">
    <cfargument name="features" type="string" required="yes" default="">
    <cfargument name="gunType" type="string" required="yes" default="">
    <cfargument name="includeFirst" type="string" required="yes" default="false">
    <cfargument name="largeImage" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="nonReturnable" type="string" required="yes" default="false">
    <cfargument name="onSaleAlert" type="string" required="yes" default="">
    <cfargument name="originalImage" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="productSpecs" type="string" required="yes" default="">
    <cfargument name="fixedRelatedProducts" type="string" required="yes" default="">
    <cfargument name="childSkus" type="string" required="yes" default="">
    <cfargument name="shippingType" type="string" required="yes" default="">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="specialHandling" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')#">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="thumbnailImage" type="string" required="yes" default="">
    <cfargument name="videoTitle" type="string" required="yes" default="">
    <cfargument name="videoComments" type="string" required="yes" default="">
    <cfargument name="videoURL" type="string" required="yes" default="">
    <cfargument name="videoTitle2" type="string" required="yes" default="">
    <cfargument name="videoComments2" type="string" required="yes" default="">
    <cfargument name="videoURL2" type="string" required="yes" default="">
    <cfargument name="warningAlerts" type="string" required="yes" default="">
    <cfargument name="limitCartQuantityTo" type="string" required="yes" default="">
    <cfargument name="marketing" type="string" required="yes" default="">
    <cfargument name="isShipToStoreOnly" type="string" required="yes" default="false">
    <cfargument name="isStoreRestriction" type="string" required="yes" default="false">
    <cfargument name="discontinuedFlag" type="string" required="yes" default="false">
    <cfargument name="epaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_export_product_atg SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#" maxlength="8">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    ageRestriction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ageRestriction#" maxlength="8">,
    epaDateUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    auxiliaryMedia = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.auxiliaryMedia#" maxlength="2048">,
    bestSeller = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bestSeller#" maxlength="8">,
    brand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.brand#" maxlength="64">,
    parentCategoriesForCatalog = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategoriesForCatalog#" maxlength="32">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#">,
    disallowAsRecommendation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.disallowAsRecommendation#" maxlength="8">,
    endDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.endDate, 'm/d/yyyy')#">,
    features = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.features#" maxlength="2048">,
    gunType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gunType#" maxlength="32">,
    includeFirst = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.includeFirst#" maxlength="8">,
    largeImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.largeImage#" maxlength="32">,
    longDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    displayName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    nonReturnable = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nonReturnable#" maxlength="8">,
    onSaleAlert = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.onSaleAlert#" maxlength="2048">,
    originalImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.originalImage#" maxlength="32">,
    pageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pageTitle#" maxlength="128">,
    productSpecs = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.productSpecs#" maxlength="2048">,
    fixedRelatedProducts = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fixedRelatedProducts#" maxlength="2048">,
    childSkus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.childSkus#" maxlength="2048">,
    shippingType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.shippingType#" maxlength="32">,
    smallImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="32">,
    specialHandling = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.specialHandling#" maxlength="32">,
    startDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.startDate, 'm/d/yyyy')#">,
    template = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="32">,
    thumbnailImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.thumbnailImage#" maxlength="32">,
    videoTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoTitle#" maxlength="64">,
    videoComments = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoComments#" maxlength="2048">,
    videoURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoURL#" maxlength="32">,
    videoTitle2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoTitle2#" maxlength="64">,
    videoComments2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoComments2#" maxlength="2048">,
    videoURL2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.videoURL2#" maxlength="32">,
    warningAlerts = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.warningAlerts#" maxlength="2048">,
    limitCartQuantityTo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.limitCartQuantityTo#" maxlength="8">,
    marketing = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.marketing#" maxlength="255">,
    isShipToStoreOnly = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStoreOnly#" maxlength="8">,
    isStoreRestriction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isStoreRestriction#" maxlength="8">,
    discontinuedFlag = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.discontinuedFlag#" maxlength="8">,
    epaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.epaStatus#" maxlength="8">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cflog file="export_product_atg" text="Error: updateExportProductATG. Check pID: #ARGUMENTS.pID#" type="error"/>

    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getHTMLRegEx" access="public" returntype="string" hint="Function to clean up unwanted html.">
    <cfargument name="string" type="string" required="yes">
    <cfset result = ARGUMENTS.string>
    <cftry>
    <cfset result = REReplaceNoCase(ARGUMENTS.string,"<p>|</p>|&nbsp;","","ALL")>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: HTML Regex. for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductAgeRestriction" access="public" returntype="string" hint="Function for age restriction.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="ageRestriction">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    <cfif rs.paerValue NEQ 18>
    <!---If the age restriction is None or NULL revert the value back to NULL for the warning alert.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="warningAlerts">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfinvoke 
    component="cfc.product"
    method="updateProductAttributeExtRel">
    <cfinvokeargument name="ID" value="#rs.ID#"/>
    <cfinvokeargument name="pID" value="#rs.pID#"/>
    <cfinvokeargument name="paeID" value="#rs.paeID#"/>
    <cfinvokeargument name="paerValue" value=""/>
    <cfinvokeargument name="paerStatus" value="1"/>
    <!---DO NOT PERFORM AND PRODUCT STATUS CHANGES.--->
    <cfinvokeargument name="updateProductStatus" value="false"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Age Restriction for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductBestSeller" access="public" returntype="string" hint="Function for best seller.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = 'false'>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="bestSeller">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    <cfif result EQ 0>
    <cfset result = 'false'>
    <cfelseif result EQ 1>
    <cfset result = 'true'>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Best Seller for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductDisallowAsRecommendation" access="public" returntype="string" hint="Function for disallow as recommendation.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = 'false'>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="disallowAsRecommendation">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    <cfif result EQ 0>
    <cfset result = 'false'>
    <cfelseif result EQ 1>
    <cfset result = 'true'>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Disallow As Recommendation for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductGunType" access="public" returntype="string" hint="Function for gun type.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="gunType">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(''), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Gun Type for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductIncludeFirst" access="public" returntype="string" hint="Function for include first.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = 'false'>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="includeFirst">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Include First for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductNonReturnable" access="public" returntype="string" hint="Function for non-returnable.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = 'false'>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="nonReturnable">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Non Returnable for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setOnSaleAlert" access="public" returntype="string" hint="Function for on sale alert.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="onSaleResult">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product On Sale Alert for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductFixedRelatedProducts" access="public" returntype="string" hint="Function for on fixed related products.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="fixedRelatedProducts">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Fixed Related Products for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductAuxiliaryMedia" access="public" returntype="string" hint="Function for auxiliary media.">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <!--- Rules
    1. Vendor logo: i.e. vendorLogo=m309883 (a media ID number generated from seed.)
    2. Non-primary images: i.e.  large2=m60168913, large3=m60168917, orig2=m60168910, orig3=m60168914, thumb2=m60168916, thumb3=m60168920
    --->
    <cfset result = ''>
    <cfset vendor = ''>
    <cfset document = ''>
    <cfset product = ''>
    <cftry>
    <!---Get Vendor Logo.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor" 
    method="getBrandVendorRel" 
    returnvariable="getBrandVendorRelRet">
    <cfinvokeargument name="vID" value="#ARGUMENTS.vID#">
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#">
    <cfinvokeargument name="bvrStatus" value="1">
    </cfinvoke>
    <cfif getBrandVendorRelRet.recordcount NEQ 0>
    <!---Set the media ID.--->
    <cfinvoke 
    component="cfc.image"
    method="setMediaID"
    returnvariable="vendorLogoMediaID">
    <cfinvokeargument name="imgID" value="#getBrandVendorRelRet.imgID#">
    </cfinvoke>
    <cfset vendor = "vendorLogo=" & vendorLogoMediaID>
    </cfif>
    <!---Get Documents.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductDocumentRel" 
    returnvariable="getProductDocumentRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="doctID" value="#application.productDocumentType#"/>
    <cfinvokeargument name="pdrStatus" value="1">
    </cfinvoke>
    <cfif getProductDocumentRelRet.recordcount NEQ 0>
    <!---Set the media ID.--->
    <cfinvoke 
    component="cfc.document"
    method="setDocumentID"
    returnvariable="documentID">
    <cfinvokeargument name="docID" value="#getProductDocumentRelRet.docID#">
    </cfinvoke>
    <cfset document = "additionalSpecifications=" & documentID>
    </cfif>
    <!---Get Auxiliary Media images.--->
    <cfinvoke 
    component="cfc.product"
    method="getProductImageRel"
    returnvariable="getProductImageRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1"/>
    <cfinvokeargument name="pirPrimaryImage" value="0"/>
    <cfinvokeargument name="pirStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="pID,pirSort"/>
    </cfinvoke>
    <cfif getProductImageRelRet.recordcount NEQ 0>
    <cfoutput query="getProductImageRelRet">
    <!---Set the media ID.--->
    <cfinvoke 
    component="cfc.image"
    method="setMediaID"
    returnvariable="productMediaID">
    <cfinvokeargument name="imgID" value="#getProductImageRelRet.imgID#">
    </cfinvoke>
    <cfif product EQ ''>
    <cfset product = "large#CurrentRow+1#=" & productMediaID & "lg," & "orig#CurrentRow+1#=" & productMediaID & "og," & "thumb#CurrentRow+1#=" & productMediaID & "tb">
    <cfelse>
    <cfset product = product & "," & "large#CurrentRow+1#=" & productMediaID & "lg," & "orig#CurrentRow+1#=" & productMediaID & "og," & "thumb#CurrentRow+1#=" & productMediaID & "tb">
    </cfif>
    </cfoutput>
    </cfif>
    <cfif vendor NEQ '' AND document NEQ '' AND product NEQ ''>
    <cfset result = vendor & ',' & document & ',' & product>
    <cfelseif vendor NEQ '' AND product NEQ ''>
    <cfset result = vendor & ',' & product>
    <cfelseif vendor EQ ''>
    <cfset result = product>
    <cfelseif product EQ ''>
    <cfset result = vendor>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Auxiliary Media for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setFixedRelatedProducts" access="public" returntype="string" hint="Function for fixed related products.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="fixedRelatedProducts">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Fixed Related Products for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductShippingType" access="public" returntype="string" hint="Function for shipping type.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="shippingType">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(''), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Shipping Type for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductSpecialHandling" access="public" returntype="string" hint="Function for special handing.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="specialHandling">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Special Handling for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductTemplate" access="public" returntype="string" hint="Function for template.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="getProductAttributeExtRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="template">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif getProductAttributeExtRelRet.recordcount NEQ 0>
    <cfset ptID = Iif(getProductAttributeExtRelRet.paerValue EQ '', DE(getProductAttributeExtRelRet.paeDefaultValue), DE(getProductAttributeExtRelRet.paerValue))>
    <cfinvoke 
    component="cfc.product" 
    method="getProductTemplate" 
    returnvariable="rs">
    <cfinvokeargument name="ID" value="#ptID#">
    <cfinvokeargument name="ptStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = rs.ptCode>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Template for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductVideoComments" access="public" returntype="string" hint="Function for video comments.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoComments">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Video Comments for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductVideoComments2" access="public" returntype="string" hint="Function for video comments 2.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoComments2">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Video Comments 2 for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductVideoTitle" access="public" returntype="string" hint="Function for video title.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoTitle">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Video Title for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductVideoTitle2" access="public" returntype="string" hint="Function for video title 2.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoTitle2">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Video Title 2 for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductVideoURL" access="public" returntype="string" hint="Function for video url.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoURL">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG" 
    method="setVideoID" 
    returnvariable="setVideoIDRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset result = Iif(rs.paerValue EQ '', DE(''), DE(setVideoIDRet))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Video URL for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductVideoURL2" access="public" returntype="string" hint="Function for video URL 2.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoURL2">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG" 
    method="setVideoID2" 
    returnvariable="setVideoID2Ret">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset result = Iif(rs.paerValue EQ '', DE(''), DE(setVideoID2Ret))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Video URL 2 for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductWarningAlerts" access="public" returntype="string" hint="Function for warning alerts.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="ageRestriction" type="string" required="yes" default="">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="warningAlerts">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0 AND ARGUMENTS.ageRestriction NEQ ''>
    <cfset result = Iif(rs.paerValue EQ '', DE(application.defaultWarningAlertExtensionMessage), DE(rs.paerValue))>
    <!---Force the update of the warning alerts message if it is NULL.--->
    <cfif rs.paerValue EQ ''>
    <cfinvoke 
    component="cfc.product"
    method="updateProductAttributeExtRel">
    <cfinvokeargument name="ID" value="#rs.ID#"/>
    <cfinvokeargument name="pID" value="#rs.pID#"/>
    <cfinvokeargument name="paeID" value="#rs.paeID#"/>
    <cfinvokeargument name="paerValue" value="#application.defaultWarningAlertExtensionMessage#"/>
    <cfinvokeargument name="paerStatus" value="1"/>
    <!---DO NOT PERFORM AND PRODUCT STATUS CHANGES.--->
    <cfinvokeargument name="updateProductStatus" value="false"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Warning Alerts for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductLimitCartQuantityTo" access="public" returntype="string" hint="Function for limit cart quantity on item.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="limitcartquantityto" type="string" required="yes" default="">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="limitcartquantityto">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0 AND ARGUMENTS.limitcartquantityto NEQ ''>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Limit Cart Quantity for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductMarketing" access="public" returntype="string" hint="Function for marketing.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="marketing" type="string" required="yes" default="">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="marketing">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Marketing for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductIsShipToStoreOnly" access="public" returntype="string" hint="Function for ship to store only item.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="isshiptostoreonly" type="string" required="yes" default="false">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="isshiptostoreonly">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0 AND ARGUMENTS.isshiptostoreonly NEQ ''>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Is Ship To Store Only for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductIsStoreRestriction" access="public" returntype="string" hint="Function for store restriction item.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="isstorerestriction" type="string" required="yes" default="false">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="isstorerestriction">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0 AND ARGUMENTS.isstorerestriction NEQ ''>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Is Store Restriction for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductDiscontinuedFlag" access="public" returntype="string" hint="Function for discontinued flag item.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="discontinuedflag" type="string" required="yes" default="false">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="discontinuedflag">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0 AND ARGUMENTS.discontinuedflag NEQ ''>
    <cfset result = Iif(rs.paerValue EQ '', DE(rs.paeDefaultValue), DE(rs.paerValue))>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Discontinued Flag for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductParentCategory" access="public" returntype="string" hint="Function for template.">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <!---First select the secondary line category is it exists.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductSecondaryLineCategoryRel" 
    returnvariable="getProductSecondaryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pslcrStatus" value="1">
    </cfinvoke>
    <cfif getProductSecondaryLineCategoryRelRet.recordcount NEQ 0>
    <cfset result = getProductSecondaryLineCategoryRelRet.slcatNo>
    <cfelse>
    <!---First select the line category is it exists.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductLineCategoryRel" 
    returnvariable="getProductLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="plcrStatus" value="1">
    </cfinvoke>
    <cfif getProductLineCategoryRelRet.recordcount NEQ 0>
    <cfset result = getProductLineCategoryRelRet.lcatNo>
    <cfelse>
    <!---First select the secondary category is it exists.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductSecondaryCategoryRel" 
    returnvariable="getProductSecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pscrStatus" value="1">
    </cfinvoke>
    <cfif getProductSecondaryCategoryRelRet.recordcount NEQ 0>
    <cfset result = getProductSecondaryCategoryRelRet.scatNo>
    </cfif>
    </cfif>
    </cfif>
    <cfset result = 'catalog10001=' & result>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Parent Category for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductImage" access="public" returntype="string" hint="Function for main image(s).">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <!---Get image.--->
    <cfinvoke 
    component="cfc.product"
    method="getProductImageRel"
    returnvariable="getProductImageRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1"/>
    <cfinvokeargument name="pirPrimaryImage" value="1"/>
    <cfinvokeargument name="pirStatus" value="1"/>
    </cfinvoke>
    <cfif getProductImageRelRet.recordcount NEQ 0>
    <!---Set the media ID.--->
    <cfinvoke 
    component="cfc.image"
    method="setMediaID"
    returnvariable="productMediaID">
    <cfinvokeargument name="imgID" value="#getProductImageRelRet.imgID#">
    </cfinvoke>
    <cfset result = productMediaID>
    <cfelse>
    <cfset result = ' --No primary image-- '>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Image for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setProductChildSkus" access="public" returntype="string" hint="Function for child skus.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <!---Get Skus.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getSkuRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1"/>
    <cfinvokeargument name="skuStatus" value="1"/>
    </cfinvoke>
    <cfif getSkuRet.recordcount NEQ 0>
    <cfset result = ValueList(getSkuRet.skuID, ', ')>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_product_atg" text="Error: Product Child Skus for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductExportATG" access="public" returntype="struct">
    <cfargument name="pID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_export_product_atg
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="truncateProductExportATG" access="public" returntype="struct">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    TRUNCATE TABLE tbl_export_product_atg
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>