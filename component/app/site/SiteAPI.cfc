component {
	
	//Create the objects.
	restObj = CreateObject('component', 'MCMS.component.utility.Rest');
	regexObj = CreateObject('component', 'MCMS.component.utility.Regex');
	
// [START createSite()]
	public struct function createSite(
		required numeric siteNo=0,
		required string siteName='',
		required numeric imgID=0,
		required string siteDateSet='',
		required string siteDateOpen='',
		required string siteDateGrand='',
		required string siteDateClose='',
		required numeric stID=0,
		required numeric siteSort=0,
		required numeric siteStatus=0		
	) {
	
	try {
	
	this.c= StructNew();
	this.createAction = 'true';
	
	//START: Rules and data integrity check(s).
	
	//Check for any profanity in certain values.
	regexCheck = regexObj.regexProfanity(profanityString=siteName);
	
	//If you find profanity ask the user to correct it.
	if(regexCheck CONTAINS '$%&*!') {
		
		this.createAction = 'false';
		this.c.message = 'The Site Name contained profanity, please remove any profanity from your text.';
		
	}
	
	//END: Rules and data integrity check(s).
	
	//If the createAction is 'true' proceed calling the restful service. 
	if(this.createAction == 'true') {

	//Use a ':' for the separator.
	parameterString='siteNo=#arguments.siteNo#:siteName=#arguments.siteName#:imgID=#arguments.imgID#:siteDateSet=#arguments.siteDateSet#:siteDateOpen=#arguments.siteDateOpen#:siteDateGrand=#arguments.siteDateGrand#:siteDateClose=#arguments.siteDateClose#:stID=#arguments.stID#:siteSort=#arguments.siteSort#:siteStatus=#arguments.siteStatus#';

	//Call the restful service method.
	this.c = restObj.getRestfulService(
		url=application.mcmsAPIURL,
		path=application.siteAPIPath & '/create/createSite',
		parameter=parameterString,
		method="post",
		format=application.siteAPIFormat	
	);
	
	}
	
	return this.c;
	
	} catch (any e) { WriteOutput("<p>createSite() Error: #e.message#</p>"); }
		
	}
	
// [END createSite()]

// [START getSite()]
	public any function getSite(
		required string ID=0,
		required string keywords='All',
		required string siteNo='100',
		required string excludeSiteNo='100',
		required string siteName='',
		required string siteDateSet='',
		required string siteDateOpen='',
		required string siteDateOpenGT='',
		required string siteDateClose='',
		required string stID='0',
		required string siteStatus='1,3',
		string orderBy='siteSort, siteName ASC'		
	) {
	
	//try {
	
	this.q='';

	//Use a ':' for the separator.
	parameterString='ID=#arguments.ID#:keywords=#arguments.keywords#:siteNo=#arguments.siteNo#:excludeSiteNo=#arguments.excludeSiteNo#:siteName=#arguments.siteName#:siteDateSet=#arguments.siteDateSet#:siteDateOpen=#arguments.siteDateOpen#:siteDateOpenGT=#arguments.siteDateOpenGT#:siteDateClose=#arguments.siteDateClose#:stID=#arguments.stID#:siteStatus=#arguments.siteStatus#:orderBy=#arguments.orderBy#';
	
	//Call the restful service method.
	this.q = restObj.getRestfulService(
		url=application.mcmsAPIURL,
		path=application.siteAPIPath & '/read/getSite',
		parameter=parameterString,
		method="get",
		format=application.siteAPIFormat	
	);

	return this.q;
	
	//} catch (any e) { WriteOutput("<p>getSite() Error: #e.message#</p>"); }
		
	}
	
// [END getSite()]

// [START getSiteAddress()]
	public any function getSiteAddress(
		required string ID=0,
		required string keywords='All',
		required string siteNo='100',
		required string excludeSiteNo='100',
		required string siteName='',
		required string siteDateOpen='',
		required string siteDateClose='',
		required string stID='0',
		required string satID='0',
		required string siteStatus='1,3',
		required string saStatus='1,3',
		string orderBy='siteNo ASC'		
	) {
	
	//try {
	
	this.q2='';

	//Use a ':' for the separator.
	parameterString='ID=#arguments.ID#:keywords=#arguments.keywords#:siteNo=#arguments.siteNo#:excludeSiteNo=#arguments.excludeSiteNo#:siteName=#arguments.siteName#:siteDateOpen=#arguments.siteDateOpen#:siteDateClose=#arguments.siteDateClose#:stID=#arguments.stID#:satID=#arguments.satID#:siteStatus=#arguments.siteStatus#:saStatus=#arguments.saStatus#:orderBy=#arguments.orderBy#';
	
	//Call the restful service method.
	this.q2 = restObj.getRestfulService(
		url=application.mcmsAPIURL,
		path=application.siteAPIPath & '/read/getSiteAddress',
		parameter=parameterString,
		method="get",
		format=application.siteAPIFormat	
	);

	return this.q2;
	
	//} catch (any e) { WriteOutput("<p>getSiteAddress() Error: #e.message#</p>"); }
		
	}
	
// [END getSiteAddress()]

// [START updateSite()]
	public struct function updateSite(
		required string ID=0,
		required numeric siteNo=0,
		required string siteName='',
		required numeric imgID=0,
		required string siteDateSet='',
		required string siteDateOpen='',
		required string siteDateGrand='',
		required string siteDateClose='',
		required numeric stID=0,
		required numeric siteSort=0,
		required numeric siteStatus=0
	) {
	
	try {
	
	this.u= StructNew();
	this.updateAction = 'true';
	
	//START: Rules and data integrity check(s).
	
	//Check for any profanity in certain values.
	regexCheck = regexObj.regexProfanity(profanityString=siteName);
	
	//If you find profanity ask the user to correct it.
	if(regexCheck CONTAINS '$%&*!') {
		
		this.updateAction = 'false';
		this.u.message = 'The Site Name contained profanity, please remove any profanity from your text.';
		
	}
	
	//END: Rules and data integrity check(s).
	
	//If the updateAction is 'true' proceed calling the restful service.
	if(this.updateAction == 'true') {
	
	//Use a ':' for the separator.
	parameterString='ID=#arguments.ID#:siteNo=#arguments.siteNo#:siteName=#arguments.siteName#:imgID=#arguments.imgID#:siteDateSet=#arguments.siteDateSet#:siteDateOpen=#arguments.siteDateOpen#:siteDateGrand=#arguments.siteDateGrand#:siteDateClose=#arguments.siteDateClose#:stID=#arguments.stID#:siteSort=#arguments.siteSort#:siteStatus=#arguments.siteStatus#';

	//Call the restful service method.
	this.u = restObj.getRestfulService(
		url=application.mcmsAPIURL,
		path=application.siteAPIPath & '/update/updateSite',
		parameter=parameterString,
		method="post",
		format=application.siteAPIFormat	
	);
	
	}
	
	return this.u;
	
	} catch (any e) { WriteOutput("<p>updateSite() Error: #e.message#</p>"); }
		
	}
	
// [END updateSite()]

// [START updateSiteList()]
	public struct function updateSiteList(
		required string ID='0',
		required numeric siteStatus=0
	) {
	
	try {
	
	this.ul= StructNew();
	
	this.updateListAction = 'true';
	
	//If the updateAction is 'true' proceed calling the restful service.
	if(this.updateListAction == 'true') {
	
	//Use a ':' for the separator.
	parameterString='ID=#arguments.ID#:siteStatus=#arguments.siteStatus#';

	//Call the restful service method.
	this.ul = restObj.getRestfulService(
		url=application.mcmsAPIURL,
		path=application.siteAPIPath & '/update/updateSiteList',
		parameter=parameterString,
		method="post",
		format=application.siteAPIFormat	
	);
	
	}
	
	return this.ul;
	
	} catch (any e) { WriteOutput("<p>updateSiteList() Error: #e.message#</p>"); }
		
	}
	
// [END updateSite()]

// [START deleteSite()]
	public struct function deleteSite(
		required string ID='0'
	) {
	
	try {
	
	this.d= StructNew();
	
	this.deleteAction = 'true';
	
	//If the updateAction is 'true' proceed calling the restful service.
	if(this.deleteAction == 'true') {
	
	//Use a ':' for the separator.
	parameterString='ID=#arguments.ID#';

	//Call the restful service method.
	this.d = restObj.getRestfulService(
		url=application.mcmsAPIURL,
		path=application.siteAPIPath & '/delete/deleteSite',
		parameter=parameterString,
		method="post",
		format=application.siteAPIFormat	
	);
	
	}
	
	return this.d;
	
	} catch (any e) { WriteOutput("<p>deleteSite() Error: #e.message#</p>"); }
		
	}
	
// [END updateSite()]
		
}

