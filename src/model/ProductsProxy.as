package model{
import proxies.SqlComm;

import utils.CustomEvent;
	
	public class ProductsProxy extends Proxy {
		public var PRODUCTS_RECEIVED:String = "productsReceived";
		private const reqStr:String = "SELECT * FROM products"; 
		 
				
		public function ProductsProxy(s:String) {
			super(s); 
		}
		
		public function requestProducts():void
		{
			trace("requesting products....."+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
		
		override public function dataReturned(e:CustomEvent):void
		{
			trace("products received");
			var myX:XML = e.arg[0].data[0] as XML;
			dispatchEvent(new CustomEvent(PRODUCTS_RECEIVED, false, true, [myX]));
		}


	} 
} 