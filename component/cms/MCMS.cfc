component {
	
	// [START getUserRoleApplicationAccess]

	public string function getUserRoleApplicationAccess(appID=0) {

		var.uraID = 0;

		try {
		
			//Get the appID position in the list of user role applications.
			var.appIDPos = ListFind(session.urappID, arguments.appID);

			if(var.appIDPos != 0) {

				//Return result of user access level from list by position.
				var.uraID = ListGetAt(session.uraID, var.appIDPos);

			} else {

				//Redirect to authentication if no appID is present.
				location(url="#application.mcmsAuthenticatePath#", addtoken="false");

			}

			return var.uraID;

		} catch(any e) {

			message = "MCMS Error: An error occurred with the getUserRoleApplicationAccess() function.";
			invoke('Application', 'onError', {e=e, eventName=message});

		}

	}

	// [END getUserRoleApplicationAccess]	

	// [START getApplicationDetail]

	public struct function getApplicationDetail(appID=0) {

		var.result = StructNew();
		result.appName = 'Default Application';
		result.appDescription = 'Default Application Description';

		//try {
		
			//Get the application detail.
			getApplicationRet = getApplication(appID);

			if(getApplicationRet.recordcount != 0) {

				//Return results.
				result.appName = getApplicationRet.appName;
				result.appDescription = getApplicationRet.appDescription;

			}

			return var.uraID;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getApplicationDetail() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getApplicationDetail]

	// [START getApplication]

    public query function getApplication(

        required string keywords='All',
        required string ID='0',
        required string excludeID='0',
        required string appID='100',
        required string excludeAppID='0',
        required string appStatus='1,3',
        required string orderBy=''
        
        ) {

        //try {		

            result = '';
            
            qObj = new query();
            qObj.setDatasource(application.mcmsDSN);
            qObj.setName("q");
            qObj.addParam(name="keywords", value=keywords, list=true, separator=' ', cfsqltype="VARCHAR");
            qObj.addParam(name="ID", value=ID, list=true, separator=',', cfsqltype="NUMERIC");
            qObj.addParam(name="excludeID", value=excludeID, list=true, separator=',', cfsqltype="NUMERIC");
            qObj.addParam(name="appID", value=appID, list=true, separator=',', cfsqltype="NUMERIC");
            qObj.addParam(name="excludeAppID", value=excludeAppID, list=true, separator=',', cfsqltype="NUMERIC");		
            qObj.addParam(name="appStatus", value=appStatus, list=true, cfsqltype="VARCHAR");

            //Create sql arguments for query.
            
            qArgs = '';
				
            if(keywords != 'All') {  
            
                //Loop over the keyword(s) separated by a space.
                for (i = 1; i LTE ListLen(keywords); i++) { 
                        
                    qObj.addParam(name='kw', value='%#ListGetAt(UCASE(keywords), i)#%', cfsqltype='VARCHAR');
                    qArgs = qArgs & ' AND (UPPER(appName) LIKE :kw) ';
                    
                    }
                    
            }
				
            if(ID != 0) { qArgs = qArgs & ' AND ID IN (:ID) '; }
            if(excludeID != 0) { qArgs = qArgs & ' AND ID NOT IN (:excludeID) '; }
            if(appID != 100) { qArgs = qArgs & ' AND appID IN (:appID) '; }
            if(excludeAppID != 0) { qArgs = qArgs & ' AND appID NOT IN (:excludeAppID) '; }
            if(appStatus != '1,3') { qArgs = qArgs & ' AND appStatus IN (:appStatus) '; }
            if(orderBy != '') { qArgs = qArgs & ' ORDER BY #orderBy#'; }
            
            result = qObj.execute(sql="SELECT ID, appID, appName, appNameAlt, appDescription, appURL, appStatus FROM V_APPLICATION WHERE 0=0 "  & qArgs);
            q = result.getResult();
            recordcount = q.recordcount;
            qObj.clearParams();
            result = q;

            return result;

        //} catch(any e) {

            //message = "Authenticate Error: An error occurred with the getApplication() function.";
            //invoke('Application', 'onError', {e=e, eventName=message});

        //}		

    }

	// [END getApplication]
	
	// [START getSubNavigation]

	public string function getSubNavigation(appID=0, mcmsPageIDList='') {

		var.result = '';

		//try {

			//Get Application Details.
			getApplicationDetailRet = getApplication(appID=url.appID);

			this.appName = getApplicationDetailRet.appName;
			this.appDescription = '';

			//Only show the app description on the first page.
			if(url.mcmsPageID == '' || url.mcmsPageID == ListGetAt(mcmsPageIDList, 1)) {
			
				this.appDescription = '
				
				<div class="panel panel-default">

					<div class="panel-body">

						#getApplicationDetailRet.appDescription#

					</div>

				</div>

				';

			}

			//Construct the menu items.
			this.pageIDs = '';
			activeItem = '';

			loopcount=0;

			for (i in listToArray(mcmsPageIDList, ",")) {

				loopcount++;

				if(url.mcmsPageID == i || url.mcmsPageID == '' && loopcount==1) {

					activeItem = 'active';

				}

				this.pageIDs = this.pageIDs & '<li class="#activeItem#"><a href="?appID=#appID#&mcmsPageID=#i#">#i#</a></li>';

				activeItem = '';

			}

			savecontent variable="result" {

				WriteOutput('
				
					<nav class="navbar sub-navbar-default">

						<h1 class="sub-navbar-brand">#this.appName#</h1>
				
						<div class="navbar-header">
	
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##subNavbar">
	
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span> 
													
							</button>
					
						</div>
	
						<div class="collapse navbar-collapse" id="subNavbar">
	
							<ul class="nav navbar-nav">
								
								#this.pageIDs#
	
							</ul>
	
						</div>
						
						#this.appDescription#
		
				</nav>

				');

			}

			return result;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getSubNavigation() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getSubNavigation]

	// [START getActionButtons]

	public string function getActionButtons(uraID=0,uraIDDefault=102,ID=0,templates='') {

		var.result = '';

		this.updateModal = '';
		this.deleteModal = '';

		//Set template based on position in list.
		this.updateTemplate = ListGetAt(templates, 1);
		this.deleteTemplate = ListGetAt(templates, 2);

		//try {

			//Show action buttons based on user role access.
			if(uraID LTE uraIDDefault) {

				this.updateModal = '<a href="" id="updateModal" class="edit" data-toggle="modal" data-target="##updateModal" data-id="#ID#" data-template="#this.updateTemplate#"><i class="glyphicon glyphicon-cog" data-toggle="tooltip" title="Update"></i></a>';
				this.deleteModal = '<a href="" id="deleteModal" class="delete" data-toggle="modal" data-target="##deleteModal" data-id="#ID#" data-template="#this.deleteTemplate#"><i class="glyphicon glyphicon-minus-sign" data-toggle="tooltip" title="Delete"></i></a>';

			}

			savecontent variable="result" {

				WriteOutput('

					<td nowrap>
						
						#this.updateModal#
						#this.deleteModal#

					</td>
				
				');

			}

			return result;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getActionButtons() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getActionButtons]

	// [START getColumnHeader]

	public string function getColumnHeader(colNameList='') {

		this.colHeader = '

		<thead>

			<tr>
		
				<th>
                            
				<span class="custom-checkbox">
					
					<input type="checkbox" id="selectAll">
					<label for="selectAll"></label>
					
				</span>
			
			</th>
		
		';

		//try {
			
			loopcount = 0;

			for (colName in listToArray(colNameList, ",")) {

				loopcount++;

				if(loopcount <= 2) {

					this.colHeader = this.colHeader & '<th>#colName#</th>';

				} else {

					this.colHeader = this.colHeader & '<th class="hidden-xs hidden-sm">#colName#</th>';

				}

			}

			this.colHeader = this.colHeader & '<th>&nbsp;</th></tr></thead>';

			return this.colHeader;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getColumnHeader() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getColumnHeader]

	// [START getColumnValue]

	public string function getColumnValue(colValueList='', rs='', index=0) {
		
		//Begin the initial value with the checkbox.
		this.colValue = '

			<td>
				<span class="custom-checkbox">
					<input type="checkbox" id="checkbox#index#" name="options[]" value="1">
					<label for="checkbox#index#"></label>
				</span>
			</td>

		';

		//try {
			
			loopcount = 0;

			for (colValue in listToArray(colValueList, ",")) {

				//Check for grouped column values by pipe delimeter.
				if(ListContains(colValue, '|')) {

					this.cv = '';

					pipeloop = 0;

					for (colValuePipe in listToArray(colValue, "|")) {

						pipeloop++;

						//Do not wrap first item in list in parentheses.
						if(pipeloop == 1) {

							this.cv = rs[colValuePipe][index];

						} else {

							this.cv = this.cv & ' (' & rs[colValuePipe][index] & ')';

						}

					}
					
				} else {

					this.cv = rs[colValue][index];

				}

				

				loopcount++;

				if(loopcount <= 2) {

					this.colValue = this.colValue & '<td>#this.cv#</td>';

				} else {

					this.colValue = this.colValue & '<td class="hidden-xs hidden-sm">#this.cv#</td>';

				}

			}

			return this.colValue;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getColumnValue() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getColumnValue]

	// [START getResultSetHandler]

	public struct function getResultSetHandler(rs='', url='') {

		//
		result = StructNew();

		//try {
			
			//Contruct resultset and pagination vars.
			result.rc = rs.recordcount;
			result.message = '';
			result.maxRows = url.maxRows;
			result.pageNo = url.pageNo;
			result.startRow = Min((result.pageNo-1) * result.maxRows+1, Max(result.rc,1));
			result.endRow = Min(result.startRow + result.maxRows-1, result.rc);
			result.totalPages = Ceiling(result.rc/result.maxRows);	
			result.pageRecordcount = url.mcmsPageRecordcount;
			result.pageIncrement = url.mcmsPageIncrement;

			//Create message based on return of resultset.
			if(result.rc == 0) {

				messageID = 'mcmsMessage';

				if(url.mcmsQuery) {

					messageID = 'mcmsMessageFade';

				}

				result.message = '
				
					<div id="#messageID#" class="alert alert-warning text-center">

						There are no records.
			
					</div>

				';

			}

			return result;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getResultSetHandler() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getResultSetHandler]

	// [START getPagination]

	public string function getPagination(rsh='', url='', qs='') {

		//
		result = '';

		//try {

			//Get result set info and pagination vars.
			
			showPrevious = '';
			showFirst = '';
			showNext = '';
			showCurrentPage = '';
			showPage = '';
			showNextPage = '';
			showRowOption = '';

			//Include required appID.
			appID = 'appID=#url.appID#';
			
			//Construct the querystring from any additional advanced query options.
			queryString = Replace('&' & ListChangeDelims(qs, '&'), ' ', '', 'All');

			//Show previous link.

			if(rsh.rc > rsh.pageIncrement){

				if(rsh.pageNo == 1){

					showPrevious = '
					
					<li id="mcmsShowPreviousDisabled" class="page-item disabled">
						<a class="page-link" href="?#appID#&pageNo=#Max(DecrementValue(rsh.pageNo),1)#&maxRows=#rsh.maxRows##queryString#">Previous</a>
					  </li>
					
					';


				} else {

					showFirst = '
						
						<li id="mcmsShowFirst" class="page-item">
							<a class="page-link" href="?#appID#&pageNo=1&maxRows=#rsh.maxRows##queryString#">First</a>
						</li>
					
					';
					
					showPrevious = '
						
						<li id="mcmsShowPrevious" class="page-item">
							<a class="page-link" href="?#appID#&pageNo=#Max(DecrementValue(rsh.pageNo),1)#&maxRows=#rsh.maxRows##queryString#">Previous</a>
						</li>
					
					';

				}

				//Show page link.

				if(rsh.rc > rsh.maxRows*(Max(DecrementValue(rsh.pageNo+1),1))) {

					showPage = '
					
						<li id="mcmsShowPage" class="page-item">
							<a class="page-link" href="?#appID#&pageNo=#rsh.pageNo+1#&maxRows=#rsh.maxRows##queryString#">#rsh.pageNo+1#</a>
						</li>
						
						';

				}

				//Show next pages.

				if(rsh.rc > rsh.maxRows*(Max(DecrementValue(rsh.pageNo+2),1))) {

					showNextPage = '

						<li id="mcmsShowNextPage" class="page-item">
							<a class="page-link" href="?#appID#&pageNo=#rsh.pageNo+2#&maxRows=#rsh.maxRows##queryString#">#rsh.pageNo+2#</a>
						</li>
						
						';

				}

				//Show Next.

				if(rsh.rc > rsh.maxRows) {

					showNext = '
					
						<li id="mcmsShowNext" class="page-item">
							<a class="page-link" href="?#appID#&pageNo=#Min(IncrementValue(rsh.pageNo),rsh.totalPages)#&maxRows=#rsh.maxRows##queryString#">Next</a>
						</li>
						
						';

				}

				//Show Current Page.

				showCurrentPage = '

					<li id="mcmsShowCurrentPage" class="page-item">
						<a class="page-link" href="?#appID#&pageNo=#rsh.pageNo#&maxRows=#rsh.maxRows##queryString#">#rsh.pageNo#</a>
					</li>

				';


			}

			//Construct page count select menu.

			if(rsh.rc GT rsh.maxRows) {

				showRowOption = '<select id="mcmsSelectShowRows" class="form-control" onChange="showRowsPerPage(this.value)">';

				if(rsh.rc > rsh.pageIncrement) {

					for (i = 1; i <= rsh.pageRecordcount; i++) {
						
						if(i*rsh.pageIncrement EQ rsh.maxRows) {

							showRowOption = showRowOption & '<option selected>Show #i*rsh.pageIncrement# Rows</option>';

						} else {

							showRowOption = showRowOption & '<option value="?#appID#&pageNo=#rsh.pageNo#&maxRows=#i*rsh.pageIncrement##queryString#">#i*rsh.pageIncrement#</option>';

						}

					}

					showRowOption = showRowOption & '</select>';

				}

			}

			

			savecontent variable="result" {

				WriteOutput('
				
					<div class="row">
						
						<div id="mcmsPagination" class="col-sm-12 pull-right">
								
				');

				if(rsh.rc == 0) {

					WriteOutput('&nbsp;');


				} else {
					
					WriteOutput('
						
						<nav>
							
							<ul class="pagination" style="padding-top:20px; padding-right:20px;">	

								<li id="mcmsTotalRecords" class="page-item">
						
									<a> #rsh.startRow# - #rsh.endRow# of #rsh.rc# </a>
	
								</li>
							
								#showFirst#
								
								#showPrevious#

								#showCurrentPage#
							
								#showPage#

								#showNextPage#

								#showNext#

								#showRowOption#
								
							</ul>
					
						</nav>

					');

				} 

				WriteOutput('</div></div>');

			}

			return result;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getPagination() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getPagination]

	// [START getResultSearch]

	public string function getResultSearch(uraID=105, rsh='') {

		//
		result = '';

		//Get crud buttons.
		showButtons = getCRUDButtons(uraID);

		//try {
			
			savecontent variable="result" {

				WriteOutput('

					<div class="row">

						<form class="form-inline" role="form">

							<div class="form-group col-sm-8">
								
								<div class="input-group pull-right">	
																
									<input type="text" id="search" class="form-control" placeholder="Search this page...">
									<span class="input-group-addon glyphicon glyphicon-search"></span>

									<a href="javascript:void(0)" id="mcmsAdvancedSearchButton" class="btn btn-info" onclick="openNav()"><span class="glyphicon glyphicon-filter"></span> Advanced Search</a>

															
								</div>
									
							</div>

							<div class="form-group col-sm-4">

								<div id="mcmsCRUDButtons" class="input-group pull-right">	

									#showButtons#
								
								</div>

							</div>

						</form>

					</div>
				
				');

			}

			return result;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getResultSearch() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getResultSearch]

	// [START getAdvancedSearch]

	public string function getAdvancedSearch(template='') {

		//
		result = '';

		//try {

			//Build path.
			templatePath = Replace(CGI.SCRIPT_NAME, 'index.cfm', '') & template;

			//Set advanced search open if used.
			openState = '';

			if(url.mcmsQueryOpen) {

				openState = 'width:325px;';

			}
			
			savecontent variable="result" {

				WriteOutput('

					<div id="mcmsQuerySideBar" class="sidenav" style="#openState#">

						<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>

						<div class="row">

							<div class="col-sm-12">
				
								<form name="mcmsAdvancedSearchForm" id="mcmsAdvancedSearchForm" class="form col-sm-12" role="form" method="get">
									
									<input name="appID" type="hidden" id="appID" value="#url.appID#">
									<input name="mcmsPageID" type="hidden" id="mcmsPageID" value="#url.mcmsPageID#">
					
									<div class="form-group">

										<h3>Search</h3>
										
										<div class="input-group">
									
											<label>Keywords</label>
											<input name="keywords" type="text" id="keywords" class="form-control" placeholder="Keyword Search..." onfocus="this.value=''''" value="#url.keywords#">
									
										</div>
									
									</div>

									');

									//Include the template.
									include templatePath;
									

									WriteOutput('
								
										<div class="form-group">
													
											<div class="input-group" style="padding-top:20px;">

												<button type="submit" name="mcmsQuery" id="mcmsQuery" value="true" class="btn btn-primary">Search</button>
												&nbsp;
												<button type="button" name="mcmsReset" id="mcmsReset" onclick="clearForm(''mcmsAdvancedSearchForm'');" class="btn btn-reset">Reset</button>

											</div>

										</div>
										
										<input type="checkbox" class="control-input" name="mcmsQueryOpen" id="mcmsQueryOpen" value="true" #Iif(url.mcmsQueryOpen, DE('checked'), DE(''))#/>
										
										Keep search form open?

								</form>

							</div>

						</div>

					</div>
				
				');

			}

			return result;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getAdvancedSearch() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getAdvancedSearch]

	// [START getCRUDButtons]

	public string function getCRUDButtons(uraID) {

		//
		result = '';

		showButtons = '';

		if(uraID <= 102){

			showButtons = '
			
				<a href="##addModal" id="mcmsCRUDButton" class="btn btn-primary" data-toggle="modal"><span class="glyphicon glyphicon-plus-sign"></span><span>&nbsp;Create</span></a>
				<a href="##deleteModal" id="mcmsCRUDButton" class="btn btn-danger" data-toggle="modal"><span class="glyphicon glyphicon-minus-sign"></span><span>&nbsp;Delete</span></a>
			
			';

		}

		//try {
			
			savecontent variable="result" {

				//Show CRUD buttons based on user role access.

				WriteOutput(showButtons);

			}

			return result;

		//} catch(any e) {

			//message = "MCMS Error: An error occurred with the getCRUDButtons() function.";
			//invoke('Application', 'onError', {e=e, eventName=message});

		//}

	}

	// [END getCRUDButtons]

}