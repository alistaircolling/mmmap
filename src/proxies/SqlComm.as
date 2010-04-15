package proxies
{
	/*will send an sql query to the defined php script and method and will trigger the SQL_RETURNED event when the data has been received*/
	//TODO: add timeout in case data is not returned
	 
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import utils.CustomEvent;
	
	public class SqlComm extends EventDispatcher
	{
		private var ENDPOINT_URL:String;
		
		public const SQL_RETURNED:String = "sqlReturned";

		private var gateway:HTTPService;
		
		
		public function SqlComm(u:String)
		{
			ENDPOINT_URL = u;
			init();
		}
		private function init():void
		{
			gateway = new HTTPService();
			gateway.url = ENDPOINT_URL;
		    gateway.method = "POST";
		    gateway.useProxy = false;
		    gateway.resultFormat = "e4x";
		    gateway.addEventListener(ResultEvent.RESULT, resultHandler);
		    gateway.addEventListener(FaultEvent.FAULT, faultHandler);
		}
		private function httpS(h:HTTPStatusEvent):void
		{
			
		}
	
		public function sqlReq(sqlQ:String, meth:String):void
		{
			var parameters:* =
		    {
		        "query": sqlQ
		    }
			doRequest(meth, parameters, returnData);
		}	
		
		public function doRequest(method_name:String, parameters:Object, callback:Function):void
		{
		    // add the method to the parameters list
		    parameters['method'] = method_name;
		    gateway.request = parameters;
		    var call:AsyncToken = gateway.send();
		    call.request_params = gateway.request;
		    call.handler = callback;
		}
		
		public function returnData(e:Object):void
		{
			trace("trying to return data triggering SQL_RETURNED event");
			//trigger an event when data is returned
 			dispatchEvent(new CustomEvent(SQL_RETURNED, false, false, e));
		}
		public function resultHandler(e:ResultEvent):void
		{
		    var topass:* = deserialize(e.result, e);
		    e.token.handler.call(null, topass);
		}
		
		public function faultHandler(e:FaultEvent):void
		{
			var errorMessage:String = "Connection error: " + e.fault.faultString; 
		    if (e.fault.faultDetail) 
		    { 
		        errorMessage += "\n\nAdditional detail: " + e.fault.faultDetail; 
		    } 
		    Alert.show(errorMessage);
		}
		public function deserialize(obj:*, e:*):*
		{
		    var toret:Object = {};
		    
		    toret.originalEvent = e;
		
		    if (obj.data.elements("error").length() > 0)
		    {
		        toret.isError = true;
		        toret.data = obj.data;
		    }
		    else
		    {
		        toret.isError = false;
		        toret.metadata = obj.metadata;
		        toret.data = obj.data;
		    }
		
		    return toret;
		}

	}	
}
