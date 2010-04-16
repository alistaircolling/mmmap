package model.proxies{

import utils.CustomEvent;
	
	public class CustomersProxy extends Proxy {
		public var CUSTOMERS_RECEIVED:String = "customersReceived";
		private const reqStr:String = "SELECT * FROM customers";
		 
				
		public function CustomersProxy(s:String) {
			super(s); 
		}
		
		public function requestCustomers():void
		{
			trace("requesting customers....."+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
		
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
			dispatchEvent(new CustomEvent(CUSTOMERS_RECEIVED, false, true, [myX]));
		}


	} 
} 