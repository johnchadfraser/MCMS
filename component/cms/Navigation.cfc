component 
{
	
	// [START setTabMenu]

public string function setTabNavigation(required string tabTitle="", required string tabList="", required string pageID="" , required string tabQueryString="") {

	var result = '';

	//try {

	local.tabTitle = tabTitle;

	var tabLoop = 0;
	var tab = '<div id="mcmsTabNavigationTitle">#local.tabTitle#</div><div id="mcmsTabNavigationContainer"><p><ul class="nav nav-tabs">';

	for (i=1;i LTE ListLen(tabList);i++) {

		value = ListGetAt(tabList,i);
		tabLoop = tabLoop+1;
		activeTab = (tabLoop == 1 AND pageID == '' || pageID == value) ? 'active' : '';
		if (tabQueryString != '') {
			
			tab = tab &'<li class="#activeTab#"><a href="?mcmsPageID=#LCASE(value)#&#tabQueryString#">#value#</a></li>';
		
		} else {
						
			tab = tab &'<li class="#activeTab#"><a href="?mcmsPageID=#LCASE(value)#">#value#</a></li>';
			
		}

	}

	tab = tab & '</ul></p></div>';

	savecontent variable="result" {

	WriteOutput(tab);

	//When the tab is clicked include the sub-application path.

	pagePath = Replace(CGI.SCRIPT_NAME, '/index.cfm', '', 'ALL');

	if (pageID == '/') {

	pageID = TRIM(LCASE(ListGetAt(tabList,1)));
	//Set the default url.mcmsPageID.
	url.mcmsPageID = LCASE(pageID);

	}

	//include "#pagePath#/#pageID#/view/index.cfm";

	}

	return result;

	//} catch(any e) {

		//message = "CMS Error: An error occurred with the setTabMenu() function.";
		//invoke('application.admin.Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setTabMenu]
	
}