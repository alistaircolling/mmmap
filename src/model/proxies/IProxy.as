package model.proxies{
                
import utils.CustomEvent;

	public interface IProxy {

		function init():void;
		function requestData(n:int):void;
		function dataReturned(e:CustomEvent):void;
		function getRequestString(n:int):String;

	} // end interface
} // end package