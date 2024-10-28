component 
{

public void function createLog(required struct args) {

		param name="args.appNo" default="0" type="numeric";  
		param name="args.lText" default="" type="string";
		param name="args.ltID" default="0" type="numeric";
		param name="args.userIP" default="" type="string";
		param name="args.userID" default="0" type="numeric";
		param name="args.saascID" default="0" type="string";

		//try {

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="appNo",value="#args.appNo#",cfsqltype="NUMERIC");
		qObj.addParam(name="lText",value="#args.lText#",cfsqltype="VARCHAR");
		qObj.addParam(name="ltID",value="#args.ltID#",cfsqltype="NUMERIC");
		qObj.addParam(name="userIP",value="#args.userIP#",cfsqltype="VARCHAR");
		qObj.addParam(name="userID",value="#args.userID#",cfsqltype="NUMERIC");
		qObj.addParam(name="saascID",value="#args.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="
		INSERT into TBL_LOG (appNo, lText, ltID, userIP, userID, saascID) 
		VALUES (:appNo, :lText, :ltID, :userIP, :userID, :saascID)
		");

		qObj.clearParams();

		//}
		//catch (any e) {
		//include "index.htm";
		//}


}
}