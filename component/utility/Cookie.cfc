component 
{
	
	public any function setCookieLaw(required string status, required string cssClassName) {
		
		result = '';
		
		if (status == 'true') {
			
			savecontent variable="result" {
				
				if (UCASE(Evaluate('cookie.MCMS#application.applicationname#.accept')) == true) {
					
					WriteOutput("<style>
		
							.#cssClassName# {
			
								margin-top:0px !important;
			
							}
		
		
						</style>");
					
				} else {
					
					WriteOutput("
					
						<style>
		
							.#cssClassName# {
			
								margin-top:40px !important;
			
							}
		
		
						</style>
						
						<div id='cookieMessage'>
		
							This website uses cookies in order to offer the most relevant experience. <a href='/?mcmsCookieAccept=true'>Close?</a>
		
						</div>
						
					");
						
				}
				
			}
				
	
		} 
				
		return result;
		
	}
	
}