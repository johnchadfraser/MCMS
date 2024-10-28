component {
	
	public any function getRestfulService(
		required string url,
		required string path,
		required string parameter,
		required string method,
		required string format,
		string charset='utf-8',
		numeric timeout=30	
	) {

		//try {
		
		result='';
		
		this.url = url & path;
		
		//Set the param type based on rest method.
		if(method == 'get'){
			
			this.paramType = 'url';
			
		} else {
		
		this.paramType = 'formfield';
		
		}
		
		//Create array from querystring to loop and create http parameters.
		this.parameter = ListToArray(parameter, ':');

		//Create new http service.
		httpService = new http();
		//set attributes using implicit setters.
		httpService.setMethod(method);
		httpService.setCharset(charset);
		httpService.setUrl(this.url);
		httpService.addParam(type=this.paramType,name='DSN',value=application.mcmsDSN);
		//Add httpparams using addParam().
		for(i in this.parameter) {
			this.name = ListGetAt(i, 1, '=');
			//Make sure the value allows empty values.
			this.value = ListGetAt(i, 2, '=', 'yes');
			httpService.addParam(type=this.paramType,name=this.name,value=this.value);
		}
		//Make the http call to the URL using send().
		result = httpService.send().getPrefix();
		
		//Error check for connection failure.
		if(result.fileContent == 'Connection Failure') {
			
		throw(message='Your restful request failed and returned an Connection Failure. Error Detail: #result.ErrorDetail#');	
		
		} else {
				
		//Error check.
		switch(result.responseHeader.status_code) {
			
			case '503':
			throw(message='Your restful request failed and returned an HTTP status of 503. That means: Service unavailable. An internal problem prevented us from returning data to you.');
			
			case '403':
			throw(message='Your restful request failed and returned an HTTP status of 403. That means: Forbidden. You do not have permission to access this resource, or are over your rate limit.');
			
			case '400':
			throw(message='Your restful request failed and returned an HTTP status of 400.  That means: Bad request. The parameters passed to the service did not match as expected.');
			
			case '404':
			throw(message='Your restful request failed and returned an HTTP status of 404.  That means: Resource does not exist. The url or path may be incorrect.');	
			
		} 
		
		//Now format the response from XML/JSON to query.
		result = getRestfulFormatResponse(result,format,method);
		}
		
		//WriteDump(result);
		
		return result;
		
		//} catch (any e) { WriteOutput("<p>getRestfulService() Error: #e.message#</p>"); }

	}
	
	public any function getRestfulFormatResponse(
		required any data,
		required string format = 'json',
		required string method = 'get'
	) {

		//try {
		
		result='';
		
		switch(format){
			
			case "json":
			
			apiData = DeserializeJSON(data.FileContent);
			
			result = apiData;
			
			//If the method is to get data contruct query.
			if(method == 'get') {

			//Get the columns of the data structure.
			columns = ArrayToList(apiData.columns);
			rowCount = ArrayLen(apiData.data);
			
			//Construct a query from the JSON structure.
			q = QueryNew(columns);
			
			//If result is not null
			if(rowCount != 0) {
			
			QueryAddRow(q, rowCount);

			//Loop to create rows based on rowcount.
			for (i=1; i <= rowCount; i++) {
		
			//Loop columns to place data.
			for (x=1; x <= ListLen(columns); x++) {
			
			//Check to see the JSON value was 'null' or 'undefined' and replace with '' if it is.			
			if(ArrayIsDefined(apiData.data[i],x)) {

				QuerySetCell(q, ListGetAt(columns, x, ',', 'yes'), apiData.data[i][x], i);
			
			} else {
				
				QuerySetCell(q, ListGetAt(columns, x, ',', 'yes'), '', i);
			}


			}
			}
			
			result = q;
			
			}
					

		}
		
		break;
		
		}
		
		return result;
		
		//} catch (any e) { WriteOutput("<p>getRestfulFormatResponse() Error: #e.message#</p>"); }
	
	}
		
}
