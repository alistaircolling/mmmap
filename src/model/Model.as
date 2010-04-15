package model{           
	import com.adobe.serialization.json.JSON;
	import com.adobe.utils.ArrayUtil;
	
	import flash.events.Event;
	import flash.profiler.showRedrawRegions;
	import flash.utils.setTimeout;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectProxy;
	
	import utils.CustomEvent;
	

	public class Model extends Object{

		private var proxies_ar:Array;
	
		//private const qProxyURL:String = "http://northe.northernstages.co.uk/Ingredient.php";
		private const phpURL:String = "Ingredient.php";
		
		//retrieves product list
		private var productsProxy:ProductsProxy;
		//retrieves customer list
		private var customersProxy:CustomersProxy;
		//retrieves results for specifies filter settings
		private var resultsProxy:ResultsProxy;
		
		private var userProxy:UserProxy;
		
		private var prefsProxy:PreferencesProxy;
		
		//object created from JSON string to hold preferences
		private var preferences:Object;
		
		private var app:MMMap_FB4;
		private var username:String;
		private var userID:int;
		

		public function Model(a:MMMap_FB4) {	
			super();
			app = a;
			init();
		}

		private function init():void {
			initProxies();
		}

		private function initProxies():void {
			userProxy = new UserProxy(phpURL);
			userProxy.addEventListener(userProxy.LOGIN_SUCCESS, loginSuccess);
			userProxy.addEventListener(userProxy.LOGIN_FAILED, loginFailed);
			
			prefsProxy = new PreferencesProxy(phpURL);
			prefsProxy.addEventListener(prefsProxy.PREFERENCES_RECEIVED, preferencesLoaded);
			
			productsProxy = new ProductsProxy(phpURL);
			productsProxy.addEventListener(productsProxy.PRODUCTS_RECEIVED, productsLoaded);
			
			customersProxy = new CustomersProxy(phpURL);
			customersProxy.addEventListener(customersProxy.CUSTOMERS_RECEIVED, customersLoaded);
			
			resultsProxy = new ResultsProxy(phpURL);
			resultsProxy.addEventListener(resultsProxy.RESULTS_RECEIVED, resultsLoaded);
		}
		
		public function logMeIn(u:String, p:String):void
		{
			username = u;
			userProxy.login(u, p);
		}
		
		private function loginSuccess(e:CustomEvent):void
		{
			trace("requesting customers list from model");
			var xml:XML = e.arg[0][0][0];
			userID = Number(xml.valueOf());
			//request list of customers
			customersProxy.requestCustomers();
		}
		//todo set timeout on login time
		private function customersLoaded(e:CustomEvent):void {
			trace("customers loaded");
			var ac:ArrayCollection = convertXmlToArrayCollection(e.arg[0][0].toString());
			app.customerList = ac;
			productsProxy.requestProducts();
		}
		private function convertXmlToArrayCollection( s:String):ArrayCollection
		{
			var xml:XMLDocument = new XMLDocument( s )	
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder();
			var data:Object = decoder.decodeXML( xml );
			var array:Array = mx.utils.ArrayUtil.toArray( data.data.row );
			for (var i:uint = 0; i<array.length; i++){
				array[i] = new ObjectProxy(array[i]);
			}
			return new ArrayCollection( array );
		}
		
		private function loginFailed(e:Event):void
		{
			app.showAlert("Login Failed", "please enter correct username and password",true);			
		}
		private function preferencesLoaded(e:CustomEvent):void
		{
			var jsonString:String = e.arg[0];
			preferences = JSON.decode(jsonString);
			app.setPreferences(preferences);
		}
		
		private function mapLoaded():void {
			
		
		}
		private function productsLoaded(e:CustomEvent):void {
			trace("products loaded");
			var ac:ArrayCollection = convertXmlToArrayCollection(e.arg[0][0].toString());
			app.productList = ac;
			requestPrefs();
		}
		private function requestPrefs():void
		{
			prefsProxy.requestPreferences(userID);
		}
		private function resultsLoaded(e:CustomEvent):void
		{
			
		}

		public function requestResults(n:int):void 
		{
			trace("requesting data for:"+n);
			resultsProxy.requestData(n);
		}
		

		
		

	} // end class
} // end package