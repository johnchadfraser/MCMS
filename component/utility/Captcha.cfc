component 
{
 
 public string function makeRandomString() {
	
	var chars = '23456789ABCDEFGHJKMNPQRS';
	var length = RandRange(3,5);
	var result = '';
	var i = '';
	var char = '';
	
	for(i=1; i <= length; i++) {
    char = MID(chars, RandRange(1, LEN(chars)), 1);
    result&=char;
    }
		
	return result;

}
   
}