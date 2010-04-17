package model.proxies{
import utils.CustomEvent;
	
	public class ResultsProxy extends Proxy {
		public var RESULTS_RECEIVED:String = "resultsReceived";
		private var reqStr:String;
			
		public function ResultsProxy(s:String) {
			
			super(s); 
		}

		public function requestResults(req:ResultsRequest):void
		{
			//pass vfilter vars to method to make the string
			reqStr = req.getQueryString();
			trace("---REQUESTING RESULTS WITH STRING.....");
			trace(reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
	
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
			dispatchEvent(new CustomEvent(RESULTS_RECEIVED, false, true, [myX])); 
		}
		

	} 
} 