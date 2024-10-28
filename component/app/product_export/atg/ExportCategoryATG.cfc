<cfcomponent hint="Export component for ATG Category data export.">
    <cffunction name="getCategoryExport" access="public" returntype="struct" hint="Process to excute functions to populate category export/interface table.">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfset category = StructNew()>
    <cfset secondary_category = StructNew()>
    <cfset line_category = StructNew()>
    <cfset secondary_line_category = StructNew()>
    <cftry>
    <!---Get all categories that are export ready.--->
    <!---Get Categories.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getCategoryDepartmentRel" 
    returnvariable="getCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="cesID" value="102">
    </cfinvoke>
    <!---Get Secondary Categories.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getSecondaryCategoryDepartmentRel" 
    returnvariable="getSecondaryCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="cesID" value="102">
    </cfinvoke>
    <!---Get Line Categories.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getLineCategoryDepartmentRel" 
    returnvariable="getLineCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="cesID" value="102">
    </cfinvoke>
    <!---Get Secondary Line Categories.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getSecondaryLineCategoryDepartmentRel" 
    returnvariable="getSecondaryLineCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="cesID" value="102">
    </cfinvoke>
    
    <!---Category--->
    <cfloop query="getCategoryDepartmentRelRet">
    <cfset this.catNoList = ''>
    <cfset this.scatNoList = ''>
    <cfset this.lcatNoList = ''>
    <cfset this.slcatNoList = ''>
    <cfset StructInsert(category, 'ID', getCategoryDepartmentRelRet.catNo)>
    <cfset StructInsert(category, 'displayName', getCategoryDepartmentRelRet.catName)>
    <cfset StructInsert(category, 'pageTitle', getCategoryDepartmentRelRet.catPageTitle)>
    <cfset StructInsert(category, 'startDate', DateFormat(getCategoryDepartmentRelRet.catDateRel, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <cfset StructInsert(category, 'endDate', DateFormat(getCategoryDepartmentRelRet.catDateExp, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <!---Media ID.--->
    <cfif getCategoryDepartmentRelRet.imgID EQ 0>
    <cfset StructInsert(category, 'smallImage', '')>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="setCategoryMediaID"
    returnvariable="mediaID">
    <cfinvokeargument name="imgID" value="#getCategoryDepartmentRelRet.imgID#">
    </cfinvoke>
    <cfset StructInsert(category, 'smallImage', mediaID)>
    </cfif>
    <!---If the category uses a landing or category landing template.--->
    <cfif getCategoryDepartmentRelRet.catList EQ 2>
    <cfset StructInsert(category, 'template', 'm5006500')>
    <cfelse>
    <cfset StructInsert(category, 'template', '')>
    </cfif>
    <cfset StructInsert(category, 'description', getCategoryDepartmentRelRet.catDescription)>
    <cfset StructInsert(category, 'longDescription', getCategoryDepartmentRelRet.catLongDescription)>
    <cfset StructInsert(category, 'ancestorCategories', 'rootCategory')>
    
    <!---Set the fixedChildCategories.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getCategorySecondaryCategoryRel" 
    returnvariable="getCategorySecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="catID" value="#getCategoryDepartmentRelRet.catID#">
    </cfinvoke>
    <cfif getCategorySecondaryCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(category, 'fixedChildCategories', '')>
    <cfelse>
    <cfset this.scatNoList = ValueList(getCategorySecondaryCategoryRelRet.scatNo)>
    <cfset StructInsert(category, 'fixedChildCategories', this.scatNoList)>
    </cfif>
    
    <!---Set the fixedChildProducts.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductCategoryRel" 
    returnvariable="getProductCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="catID" value="#getCategoryDepartmentRelRet.catID#">
    </cfinvoke>
    <cfif getProductCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(category, 'fixedChildProducts', '')>
    <cfelse>
    <cfset this.productIDList = ValueList(getProductCategoryRelRet.productID)>
    <cfset StructInsert(category, 'fixedChildProducts', this.productIDList)>
    </cfif>
    
    <cfset StructInsert(category, 'parentCategory', 'rootCategory')>
    
    <cfset StructInsert(category, 'isShipToStore', getCategoryDepartmentRelRet.isShipToStore)>
    
    <cfset StructInsert(category, 'ecaStatus', '1')>
    
    <!---Insert the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="insertExportCategoryATG"
    >
    <cfinvokeargument name="ID" value="#category.id#">
    <cfinvokeargument name="displayName" value="#category.displayName#">
    <cfinvokeargument name="pageTitle" value="#category.pageTitle#">
	<cfinvokeargument name="startDate" value="#category.startDate#">
    <cfinvokeargument name="endDate" value="#category.endDate#">
    <cfinvokeargument name="smallImage" value="#category.smallImage#">
    <cfinvokeargument name="template" value="#category.template#">
    <cfinvokeargument name="description" value="#category.description#">
    <cfinvokeargument name="longDescription" value="#category.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#category.ancestorCategories#">
    <cfinvokeargument name="fixedChildCategories" value="#category.fixedChildCategories#">
    <cfinvokeargument name="fixedChildProducts" value="#category.fixedChildProducts#">
    <cfinvokeargument name="parentCategory" value="#category.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#category.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#category.ecaStatus#">
    </cfinvoke>
    <cfscript>
	StructClear(category);
    </cfscript>
    </cfloop>
    
    <!---Secondary Category--->
    <cfloop query="getSecondaryCategoryDepartmentRelRet">
    <cfset this.catNoList = ''>
    <cfset this.scatNoList = ''>
    <cfset this.lcatNoList = ''>
    <cfset this.slcatNoList = ''>
    <cfset StructInsert(secondary_category, 'ID', getSecondaryCategoryDepartmentRelRet.scatNo)>
    <cfset StructInsert(secondary_category, 'displayName', getSecondaryCategoryDepartmentRelRet.scatName)>
    <cfset StructInsert(secondary_category, 'pageTitle', getSecondaryCategoryDepartmentRelRet.scatPageTitle)>
    <cfset StructInsert(secondary_category, 'startDate', DateFormat(getSecondaryCategoryDepartmentRelRet.scatDateRel, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <cfset StructInsert(secondary_category, 'endDate', DateFormat(getSecondaryCategoryDepartmentRelRet.scatDateExp, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <!---Media ID.--->
    <cfif getSecondaryCategoryDepartmentRelRet.imgID EQ 0>
    <cfset StructInsert(secondary_category, 'smallImage', '')>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="setSecondaryCategoryMediaID"
    returnvariable="mediaID">
    <cfinvokeargument name="imgID" value="#getSecondaryCategoryDepartmentRelRet.imgID#">
    </cfinvoke>
    <cfset StructInsert(secondary_category, 'smallImage', mediaID)>
    </cfif>
    <!---If the category uses a landing or category landing template.--->
    <cfif getSecondaryCategoryDepartmentRelRet.scatList EQ 2>
    <cfset StructInsert(secondary_category, 'template', 'm5006500')>
    <cfelse>
    <cfset StructInsert(secondary_category, 'template', '')>
    </cfif>
    <cfset StructInsert(secondary_category, 'description', getSecondaryCategoryDepartmentRelRet.scatDescription)>
    <cfset StructInsert(secondary_category, 'longDescription', getSecondaryCategoryDepartmentRelRet.scatLongDescription)>
    
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getCategorySecondaryCategoryRel" 
    returnvariable="getCategorySecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="scatID" value="#getSecondaryCategoryDepartmentRelRet.scatID#">
    </cfinvoke>
    <cfif getCategorySecondaryCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(secondary_category, 'ancestorCategories', 'rootCategory')>
    <cfelse>
    <cfset this.catNoList = ValueList(getCategorySecondaryCategoryRelRet.catNo)>
    <cfset StructInsert(secondary_category, 'ancestorCategories', 'rootCategory, #this.catNoList#')>
    </cfif>
    
    <!---Set the fixedChildCategories.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getSecondaryCategoryLineCategoryRel" 
    returnvariable="getSecondaryCategoryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="scatID" value="#getSecondaryCategoryDepartmentRelRet.scatID#">
    </cfinvoke>
    <cfif getSecondaryCategoryLineCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(secondary_category, 'fixedChildCategories', '')>
    <cfelse>
    <cfset this.lcatNoList = ValueList(getSecondaryCategoryLineCategoryRelRet.lcatNo)>
    <cfset StructInsert(secondary_category, 'fixedChildCategories', this.lcatNoList)>
    </cfif>
    
    <!---Set the fixedChildProducts.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductSecondaryCategoryRel" 
    returnvariable="getProductSecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="scatID" value="#getSecondaryCategoryDepartmentRelRet.scatID#">
    </cfinvoke>
    <cfif getProductSecondaryCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(secondary_category, 'fixedChildProducts', '')>
    <cfelse>
    <cfset this.productIDList = ValueList(getProductSecondaryCategoryRelRet.productID)>
    <cfset StructInsert(secondary_category, 'fixedChildProducts', this.productIDList)>
    </cfif>
    
    <!---Get the parent category.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getCategorySecondaryCategoryRel" 
    returnvariable="getCategorySecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="scatID" value="#getSecondaryCategoryDepartmentRelRet.scatID#">
    </cfinvoke>
    <cfif getCategorySecondaryCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(secondary_category, 'parentCategory', 'rootCategory')>
    <cfelse>
    <cfset this.catNoList = ValueList(getCategorySecondaryCategoryRelRet.catNo)>
    <cfset StructInsert(secondary_category, 'parentCategory', 'rootCategory, #this.catNoList#')>
    </cfif>
    
    <cfset StructInsert(secondary_category, 'isShipToStore', getSecondaryCategoryDepartmentRelRet.isShipToStore)>
    <cfset StructInsert(secondary_category, 'ecaStatus', '1')>
    
    <!---Insert the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="insertExportSecondaryCategoryATG"
    >
    <cfinvokeargument name="ID" value="#secondary_category.id#">
    <cfinvokeargument name="displayName" value="#secondary_category.displayName#">
    <cfinvokeargument name="pageTitle" value="#secondary_category.pageTitle#">
	<cfinvokeargument name="startDate" value="#secondary_category.startDate#">
    <cfinvokeargument name="endDate" value="#secondary_category.endDate#">
    <cfinvokeargument name="smallImage" value="#secondary_category.smallImage#">
    <cfinvokeargument name="template" value="#secondary_category.template#">
    <cfinvokeargument name="description" value="#secondary_category.description#">
    <cfinvokeargument name="longDescription" value="#secondary_category.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#secondary_category.ancestorCategories#">
    <cfinvokeargument name="fixedChildCategories" value="#secondary_category.fixedChildCategories#">
    <cfinvokeargument name="fixedChildProducts" value="#secondary_category.fixedChildProducts#">
    <cfinvokeargument name="parentCategory" value="#secondary_category.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#secondary_category.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#secondary_category.ecaStatus#">
    </cfinvoke>
    <cfscript>
	StructClear(secondary_category);
    </cfscript>
    </cfloop>
    
    <!---Line Category--->
    <cfloop query="getLineCategoryDepartmentRelRet">
    <cfset this.catNoList = ''>
    <cfset this.scatNoList = ''>
    <cfset this.lcatNoList = ''>
    <cfset this.slcatNoList = ''>
    <cfset StructInsert(line_category, 'ID', getLineCategoryDepartmentRelRet.lcatNo)>
    <cfset StructInsert(line_category, 'displayName', getLineCategoryDepartmentRelRet.lcatName)>
    <cfset StructInsert(line_category, 'pageTitle', getLineCategoryDepartmentRelRet.lcatPageTitle)>
    <cfset StructInsert(line_category, 'startDate', DateFormat(getLineCategoryDepartmentRelRet.lcatDateRel, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <cfset StructInsert(line_category, 'endDate', DateFormat(getLineCategoryDepartmentRelRet.lcatDateExp, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <!---Media ID.--->
    <cfif getLineCategoryDepartmentRelRet.imgID EQ 0>
    <cfset StructInsert(line_category, 'smallImage', '')>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="setLineCategoryMediaID"
    returnvariable="mediaID">
    <cfinvokeargument name="imgID" value="#getLineCategoryDepartmentRelRet.imgID#">
    </cfinvoke>
    <cfset StructInsert(line_category, 'smallImage', mediaID)>
    </cfif>
    <!---If the category uses a landing or category landing template.--->
    <cfif getLineCategoryDepartmentRelRet.lcatList EQ 2>
    <cfset StructInsert(line_category, 'template', 'm5006500')>
    <cfelse>
    <cfset StructInsert(line_category, 'template', '')>
    </cfif>
    <cfset StructInsert(line_category, 'description', getLineCategoryDepartmentRelRet.lcatDescription)>
    <cfset StructInsert(line_category, 'longDescription', getLineCategoryDepartmentRelRet.lcatLongDescription)>
    
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getSecondaryCategoryLineCategoryRel" 
    returnvariable="getSecondaryCategoryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="lcatID" value="#getLineCategoryDepartmentRelRet.lcatID#">
    </cfinvoke>
    <cfif getSecondaryCategoryLineCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(line_category, 'ancestorCategories', 'rootCategory')>
    <cfelse>
    <cfset this.catNoList = ValueList(getCategorySecondaryCategoryRelRet.catNo)>
    <cfset StructInsert(line_category, 'ancestorCategories', 'rootCategory, #this.catNoList#')>
    </cfif>
    
    <!---Set the fixedChildCategories.--->
    <cfset StructInsert(line_category, 'fixedChildCategories', '')>
    
    <!---Set the fixedChildProducts.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductLineCategoryRel" 
    returnvariable="getProductLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="lcatID" value="#getLineCategoryDepartmentRelRet.lcatID#">
    </cfinvoke>
    <cfif getProductSecondaryCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(line_category, 'fixedChildProducts', '')>
    <cfelse>
    <cfset this.productIDList = ValueList(getProductSecondaryCategoryRelRet.productID)>
    <cfset StructInsert(line_category, 'fixedChildProducts', this.productIDList)>
    </cfif>
    
    <!---Get the parent category.--->
    <!---Traverse down the category tree.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getSecondaryCategoryLineCategoryRel" 
    returnvariable="getSecondaryCategoryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="lcatID" value="#getLineCategoryDepartmentRelRet.lcatID#">
    </cfinvoke>
    <cfif getSecondaryCategoryLineCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(line_category, 'parentCategory', 'rootCategory')>
    <cfelse>
    <!---Now get the parent category.--->
    <cfset this.scatIDList = ValueList(getSecondaryCategoryLineCategoryRelRet.scatID)>
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getCategorySecondaryCategoryRel" 
    returnvariable="getCategorySecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="scatID" value="#this.scatIDList#">
    </cfinvoke>
    <cfif getCategorySecondaryCategoryRelRet.recordcount NEQ 0>
    <cfset this.catNoList = ValueList(getCategorySecondaryCategoryRelRet.catNo)>
    <cfset StructInsert(line_category, 'parentCategory', 'rootCategory, #this.catNoList#')>
    <cfelse>
    <cfset StructInsert(line_category, 'parentCategory', 'rootCategory')>
    </cfif>
    </cfif>
    
    <cfset StructInsert(line_category, 'isShipToStore', getLineCategoryDepartmentRelRet.isShipToStore)>
    <cfset StructInsert(line_category, 'ecaStatus', '1')>
    
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="insertExportLineCategoryATG"
    >
    <cfinvokeargument name="ID" value="#line_category.id#">
    <cfinvokeargument name="displayName" value="#line_category.displayName#">
    <cfinvokeargument name="pageTitle" value="#line_category.pageTitle#">
	<cfinvokeargument name="startDate" value="#line_category.startDate#">
    <cfinvokeargument name="endDate" value="#line_category.endDate#">
    <cfinvokeargument name="smallImage" value="#line_category.smallImage#">
    <cfinvokeargument name="template" value="#line_category.template#">
    <cfinvokeargument name="description" value="#line_category.description#">
    <cfinvokeargument name="longDescription" value="#line_category.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#line_category.ancestorCategories#">
    <cfinvokeargument name="fixedChildCategories" value="#line_category.fixedChildCategories#">
    <cfinvokeargument name="fixedChildProducts" value="#line_category.fixedChildProducts#">
    <cfinvokeargument name="parentCategory" value="#line_category.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#line_category.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#line_category.ecaStatus#">
    </cfinvoke>
    <cfscript>
	StructClear(line_category);
    </cfscript>
    </cfloop>
    
    <!---Secondary Line Category--->
    <cfloop query="getSecondaryLineCategoryDepartmentRelRet">
    <cfset this.catNoList = ''>
    <cfset this.scatNoList = ''>
    <cfset this.lcatNoList = ''>
    <cfset this.slcatNoList = ''>
    <cfset StructInsert(secondary_line_category, 'ID', getSecondaryLineCategoryDepartmentRelRet.slcatNo)>
    <cfset StructInsert(secondary_line_category, 'displayName', getSecondaryLineCategoryDepartmentRelRet.slcatName)>
    <cfset StructInsert(secondary_line_category, 'pageTitle', getSecondaryLineCategoryDepartmentRelRet.slcatPageTitle)>
    <cfset StructInsert(secondary_line_category, 'startDate', DateFormat(getSecondaryLineCategoryDepartmentRelRet.slcatDateRel, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <cfset StructInsert(secondary_line_category, 'endDate', DateFormat(getSecondaryLineCategoryDepartmentRelRet.slcatDateExp, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <!---Media ID.--->
    <cfif getSecondaryLineCategoryDepartmentRelRet.imgID EQ 0>
    <cfset StructInsert(secondary_line_category, 'smallImage', '')>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="setSecondaryLineCategoryMediaID"
    returnvariable="mediaID">
    <cfinvokeargument name="imgID" value="#getSecondaryLineCategoryDepartmentRelRet.imgID#">
    </cfinvoke>
    <cfset StructInsert(secondary_line_category, 'smallImage', mediaID)>
    </cfif>
    <!---If the category uses a landing or category landing template.--->
    <cfif getSecondaryLineCategoryDepartmentRelRet.slcatList EQ 2>
    <cfset StructInsert(secondary_line_category, 'template', 'm5006500')>
    <cfelse>
    <cfset StructInsert(secondary_line_category, 'template', '')>
    </cfif>
    <cfset StructInsert(secondary_line_category, 'description', getSecondaryLineCategoryDepartmentRelRet.slcatDescription)>
    <cfset StructInsert(secondary_line_category, 'longDescription', getSecondaryLineCategoryDepartmentRelRet.slcatLongDescription)>
    
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getLineCategorySecondaryLineCategoryRel" 
    returnvariable="getLineCategorySecondaryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="slcatID" value="#getSecondaryLineCategoryDepartmentRelRet.slcatID#">
    </cfinvoke>
    <cfif getLineCategorySecondaryLineCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(secondary_line_category, 'ancestorCategories', 'rootCategory')>
    <cfelse>
    <cfset this.catNoList = ValueList(getCategorySecondaryCategoryRelRet.catNo)>
    <cfset StructInsert(secondary_line_category, 'ancestorCategories', 'rootCategory, #this.catNoList#')>
    </cfif>
    
    <!---Set the fixedChildCategories.--->
    <cfset StructInsert(secondary_line_category, 'fixedChildCategories', '')>
    
    <!---Set the fixedChildProducts.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductSecondaryLineCategoryRel" 
    returnvariable="getProductSecondaryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="slcatID" value="#getSecondaryLineCategoryDepartmentRelRet.slcatID#">
    </cfinvoke>
    <cfif getProductSecondaryLineCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(secondary_line_category, 'fixedChildProducts', '')>
    <cfelse>
    <cfset this.productIDList = ValueList(getProductSecondaryLineCategoryRelRet.productID)>
    <cfset StructInsert(secondary_line_category, 'fixedChildProducts', this.productIDList)>
    </cfif>
    
    <!---Get the parent category.--->
    <!---Traverse down the category tree.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getLineCategorySecondaryLineCategoryRel" 
    returnvariable="getLineCategorySecondaryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="slcatID" value="#getSecondaryLineCategoryDepartmentRelRet.slcatID#">
    </cfinvoke>
    <cfif getLineCategorySecondaryLineCategoryRelRet.recordcount EQ 0>
    <cfset StructInsert(secondary_line_category, 'parentCategory', 'rootCategory')>
    <cfelse>
    <!---Now get the parent category.--->
    <cfset this.lcatIDList = ValueList(getLineCategorySecondaryLineCategoryRelRet.lcatID)>
    <cfinvoke 
    component="MCMS.component.app.category.Category" 
    method="getSecondaryCategoryLineCategoryRel" 
    returnvariable="getSecondaryCategoryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#">
    <cfinvokeargument name="lcatID" value="#this.lcatIDList#">
    </cfinvoke>
    <cfif getSecondaryCategoryLineCategoryRelRet.recordcount NEQ 0>
    <cfset this.scatNoList = ValueList(getSecondaryCategoryLineCategoryRelRet.scatNo)>
    <cfset StructInsert(secondary_line_category, 'parentCategory', 'rootCategory, #this.scatNoList#')>
    </cfif>
    </cfif>
    
    <cfset StructInsert(secondary_line_category, 'isShipToStore', getSecondaryLineCategoryDepartmentRelRet.isShipToStore)>
    <cfset StructInsert(secondary_line_category, 'ecaStatus', '1')>
    
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="insertExportSecondaryLineCategoryATG"
    >
    <cfinvokeargument name="ID" value="#secondary_line_category.id#">
    <cfinvokeargument name="displayName" value="#secondary_line_category.displayName#">
    <cfinvokeargument name="pageTitle" value="#secondary_line_category.pageTitle#">
	<cfinvokeargument name="startDate" value="#secondary_line_category.startDate#">
    <cfinvokeargument name="endDate" value="#secondary_line_category.endDate#">
    <cfinvokeargument name="smallImage" value="#secondary_line_category.smallImage#">
    <cfinvokeargument name="template" value="#secondary_line_category.template#">
    <cfinvokeargument name="description" value="#secondary_line_category.description#">
    <cfinvokeargument name="longDescription" value="#secondary_line_category.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#secondary_line_category.ancestorCategories#">
    <cfinvokeargument name="fixedChildCategories" value="#secondary_line_category.fixedChildCategories#">
    <cfinvokeargument name="fixedChildProducts" value="#secondary_line_category.fixedChildProducts#">
    <cfinvokeargument name="parentCategory" value="#secondary_line_category.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#secondary_line_category.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#secondary_line_category.ecaStatus#">
    </cfinvoke>
    <cfscript>
	StructClear(secondary_line_category);
    </cfscript>
    </cfloop>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_category_atg" text="Error: Category Export!" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn category>
    </cffunction>
    
    <cffunction name="getExportCategoryATG" access="public" returntype="query" hint="Get Export Category ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportCategoryATG = "" >
    <cftry>
    <cfquery name="rsExportCategoryATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_category_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif> 
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_category_atg" text="Error: getExportCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportCategoryATG>
    </cffunction>
    
    <cffunction name="getExportCategoryATGGroupByID" access="public" returntype="query" hint="Get Export Category ATG data grouped by ID.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="displayName, ID">
    <cfargument name="groupBy" type="string" required="yes" default="ID, displayName, startDate, endDate, cesName, cesID">
    <cfset var rsExportCategoryATGGroupByID = "" >
    <cftry>
    <cfquery name="rsExportCategoryATGGroupByID" datasource="#application.mcmsDSN#">
    SELECT ID, displayName, startDate, endDate, cesName, cesID FROM v_export_category_atg
    WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	UNION SELECT ID, displayName, startDate, endDate, cesName, cesID FROM v_export_sec_category_atg
    WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	UNION SELECT ID, displayName, startDate, endDate, cesName, cesID FROM v_export_line_category_atg 
    WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    GROUP BY #ARGUMENTS.groupBy# 
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_category_atg" text="Error: getExportCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportCategoryATGGroupByID>
    </cffunction>
    
    <cffunction name="getExportSecondaryCategoryATG" access="public" returntype="query" hint="Get Export Secondary Category ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportSecondaryCategoryATG = "" >
    <cftry>
    <cfquery name="rsExportSecondaryCategoryATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_sec_category_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_secondary_category_atg" text="Error: getExportSecondaryCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportSecondaryCategoryATG>
    </cffunction>
    
    <cffunction name="getExportLineCategoryATG" access="public" returntype="query" hint="Get Export Line Category ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportLineCategoryATG = "" >
    <cftry>
    <cfquery name="rsExportLineCategoryATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_line_category_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_line_category_atg" text="Error: getExportLineCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportLineCategoryATG>
    </cffunction>
    
    <cffunction name="getExportSecondaryLineCategoryATG" access="public" returntype="query" hint="Get Export Secondary Line Category ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportSecondaryLineCategoryATG = "" >
    <cftry>
    <cfquery name="rsExportSecondaryLineCategoryATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_sec_line_cat_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif> 
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_secondary_line_category_atg" text="Error: getExportSecondaryLineCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportSecondaryLineCategoryATG>
    </cffunction>
    
    <cffunction name="getExportCategoryATGExcel" access="public" returntype="any" hint="Get Export Category ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0,0,0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="displayName, ID">
    <cfargument name="groupBy" type="string" required="yes" default="ID, displayName, pageTitle, smallImage, startDate, endDate, template, description, longDescription, ancestorCategories, fixedChildCategories, fixedChildProducts, parentCategory, isShipToStore">
    <!---Control the sql pulled for the excel report.--->
    <cfargument name="getSQL" type="string" required="yes" default="false">
    <cfset var rsExportCategoryATGExcel = "" >
    <cftry>
    <cfquery name="rsExportCategoryATGExcel" datasource="#application.mcmsDSN#">
    SELECT ID, displayName, pageTitle, smallImage, startDate, endDate, template, TO_CHAR(description) AS description, TO_CHAR(longDescription) AS longDescription, ancestorCategories, fixedChildCategories, fixedChildProducts, parentCategory, isShipToStore FROM v_export_category_atg
    WHERE 0=0
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND cesID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" cfsqltype="cf_sql_integer">
    </cfif>
UNION SELECT ID, displayName, pageTitle, smallImage, startDate, endDate, template, TO_CHAR(description) AS description, TO_CHAR(longDescription) AS longDescription, ancestorCategories, fixedChildCategories, fixedChildProducts, parentCategory, isShipToStore FROM v_export_sec_category_atg
 WHERE 0=0
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND cesID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" cfsqltype="cf_sql_integer">
    </cfif>
UNION SELECT ID, displayName, pageTitle, smallImage, startDate, endDate, template, TO_CHAR(description) AS description, TO_CHAR(longDescription) AS longDescription, ancestorCategories, fixedChildCategories, fixedChildProducts, parentCategory, isShipToStore FROM v_export_line_category_atg
 WHERE 0=0
	<cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(displayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND cesID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" cfsqltype="cf_sql_integer">
    </cfif>
    GROUP BY #ARGUMENTS.groupBy#
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif ARGUMENTS.getSQL EQ 'true'>
    <!---Now return the SQL list of columns in camel case.--->
    <cfset rsExportMediaATG = 'ID,displayName,pageTitle,smallImage,startDate,endDate,template,description,longDescription,ancestorCategories,fixedChildCategories,fixedChildProducts,parentCategory,isShipToStore'>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_category_atg" text="Error: getExportCategoryATGExcel" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportCategoryATGExcel>
    </cffunction>
    
    <cffunction name="setCategoryMediaID" access="public" returntype="string" hint="Set Category Media ID.">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfset var categoryID = "">
    <cftry>
    <!---Get the next media ID.--->
    <cfset categoryID = 'm' & application.categoryIDSeedPrefix & (application.categoryIDSeedNumber + ARGUMENTS.imgID)>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset categoryID = StructNew()>
    <cfset categoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn categoryID>
    </cffunction>
    
    <cffunction name="setSecondaryCategoryMediaID" access="public" returntype="string" hint="Set Secondary Category Media ID.">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfset var scategoryID = "">
    <cftry>
    <!---Get the next media ID.--->
    <cfset scategoryID = 'm' & application.secondaryCategoryIDSeedPrefix & (application.secondaryCategoryIDSeedNumber + ARGUMENTS.imgID)>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset scategoryID = StructNew()>
    <cfset scategoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn scategoryID>
    </cffunction>
    
    <cffunction name="setLineCategoryMediaID" access="public" returntype="string" hint="Set Line Category Media ID.">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfset var lcategoryID = "">
    <cftry>
    <!---Get the next media ID.--->
    <cfset lcategoryID = 'm' & application.lineCategoryIDSeedPrefix & (application.lineCategoryIDSeedNumber + ARGUMENTS.imgID)>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset lcategoryID = StructNew()>
    <cfset lcategoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn lcategoryID>
    </cffunction>
    
    <cffunction name="setSecondaryLineCategoryMediaID" access="public" returntype="string" hint="Set Secondary Line Category Media ID.">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfset var slcategoryID = "">
    <cftry>
    <!---Get the next media ID.--->
    <cfset lcategoryID = 'm' & application.secondaryLineCategoryIDSeedPrefix & (application.secondaryLineCategoryIDSeedNumber + ARGUMENTS.imgID)>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset slcategoryID = StructNew()>
    <cfset slcategoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn slcategoryID>
    </cffunction>
    
    <cffunction name="insertExportCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="getExportCategoryATG"
    returnvariable="getCheckExportCategoryATGRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfif getCheckExportCategoryATGRet.recordcount NEQ 0>
    <!---Update the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="updateExportCategoryATG"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="displayName" value="#ARGUMENTS.displayName#">
    <cfinvokeargument name="pageTitle" value="#ARGUMENTS.pageTitle#">
	<cfinvokeargument name="startDate" value="#ARGUMENTS.startDate#">
    <cfinvokeargument name="endDate" value="#ARGUMENTS.endDate#">
    <cfinvokeargument name="smallImage" value="#ARGUMENTS.smallImage#">
    <cfinvokeargument name="template" value="#ARGUMENTS.template#">
    <cfinvokeargument name="description" value="#ARGUMENTS.description#">
    <cfinvokeargument name="longDescription" value="#ARGUMENTS.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#">
    <cfinvokeargument name="fixedChildCategories" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#">
    <cfinvokeargument name="fixedChildProducts" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#">
    <cfinvokeargument name="parentCategory" value="#ARGUMENTS.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#ARGUMENTS.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#ARGUMENTS.ecaStatus#">
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_export_category_atg (ID,userID,ecaDateUpdated,displayName,pageTitle,startDate,endDate,smallImage,template,description,longDescription,ancestorCategories,fixedChildCategories,fixedChildProducts,parentCategory,isShipToStore,ecaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cflog file="export_category_atg" text="Error: insertExportCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertExportSecondaryCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="getExportSecondaryCategoryATG"
    returnvariable="getCheckExportSecondaryCategoryATGRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfif getCheckExportSecondaryCategoryATGRet.recordcount NEQ 0>
    <!---Update the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="updateExportSecondaryCategoryATG"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="displayName" value="#ARGUMENTS.displayName#">
    <cfinvokeargument name="pageTitle" value="#ARGUMENTS.pageTitle#">
	<cfinvokeargument name="startDate" value="#ARGUMENTS.startDate#">
    <cfinvokeargument name="endDate" value="#ARGUMENTS.endDate#">
    <cfinvokeargument name="smallImage" value="#ARGUMENTS.smallImage#">
    <cfinvokeargument name="template" value="#ARGUMENTS.template#">
    <cfinvokeargument name="description" value="#ARGUMENTS.description#">
    <cfinvokeargument name="longDescription" value="#ARGUMENTS.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#">
    <cfinvokeargument name="fixedChildCategories" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#">
    <cfinvokeargument name="fixedChildProducts" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#">
    <cfinvokeargument name="parentCategory" value="#ARGUMENTS.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#ARGUMENTS.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#ARGUMENTS.ecaStatus#">
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_export_category_atg (ID,userID,ecaDateUpdated,displayName,pageTitle,startDate,endDate,smallImage,template,description,longDescription,ancestorCategories,fixedChildCategories,fixedChildProducts,parentCategory,isShipToStore,ecaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cflog file="export_secondary_category_atg" text="Error: insertExportSecondaryCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertExportLineCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="getExportLineCategoryATG"
    returnvariable="getCheckExportLineCategoryATGRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfif getCheckExportLineCategoryATGRet.recordcount NEQ 0>
    <!---Update the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="updateExportLineCategoryATG"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="displayName" value="#ARGUMENTS.displayName#">
    <cfinvokeargument name="pageTitle" value="#ARGUMENTS.pageTitle#">
	<cfinvokeargument name="startDate" value="#ARGUMENTS.startDate#">
    <cfinvokeargument name="endDate" value="#ARGUMENTS.endDate#">
    <cfinvokeargument name="smallImage" value="#ARGUMENTS.smallImage#">
    <cfinvokeargument name="template" value="#ARGUMENTS.template#">
    <cfinvokeargument name="description" value="#ARGUMENTS.description#">
    <cfinvokeargument name="longDescription" value="#ARGUMENTS.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#">
    <cfinvokeargument name="fixedChildCategories" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#">
    <cfinvokeargument name="fixedChildProducts" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#">
    <cfinvokeargument name="parentCategory" value="#ARGUMENTS.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#ARGUMENTS.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#ARGUMENTS.ecaStatus#">
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_export_category_atg (ID,userID,ecaDateUpdated,displayName,pageTitle,startDate,endDate,smallImage,template,description,longDescription,ancestorCategories,fixedChildCategories,fixedChildProducts,parentCategory,isShipToStore,ecaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cflog file="export_line_category_atg" text="Error: insertExportLineCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertExportSecondaryLineCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="getExportSecondaryLineCategoryATG"
    returnvariable="getCheckExportSecondaryLineCategoryATGRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfif getCheckExportSecondaryLineCategoryATGRet.recordcount NEQ 0>
    <!---Update the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportCategoryATG"
    method="updateExportSecondaryLineCategoryATG"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="displayName" value="#ARGUMENTS.displayName#">
    <cfinvokeargument name="pageTitle" value="#ARGUMENTS.pageTitle#">
	<cfinvokeargument name="startDate" value="#ARGUMENTS.startDate#">
    <cfinvokeargument name="endDate" value="#ARGUMENTS.endDate#">
    <cfinvokeargument name="smallImage" value="#ARGUMENTS.smallImage#">
    <cfinvokeargument name="template" value="#ARGUMENTS.template#">
    <cfinvokeargument name="description" value="#ARGUMENTS.description#">
    <cfinvokeargument name="longDescription" value="#ARGUMENTS.longDescription#">
    <cfinvokeargument name="ancestorCategories" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#">
    <cfinvokeargument name="fixedChildCategories" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#">
    <cfinvokeargument name="fixedChildProducts" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#">
    <cfinvokeargument name="parentCategory" value="#ARGUMENTS.parentCategory#">
    <cfinvokeargument name="isShipToStore" value="#ARGUMENTS.isShipToStore#">
    <cfinvokeargument name="ecaStatus" value="#ARGUMENTS.ecaStatus#">
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_export_category_atg (ID,userID,ecaDateUpdated,displayName,pageTitle,startDate,endDate,smallImage,template,description,longDescription,ancestorCategories,fixedChildCategories,fixedChildProducts,parentCategory,isShipToStore,ecaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cflog file="export_line_category_atg" text="Error: insertExportSecondaryLineCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateExportCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_export_category_atg SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    ecaDateUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    displayName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    pageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	startDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    endDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    smallImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    template = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    longDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    ancestorCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    fixedChildCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    fixedChildProducts = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    parentCategory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    ecaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cflog file="export_category_atg" text="Error: updateExportCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateExportSecondaryCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_export_category_atg SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    ecaDateUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    displayName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    pageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	startDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    endDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    smallImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    template = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    longDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    ancestorCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    fixedChildCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    fixedChildProducts = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    parentCategory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    ecaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cflog file="export_secondary_category_atg" text="Error: updateExportSecondaryCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="updateExportLineCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_export_category_atg SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    ecaDateUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    displayName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    pageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	startDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    endDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    smallImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    template = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    longDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    ancestorCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    fixedChildCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    fixedChildProducts = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    parentCategory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    ecaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cflog file="export_line_category_atg" text="Error: updateExportLineCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateExportSecondaryLineCategoryATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="pageTitle" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:012:00 AM AM">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="longDescription" type="string" required="yes" default="">
    <cfargument name="ancestorCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildCategories" type="string" required="yes" default="">
    <cfargument name="fixedChildProducts" type="string" required="yes" default="">
    <cfargument name="parentCategory" type="string" required="yes" default="">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="ecaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_export_category_atg SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    ecaDateUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    displayName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    pageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.pageTitle NEQ '', DE(ARGUMENTS.pageTitle), DE(ARGUMENTS.displayName))#" maxlength="128">,
	startDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.startDate#">,
    endDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.endDate#">,
    smallImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="16">,
    template = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="16">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
    longDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.longDescription#">,
    ancestorCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.ancestorCategories, 2048)#" maxlength="2048">,
    fixedChildCategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildCategories, 2048)#" maxlength="2048">,
    fixedChildProducts = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(ARGUMENTS.fixedChildProducts, 4000)#" maxlength="4000">,
    parentCategory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentCategory#" maxlength="255">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#" maxlength="8">,
    ecaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ecaStatus#" maxlength="8"> 
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cflog file="export_line_category_atg" text="Error: updateExportSecondaryLineCategoryATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="truncateCategoryExportATG" access="public" returntype="struct">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    TRUNCATE TABLE tbl_export_category_atg
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
</cfcomponent>