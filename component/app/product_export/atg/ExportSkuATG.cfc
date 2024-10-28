<cfcomponent hint="Export component for ATG SKU data export.">
	<cffunction name="getSkuExport" access="public" returntype="void" hint="Process to excute functions to populate sku export/interface table.">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfthread name="skuExport" siteDSN="#application.mcmsDSN#" cID="#ARGUMENTS.cID#">
    <cftry>
	<cfset application.mcmsDSN = siteDSN> 
    <cfset ARGUMENTS.cID = cID>
    <cfset sku = StructNew()>
    <!---Get a list of skus that are export approved.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSkuDepartmentRel"
    returnvariable="getSkuRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pesID" value="103"/>
    <cfinvokeargument name="pStatus" value="1"/>
    <cfinvokeargument name="skuStatus" value="1"/>
    </cfinvoke>
    <cfif getSkuRet.recordcount NEQ 0>   
    <cfloop query="getSkuRet">
    <cfset StructInsert(sku, 'ID', getSkuRet.skuID)>
    <cfset StructInsert(sku, 'sID', getSkuRet.ID)>
    <cfset StructInsert(sku, 'pID', getSkuRet.pID)>
    <cfset StructInsert(sku, 'userID', getSkuRet.userID)>
    <cfset StructInsert(sku, 'displayName', getSkuRet.pName)>
    <cfset StructInsert(sku, 'mpn', getSkuRet.skuMPN)>
    <cfset StructInsert(sku, 'upc', getSkuRet.skuUPC)>
    <cfset StructInsert(sku, 'startDate', DateFormat(getSkuRet.pDateRel, 'm/d/yyyy'))>
    <cfset StructInsert(sku, 'endDate', DateFormat(getSkuRet.pDateExp, 'm/d/yyyy'))>
	<cfset StructInsert(sku, 'brand', getSkuRet.bName)>
    
    <!---Sku Image.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductImage" 
    returnvariable="setProductImageRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(sku, 'largeImage', setProductImageRet & 'lg')>
    <cfset StructInsert(sku, 'smallImage', setProductImageRet & 'sm')>
    <cfset StructInsert(sku, 'thumbnailImage', setProductImageRet & 'tb')>

    <!---Template.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductTemplate" 
    returnvariable="setProductTemplateRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(sku, 'template', setProductTemplateRet)>
    
    <!---List Price.--->
    <cfinvoke 
    component="cfc.price" 
    method="getPrice" 
    returnvariable="setSkuListPriceRet">
    <cfinvokeargument name="pID" value="#pID#">
    <cfinvokeargument name="sID" value="#ID#">
    <cfinvokeargument name="ptID" value="1">
    </cfinvoke>
    <cfset StructInsert(sku, 'listPrice', setSkuListPriceRet.pPrice)>
    
    <!---Sale Price.--->
    <cfinvoke 
    component="cfc.price" 
    method="getPrice" 
    returnvariable="setSkuSalePriceRet">
    <cfinvokeargument name="pID" value="#pID#">
    <cfinvokeargument name="sID" value="#ID#">
    <cfinvokeargument name="priceDateRel" value="#DateFormat(Now(), application.dateFormat)#">
    <cfinvokeargument name="priceDateExp" value="#DateFormat(Now(), application.dateFormat)#">
    <cfinvokeargument name="ptID" value="3">
    </cfinvoke>
    <cfif setSkuSalePriceRet.recordcount EQ 0>
    <cfset StructInsert(sku, 'salePrice', '')>
    <cfset StructInsert(sku, 'salePriceStartDate', '')>
    <cfset StructInsert(sku, 'salePriceEndDate', '')>
    <cfelse>
    <cfset StructInsert(sku, 'salePrice', setSkuSalePriceRet.pPrice)>
    <cfset StructInsert(sku, 'salePriceStartDate', DateFormat(setSkuSalePriceRet.priceDateRel, 'm/d/yyyy'))>
    <cfset StructInsert(sku, 'salePriceEndDate', DateFormat(setSkuSalePriceRet.priceDateExp, 'm/d/yyyy'))>
    </cfif>
    
    <!---HTML cleanup.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="getHTMLRegEx" 
    returnvariable="description">
    <cfinvokeargument name="string" value="#getSkuRet.pMetaDescription#">
    </cfinvoke>
    <cfset StructInsert(sku, 'description', description)>
    
    <!---Non-Returnable.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG" 
    method="setProductNonReturnable" 
    returnvariable="setProductNonReturnableRet">
    <cfinvokeargument name="pID" value="#pID#">
    </cfinvoke>
    <cfset StructInsert(sku, 'nonreturnable', LCASE(setProductNonReturnableRet))>
    
    <!---Build bullet points for features.--->
    <cfsavecontent variable="bulletpoints">
    <cfif ListLen(getSkuRet.pBulletPoint, '|') GTE 1>
    <cfloop index="i" from="1" to="#application.productBulletCount#">
    <cfif ListLen(getSkuRet.pBulletPoint, '|') GTE i>
    <cfoutput>#ListGetAt(getSkuRet.pBulletPoint, i, '|')#</cfoutput>
    </cfif>
    </cfloop>
    </cfif>
    </cfsavecontent>
    
    <cfset StructInsert(sku, 'features', '')>
    
    <!---Quantity On Hand.--->
    <cfif 1 EQ 0>
    <cfinvoke 
    component="cfc.interface" 
    method="getSkuQOH_ERP" 
    returnvariable="setSkuQuantityOnHandRet">
    <cfinvokeargument name="sku" value="#skuID#">
    <cfinvokeargument name="org" value="802">
    </cfinvoke>
    <cfif setSkuQuantityOnHandRet.recordcount EQ 0>
    <cfset StructInsert(sku, 'quantityOnHand', '')>
    <cfelse>
    <cfset StructInsert(sku, 'quantityOnHand', setSkuQuantityOnHandRet.site_qoh)>
    </cfif>
    <cfelse>
    <cfset StructInsert(sku, 'quantityOnHand', '')>
    </cfif>
    
    <!---Insert structure data into export table.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportSkuATG"
    method="insertExportSkuATG"
    >
    <cfinvokeargument name="ID" value="#sku.ID#">
    <cfinvokeargument name="sID" value="#sku.sID#">
    <cfinvokeargument name="pID" value="#sku.pID#">
    <cfinvokeargument name="userID" value="#sku.userID#">
    <cfinvokeargument name="displayName" value="#sku.displayName#">
    <cfinvokeargument name="mpn" value="#sku.mpn#">
    <cfinvokeargument name="upc" value="#sku.upc#">
    <cfinvokeargument name="startDate" value="#sku.startDate#">
    <cfinvokeargument name="endDate" value="#sku.endDate#">
    <cfinvokeargument name="thumbnailImage" value="#sku.thumbnailImage#">
    <cfinvokeargument name="smallImage" value="#sku.smallImage#">
    <cfinvokeargument name="largeImage" value="#sku.largeImage#">
    <cfinvokeargument name="template" value="#sku.template#">
    <cfinvokeargument name="listPrice" value="#sku.listPrice#">
    <cfinvokeargument name="salePrice" value="#sku.salePrice#">
    <cfinvokeargument name="salePriceStartDate" value="#sku.salePriceStartDate#">
    <cfinvokeargument name="salePriceEndDate" value="#sku.salePriceEndDate#">
    <cfinvokeargument name="description" value="#sku.description#">
    <cfinvokeargument name="quantityOnHand" value="#sku.quantityOnHand#">
    <cfinvokeargument name="nonReturnable" value="#sku.nonreturnable#">
    <cfinvokeargument name="brand" value="#sku.brand#">
    <cfinvokeargument name="features" value="#sku.features#">
    </cfinvoke>
    <!---Clear the structure for the next record.--->
    <cfscript>
	StructClear(sku);
    </cfscript>   
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_sku_atg" text="Error: Sku Export! Check pID: #skuID# - #pID# - #productID# - #CFCATCH#" type="error"/>
    </cfcatch>
    </cftry>
    </cfthread>
    </cffunction>
    
    <cffunction name="getExportSkuATG" access="public" returntype="query" hint="Get Export Sku ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportSkuATG = "" >
    <cftry>
    <cfquery name="rsExportSkuATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_sku_atg WHERE 0=0
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
    <cfif ARGUMENTS.sID NEQ 0>
    AND sID IN (<cfqueryparam value="#ARGUMENTS.sID#" list="yes" cfsqltype="cf_sql_integer">)
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
    <cflog file="export_sku_atg" text="Error: getExportSkuATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportSkuATG>
    </cffunction>
    
    <cffunction name="getExportSkuATGExcel" access="public" returntype="any" hint="Get Export Sku ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0,0,0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="skuSort,ID">
    <!---Control the sql pulled for the excel report.--->
    <cfargument name="getSQL" type="string" required="yes" default="false">
    <cfset var rsExportSkuATGExcel = "" >
    <cftry>
    <cfquery name="rsExportSkuATGExcel" datasource="#application.mcmsDSN#">
    SELECT ID, displayName, mpn, upc, startDate, endDate, template, listPrice, salePrice, salePriceStartDate, salePriceEndDate,  purchaserestriction, purchaserestrictioncode, nonreturnable, features, brand, action, alarm, audioFeedback, auxiliaryMedia, backlit, barometricPressure, barrelIn, batteryType, blaze, boomSize, breathable, bundleLinks, caliber, capacity, capacityQt, cartridge, case, centerHeight, chamber, channels, choke, class, coinDetectionDepth, color, compartments, construction, container, convertible, coverMaterial, depth, depthCap, depthIndicator, descriptionAtt, design, diameter, digitalTargetId, displaySize, downloadedMemory, drawEq, drawLength, drawWeight, dropField, dynamicAttributes, endField, expandableMemory, eyeReliefIn, fill, fillWeight, finishField, firearm, fits, flavor, focusSystem, foldedLength, forecast, formField, fov100, fov1000, frequency, gauge, gearRatio, generation, grains, grips, hand, handle, head, height, holeSize, horsepower, indoorHumidity, indoorTemp, insulation, intensityMeter, legDesign, lengthField, lens, lineCap, lineWeight, liner, lop, lureWt, magnification, manualElectric, material, maxHeight, modelField, modelFit, multiCoatedOptics, numStages, objectiveDiameter, outdoorTemp, overrideStorePrice, packQty, packSize, peakContinuous, piece, pixels, poleMaterial, powderModel, powerField, powers, precisionAngleGuides, presetGroundBalance, primerModel, primerUse, prismType, pump, rangeField, rangeGame, rangeHiRelective, receiverSize, receptacles, reelModel, reelWeight, region, replacementProducts AS fixedReplacementProducts, reticle, retrieve, rodModel, rounds, safeForSerrated, scent, screen, searchHead, servings, shaftLength, shape, shellHolderNbr, isShipToStoreOnly, isStoreRestriction, shooting, shotSize, sights, sizeField, sizeHLW, sizeIn, sizeMm, sleeps, sleeves, sole, species, spf, squareFootage, state, stock, styleField, subject, tempRating, thickness, thrust, timeField, toe, tool, torsoLength, tripod, twist, typeField, upland, velocity, viewingRange, waasCompatible, wallHeight, warranty, waterProof, waterProofYN, watts, waypoints, weight, weightCapacity, weightEmpty, weightLbs, wholesalePrice, width, zipper FROM v_export_sku_atg WHERE 0=0
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
    <cfset rsExportSkuATGExcel = 'ID,displayName,mpn,upc,startDate,endDate,template,listPrice,salePrice,salePriceStartDate,salePriceEndDate,purchaseRestriction,purchaseRestrictionCode,nonreturnable,features,brand,action,alarm,audioFeedback,auxiliaryMedia,backlit,barometricPressure,barrelIn,batteryType,blaze,boomSize,breathable,bundleLinks,caliber,capacity,capacityQt,cartridge,case,centerHeight,chamber,channels,choke,class,coinDetectionDepth,color,compartments,construction,container,convertible,coverMaterial,depth,depthCap,depthIndicator,descriptionAtt,design,diameter,digitalTargetId,displaySize,downloadedMemory,drawEq,drawLength,drawWeight,dropField,dynamicAttributes,endField,expandableMemory,eyeReliefIn,fill,fillWeight,finishField,firearm,fits,flavor,focusSystem,foldedLength,forecast,formField,fov100,fov1000,frequency,gauge,gearRatio,generation,grains,grips,hand,handle,head,height,holeSize,horsepower,indoorHumidity,indoorTemp,insulation,intensityMeter,legDesign,lengthField,lens,lineCap,lineWeight,liner,lop,lureWt,magnification,manualElectric,material,maxHeight,modelField,modelFit,multiCoatedOptics,numStages,objectiveDiameter,outdoorTemp,overrideStorePrice,packQty,packSize,peakContinuous,piece,pixels,poleMaterial,powderModel,powerField,powers,precisionAngleGuides,presetGroundBalance,primerModel,primerUse,prismType,pump,rangeField,rangeGame,rangeHiRelective,receiverSize,receptacles,reelModel,reelWeight,region,fixedReplacementProducts,reticle,retrieve,rodModel,rounds,safeForSerrated,scent,screen,searchHead,servings,shaftLength,shape,shellHolderNbr,isShipToStoreOnly,isStoreRestriction,shooting,shotSize,sights,sizeField,sizeHLW,sizeIn,sizeMm,sleeps,sleeves,sole,species,spf,squareFootage,state,stock,styleField,subject,tempRating,thickness,thrust,timeField,toe,tool,torsoLength,tripod,twist,typeField,upland,velocity,viewingRange,waasCompatible,wallHeight,warranty,waterProof,waterProofYN,watts,waypoints,weight,weightCapacity,weightEmpty,weightLbs,wholesalePrice,width,zipper'>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_sku_atg" text="Error: getExportSkuATGExcel" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportSkuATGExcel>
    </cffunction>
    
    <cffunction name="insertExportSkuATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="mpn" type="string" required="yes">
    <cfargument name="upc" type="string" required="yes">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')#">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')#">
    <cfargument name="thumbnailImage" type="string" required="yes" default="">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="largeImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="listPrice" type="string" required="yes">
    <cfargument name="salePrice" type="string" required="yes" default="">
    <cfargument name="salePriceStartDate" type="string" required="yes" default="">
    <cfargument name="salePriceEndDate" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="quantityOnHand" type="string" required="yes" default="">
    <cfargument name="nonreturnable" type="string" required="yes" default="false">
    <cfargument name="brand" type="string" required="yes" default="">
    <cfargument name="features" type="string" required="yes" default="">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Get any attribute values for this product's sku.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductSkuAttributeRel" 
    returnvariable="getProductSkuAttributeRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#">
    <cfinvokeargument name="paStatus" value="1">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfset this.skuAttributeList = ''>
    <cfif getProductSkuAttributeRelRet.recordcount NEQ 0>
    <!---Get any attribute values for this product's sku.--->
    <cfset this.skuAttributeList = ListRemoveDuplicates(ValueList(getProductSkuAttributeRelRet.paNameAlt))>
    <cfloop query="getProductSkuAttributeRelRet">
    <!---Catch purchase restrictions.--->
    <cfif getProductSkuAttributeRelRet.paNameAlt EQ 'purchase_restriction' AND (getProductSkuAttributeRelRet.pavValue EQ 0 OR getProductSkuAttributeRelRet.pavValue EQ 'FALSE' OR getProductSkuAttributeRelRet.psaraltValue EQ 0)>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = ''>
    <cfelseif getProductSkuAttributeRelRet.paNameAlt EQ 'purchase_restriction' AND getProductSkuAttributeRelRet.pavValue EQ 'YES'>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = 'TRUE'>
    <cfelseif getProductSkuAttributeRelRet.paNameAlt EQ 'purchase_restriction' AND getProductSkuAttributeRelRet.pavValue EQ 'NO'>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = 'FALSE'>
    <!---Catch purchase restriction code.--->
    <cfelseif getProductSkuAttributeRelRet.paNameAlt EQ 'purchase_restriction_code' AND (getProductSkuAttributeRelRet.pavValue EQ 0 OR getProductSkuAttributeRelRet.pavValue EQ 'None' OR getProductSkuAttributeRelRet.psaraltValue EQ 0)>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = ''>
    <cfelse>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = Iif(getProductSkuAttributeRelRet.pavValue EQ '' AND getProductSkuAttributeRelRet.psaraltValue NEQ 'x', DE(Replace(getProductSkuAttributeRelRet.psaraltValue, '##', '|||', 'All')), DE(Replace(getProductSkuAttributeRelRet.pavValue, '##', '|||', 'All')))>
    </cfif>
    </cfloop>
    </cfif>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportSkuATG"
    method="getExportSkuATG"
    returnvariable="getCheckExportSkuATGRet">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    </cfinvoke>
    <cfif getCheckExportSkuATGRet.recordcount NEQ 0>
    <!---Update the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportSkuATG"
    method="updateExportSkuATG"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#">
    <cfinvokeargument name="displayName" value="#ARGUMENTS.displayName#">
    <cfinvokeargument name="mpn" value="#ARGUMENTS.mpn#">
    <cfinvokeargument name="upc" value="#ARGUMENTS.upc#">
    <cfinvokeargument name="startDate" value="#ARGUMENTS.startDate#">
    <cfinvokeargument name="endDate" value="#ARGUMENTS.endDate#">
    <cfinvokeargument name="thumbnailImage" value="#ARGUMENTS.thumbnailImage#">
    <cfinvokeargument name="smallImage" value="#ARGUMENTS.smallImage#">
    <cfinvokeargument name="largeImage" value="#ARGUMENTS.largeImage#">
    <cfinvokeargument name="template" value="#ARGUMENTS.template#">
    <cfinvokeargument name="listPrice" value="#ARGUMENTS.listPrice#">
    <cfinvokeargument name="salePrice" value="#ARGUMENTS.salePrice#">
    <cfinvokeargument name="salePriceStartDate" value="#ARGUMENTS.salePriceStartDate#">
    <cfinvokeargument name="salePriceEndDate" value="#ARGUMENTS.salePriceEndDate#">
    <cfinvokeargument name="description" value="#ARGUMENTS.description#">
    <cfinvokeargument name="quantityOnHand" value="#ARGUMENTS.quantityOnHand#">
    <cfinvokeargument name="nonreturnable" value="#ARGUMENTS.nonreturnable#">
    <cfinvokeargument name="brand" value="#ARGUMENTS.brand#">
    <cfinvokeargument name="features" value="#ARGUMENTS.features#">
    <cfinvokeargument name="skuAttributeList" value="#this.skuAttributeList#">
    <cfinvokeargument name="esaStatus" value="1">
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_export_sku_atg (    ID,sID,pID,userID,esaDateUpdated,displayName,mpn,upc,startDate,endDate,thumbnailImage,smallImage,largeImage,template,listPrice,salePrice,salePriceStartDate,salePriceEndDate,description,nonreturnable,brand,features,<cfif this.skuAttributeList NEQ ''>#this.skuAttributeList#,</cfif>esaStatus   
    ) VALUES (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
   	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mpn#" maxlength="32">,
   	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.upc#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.startDate, 'm/d/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.endDate, 'm/d/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.thumbnailImage#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.largeImage#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.listPrice#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.salePrice#" maxlength="16">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.salePriceStartDate NEQ '', DE('#DateFormat(ARGUMENTS.salePriceStartDate, 'm/d/yyyy')#'), DE(''))#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.salePriceEndDate NEQ '', DE('#DateFormat(ARGUMENTS.salePriceEndDate, 'm/d/yyyy')#'), DE(''))#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nonreturnable#" maxlength="8">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.brand#" maxlength="64">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.features#" maxlength="2048">,
    <cfif this.skuAttributeList NEQ ''>
    <cfloop list="#this.skuAttributeList#" index="i">
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Replace(ARGUMENTS[i], '|||', '##')#">,
    </cfloop> 
    </cfif>
    <cfqueryparam cfsqltype="cf_sql_integer" value="1" maxlength="8"> 
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cflog file="export_sku_atg" text="Error: insertExportSkuATG Check sku: #ARGUMENTS.sID# Check pID: #ARGUMENTS.pID#" type="error"/>
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#this.skuAttributeList#"> <cfdump var="#CFCATCH#"> 
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateExportSkuATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="displayName" type="string" required="yes" default="">
    <cfargument name="mpn" type="string" required="yes">
    <cfargument name="upc" type="string" required="yes">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')#">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')#">
    <cfargument name="thumbnailImage" type="string" required="yes" default="">
    <cfargument name="smallImage" type="string" required="yes" default="">
    <cfargument name="largeImage" type="string" required="yes" default="">
    <cfargument name="template" type="string" required="yes" default="">
    <cfargument name="listPrice" type="string" required="yes">
    <cfargument name="salePrice" type="string" required="yes" default="">
    <cfargument name="salePriceStartDate" type="string" required="yes" default="">
    <cfargument name="salePriceEndDate" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="quantityOnHand" type="string" required="yes" default="">
    <cfargument name="nonreturnable" type="string" required="yes" default="false">
    <cfargument name="brand" type="string" required="yes" default="">
    <cfargument name="features" type="string" required="yes" default="">
    <cfargument name="skuAttributeList" type="string" required="yes" default="" hint="List of attributes for this sku.">
    <cfargument name="esaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <!---Get any attribute values for this product's sku.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductSkuAttributeRel" 
    returnvariable="getProductSkuAttributeRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfloop query="getProductSkuAttributeRelRet">
    <!---Catch purchase restrictions.--->
    <cfif getProductSkuAttributeRelRet.paNameAlt EQ 'purchase_restriction' AND (getProductSkuAttributeRelRet.pavValue EQ 0 OR getProductSkuAttributeRelRet.pavValue EQ 'FALSE' OR getProductSkuAttributeRelRet.psaraltValue EQ 0)>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = ''>
    <!---Catch purchase restriction code.--->
    <cfelseif getProductSkuAttributeRelRet.paNameAlt EQ 'purchase_restriction_code' AND (getProductSkuAttributeRelRet.pavValue EQ 0 OR getProductSkuAttributeRelRet.pavValue EQ 'None' OR getProductSkuAttributeRelRet.psaraltValue EQ 0)>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = ''>
    <cfelse>
    <cfset ARGUMENTS[getProductSkuAttributeRelRet.paNameAlt] = Iif(getProductSkuAttributeRelRet.pavValue EQ '' AND getProductSkuAttributeRelRet.psaraltValue NEQ 'x', DE(Replace(getProductSkuAttributeRelRet.psaraltValue, '##', '|||', 'All')), DE(Replace(getProductSkuAttributeRelRet.pavValue, '##', '|||', 'All')))>
    </cfif>
    </cfloop>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_export_sku_atg SET
    sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#" maxlength="8">,
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#" maxlength="8">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    esaDateUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    displayName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.displayName#" maxlength="128">,
    mpn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mpn#" maxlength="32">,
   	upc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.upc#" maxlength="32">,
    startDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.startDate, 'm/d/yyyy')#">,
    endDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.endDate, 'm/d/yyyy')#">,
    thumbnailImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.thumbnailImage#" maxlength="32">,
    smallImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.smallImage#" maxlength="32">,
    largeImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.largeImage#" maxlength="32">,
    template = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.template#" maxlength="32">,
    listPrice = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.listPrice#" maxlength="16">,
	salePrice = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.salePrice#" maxlength="16">,
    salePriceStartDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.salePriceStartDate NEQ '', DE('#DateFormat(ARGUMENTS.salePriceStartDate, 'm/d/yyyy')#'), DE(''))#" maxlength="32">,
    salePriceEndDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.salePriceEndDate NEQ '', DE('#DateFormat(ARGUMENTS.salePriceEndDate, 'm/d/yyyy')#'), DE(''))#" maxlength="32">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#">,
	nonreturnable = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nonreturnable#" maxlength="8">,
    brand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.brand#" maxlength="64">,
    features = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.features#" maxlength="2048">,
    <cfloop list="#ARGUMENTS.skuAttributeList#" index="i">
    #i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Replace(ARGUMENTS[i], '|||', '##')#">,
    </cfloop>
	esaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.esaStatus#" maxlength="8">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cflog file="export_sku_atg" text="Error: updateExportSkuATG. Check sku: #ARGUMENTS.sID# Check pID: #ARGUMENTS.pID#" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSkuExportATG" access="public" returntype="struct">
    <cfargument name="pID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_export_sku_atg
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="truncateSkuExportATG" access="public" returntype="struct">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    TRUNCATE TABLE tbl_export_sku_atg
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>