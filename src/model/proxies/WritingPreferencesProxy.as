package model.proxies{
import com.adobe.crypto.MD5;


import utils.CustomEvent;
	
	public class WritingPreferencesProxy extends Proxy {
		public const PREFERENCES_SET:String = "prefsSet";
		private var reqStr:String = "";
		 
				
		public function WritingPreferencesProxy(s:String) {
			
			super(s); 
		}
		
	
		//sets the user's preferences json string
		public function setPreferences(s:String, iD:int):void
		{
			reqStr = "UPDATE preferences SET value = '"+s+"' WHERE user_id = "+iD.toString()+" AND name = 'defaultsearchparameters'";
			trace(">>>> reqStr:"+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		}
		override public function dataReturned(e:CustomEvent):void
		{
			trace("data returned from updating preferences");
			if (e.arg[0].isError){
				dispatchEvent(new CustomEvent(COMMS_ERROR));
			}else{
				dispatchEvent(new CustomEvent(PREFERENCES_SET));
			}
		}

	} 
} 