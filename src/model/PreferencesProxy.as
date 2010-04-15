package model{
import proxies.SqlComm;

import utils.CustomEvent;
	
	public class PreferencesProxy extends Proxy {
		public var PREFERENCES_RECEIVED:String = "prefsReceived";
		private var reqStr:String = "SELECT * FROM preferences WHERE user_id = "; 
		 
				
		public function PreferencesProxy(s:String) {
			
			super(s); 
		}
		
		public function requestPreferences(s:int):void
		{
			//s = "1";//todo write correct sql to get userid from username
			reqStr += "'"+s.toString()+"'";
			trace("requesting preferences....."+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
		
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
			//preferences are stored in JSON string
			var jsonPrefs:String = myX..value;
			dispatchEvent(new CustomEvent(PREFERENCES_RECEIVED, false, true, [jsonPrefs]));
		}

	} 
} 