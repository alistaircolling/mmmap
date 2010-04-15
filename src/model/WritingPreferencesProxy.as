package model{
import com.adobe.crypto.MD5;

import proxies.SqlComm;

import utils.CustomEvent;
	
	public class WritingPreferencesProxy extends Proxy {
		public const PREFERENCES_SET:String = "prefsSet";
		private var reqStr:String = "SELECT..............";
		 
				
		public function WritingPreferencesProxy(s:String) {
			
			super(s); 
		}
		
	
		//sets the user's preferences json string
		//sets the user's preferences json string
		public function setPreferences(s:String):void
		{
			//sqlComm.sqlReq(reqStr+s.toString(), sqlMethod);
			//todo write query that writes to the database and returns if succesful --Mike
			trace("prefs proxy setting preferences:"+s);
			trace("THE PREFS HAVE NOT BEEN PROPERLY UPDATED, TODO IN WRITINGPREFERENCES PROXY");
			//testing--- used as this data is not being sent to the server
			dispatchEvent(new CustomEvent(PREFERENCES_SET));
			
		}
		override public function dataReturned(e:CustomEvent):void
		{
			dispatchEvent(new CustomEvent(PREFERENCES_SET));
		}

	} 
} 