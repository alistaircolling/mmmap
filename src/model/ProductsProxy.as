package model{
import utils.CustomEvent;
	
	public class ProductsProxy extends Proxy {
		public var PRODUCTS_RECEIVED:String = "productsReceived";
		private var reqStr:String;
					
		public function ProductsProxy(s:String) {
			
			super(s); 
		}

		override public function requestData(n:int):void
		{
			reqStr = getQueryString();
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
		private function getQueryString():String
		{
			var retS:String = ""
			//make the string
			return retS;
		}
		
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
		//TODO add data to event	dispatchEvent(new CustomEvent(PRODUCTS_RECEIVED, false, true, [myX,currAnswerReq])); 
		}

	} 
} 