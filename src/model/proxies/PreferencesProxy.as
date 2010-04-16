package model.proxies{

import utils.CustomEvent;
	
	public class PreferencesProxy extends Proxy {
		public var PREFERENCES_RECEIVED:String = "prefsReceived";
		public const PREFERENCES_SET:String = "prefsSet";
		private var reqStr:String = "SELECT * FROM preferences WHERE user_id = "; 
		 
				
		public function PreferencesProxy(s:String) {
			
			super(s); 
		}
		
		public function requestPreferences(s:int):void
		{
			//s = "1";//todo write correct sql to get userid from username
			
			trace("requesting preferences....."+reqStr+s.toString());
			sqlComm.sqlReq(reqStr+s.toString(), sqlMethod);
		} 
		//sets the user's preferences
//		public function setPreferences(s:String):void
//		{
//			//todo write query that writes to the database and returns if succesful --Mike
//			trace("prefs proxy setting preferences:"+s);
//			//testing--- used as this data is not being sent to the server
//			dispatchEvent(new CustomEvent(PREFERENCES_SET));
//		}
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
			//preferences are stored in JSON string
			var jsonPrefs:String = myX..value;
			dispatchEvent(new CustomEvent(PREFERENCES_RECEIVED, false, true, [jsonPrefs]));
		}

	} 
} 