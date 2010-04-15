package model{
import proxies.SqlComm;

import utils.CustomEvent;
	
	public class CustomersProxy extends Proxy {
		public var CUSTOMERS_RECEIVED:String = "customersReceived";
		private var reqStr:String;
		 
				
		public function CustomersProxy(s:String) {
			
			super(s); 
		}

		override public function requestData(n:int):void
		{
			var reqStr:String = getRequestString(n);
			trace("requesting answers....."+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
		override public function getRequestString(n:int):String
		{
			trace("--------->  GET REQUEST STRING:"+n);
			
			return "";// "SELECT "+locStr+", name, id, "+locName+", createdAt, "+qStr+" FROM ns_answers where approved=1";
			//return "SELECT "+locStr+", name, "+locName+", createdAt, "+qStr+" FROM ns_answers where approved=1";
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