package model{
import utils.CustomEvent;
	
	public class ResultsProxy extends Proxy {
		public var RESULTS_RECEIVED:String = "resultsReceived";
		private var reqStr:String;
			
		public function ResultsProxy(s:String) {
			
			super(s); 
		}

		override public function requestData(n:int):void
		{
			//pass vfilter vars to method to make the string
			reqStr = getQueryString();
			sqlComm.sqlReq(reqStr, sqlMethod);
				
				
		} 
		private function getQueryString():String
		{
			var retS:String = ""
			//make the string
			return retS;
		}
		
		override public function getRequestString(n:int):String
		{
//			trace("--------->  GET REQUEST STRING:"+n);
//			var currArr:Array = qArray[n];
//			var qStr:String = "";
//			for (var i:uint = 0; i<currArr.length; i++){
//				qStr += currArr[i]
//				if (currArr.length>0 && i<currArr.length-1){
//					qStr+=",";
//				}
//			}
//			var locStr:String = "bornLoc";
//			var locName:String = "bornLocName";
//		 	if (n!=0)
//			{
//				locStr = "currLoc";
//				locName = "currLocName";
//			} 
//			
//TODO make correct return string
			return "";
			//return "SELECT "+locStr+", name, id, "+locName+", createdAt, "+qStr+" FROM ns_answers where approved=1";
			//return "SELECT "+locStr+", name, "+locName+", createdAt, "+qStr+" FROM ns_answers where approved=1";
		}
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
		//todo dispatch correct event	dispatchEvent(new CustomEvent(RESULTS_RECEIVED, false, true, [myX,currAnswerReq])); 
		}
		

	} 
} 