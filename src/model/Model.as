package model{           
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	import utils.CustomEvent;
	

	public class Model {

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
		
		private var app:MMMap_FB4;

		public function Model(a:MMMap_FB4) {	
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
			userProxy.login(u, p);
		}
		private function loginSuccess(e:Event):void
		{
			
		}
		private function loginFailed(e:Event):void
		{
						
		}
		private function preferencesLoaded(e:Event):void
		{
			
		}
		private function mapLoaded():void {
		
		}

		

		private function productsLoaded(e:CustomEvent):void {
			trace("questoins loadeed");
			var ac:ArrayCollection = e.arg[0];
		}
		
		private function customersLoaded(e:CustomEvent):void {
			trace("questoins loadeed");
			var ac:ArrayCollection = e.arg[0];
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