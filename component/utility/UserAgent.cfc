/**
 * UserAgent
 * @author ${user}
 * @date ${date}
**/

component 
{
	
// [BEGIN getIsMobile]

	public void function getIsMobile() {
		
	try {
	
	//Redirect if user agent is of mobile type.
	if (findNoCase('Android', CGI.HTTP_USER_AGENT, 1) AND CGI.SCRIPT_NAME DOES NOT CONTAIN '/mobile/') {
		
		location(url="/mobile/", addtoken="false");
		
	} else if (findNoCase('iPhone', CGI.HTTP_USER_AGENT, 1) AND CGI.SCRIPT_NAME DOES NOT CONTAIN '/mobile/') {
		
		location(url="/mobile/", addtoken="false");		
		
	}
	
	} catch(any e) {

	//Do nothing.
	
	}

}

// [END getIsMobile]
}