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
		//populate fields array with field names for use when requesting question-- 
		//not used as currently hard coded, could be used to pull questions from db later
//		private function fieldsReturned(e:CustomEvent):void
//		{
//			trace("Fields returned, requesting answers")
////			var myX:XML = e.arg[0].data[0] as XML;
////			var myX2:XML = myX..row[0] as XML;	
////			//update fields array
////			var myL:XMLList = myX2.children();			
////			for (var j:uint = 0; j<myX2.children().length(); j++){
////				var nodeName:String = myX2.children()[j].name().localName; 
////				//trace("nodeName:"+nodeName);
////				fields_ar.push(nodeName);
////			}
//			//trigger the original request
//			requestData(currAnswerReq);
//		}

	} 
} 