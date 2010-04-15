package model{
import proxies.SqlComm;

import utils.CustomEvent;
	
	public class PreferencesProxy extends Proxy {
		public var PREFERENCES_RECEIVED:String = "prefsReceived";
		private var reqStr:String = "SELECT * FROM preferences WHERE user_id = "; 
		 
				
		public function PreferencesProxy(s:String) {
			
			super(s); 
		}
		
		public function requestPreferences(s:String):void
		{
			reqStr += "'"+s+"'";
			trace("requesting customers....."+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
		
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
		//TODO add new event	dispatchEvent(new CustomEvent(CUSTOMERS_RECEIVED, false, true, [myX,currAnswerReq])); 
		}

	} 
} 