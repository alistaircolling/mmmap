package model.proxies{   
import flash.errors.IllegalOperationError;


import flash.events.EventDispatcher;
import utils.CustomEvent;

	public class Proxy extends EventDispatcher implements IProxy {

		private var url:String;

		protected var sqlComm:SqlComm;
		protected var phpScript:String;
		protected var sqlMethod:String = "AsQuery";
		public var  COMMS_ERROR:String = "commsError";


		public function Proxy(s:String) {
			phpScript = s;
			init();
		}

		public function init():void {
			sqlComm = new SqlComm(phpScript);
			sqlComm.addEventListener(sqlComm.SQL_RETURNED, dataReturned);
		}

		public function requestData(n:int):void {
			throw new IllegalOperationError("Abstract class Proxy must be overriden in subclass");
		}
		public function getRequestString(n:int):String
		{
			throw new IllegalOperationError("Abstract class Proxy must be overriden in subclass");
		}

		public function dataReturned(e:CustomEvent):void 
		{
			throw new IllegalOperationError("Abstract class Proxy must be overriden in subclass");
		}

	} // end class
} // end package