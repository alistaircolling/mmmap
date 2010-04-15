package model{
import adobe.utils.CustomActions;

import proxies.SqlComm;

import utils.CustomEvent;
	
	public class UserProxy extends Proxy {
		public var LOGIN_SUCCESS:String = "loginSuccess";
		public var LOGIN_FAILED:String = "loginFailed";
		private var reqStr:String = "SELECT ...."; 
		private var password:String;
		 
				
		public function UserProxy(s:String) {
			super(s); 
		}
		
		public function login(u:String, p:String):void
		{
			password = p;
			reqStr = "SELECT * FROM users WHERE username = '"+u+"'"
			trace("requesting customers....."+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
			//testing
			//dispatchEvent(new CustomEvent(LOGIN_FAILED, false, true));
		} 
		private function checkPassword():Boolean
		{
			return true;
		}
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
		//TODO add new event	dispatchEvent(new CustomEvent(LOGIN_FAILED, false, true, [myX,currAnswerReq])); 
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