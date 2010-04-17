package model{           
	import com.adobe.serialization.json.JSON;
	import com.adobe.utils.ArrayUtil;
	
	import flash.events.Event;
	import flash.profiler.showRedrawRegions;
	import flash.utils.setTimeout;
	import flash.xml.XMLDocument;
	
	import model.proxies.CustomersProxy;
	import model.proxies.PreferencesProxy;
	import model.proxies.ProductsProxy;
	import model.proxies.ResultsProxy;
	import model.proxies.UpdatePasswordProxy;
	import model.proxies.UserProxy;
	import model.proxies.WritingPreferencesProxy;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectProxy;
	
	import utils.CustomEvent;
	

	public class Model extends Object{

		private var proxies_ar:Array;
		
		private var currentRequest:ResultsRequest;
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
		private var writePrefsProxy:WritingPreferencesProxy;//writes the users new prefs to the database
		private var updatePaswordProxy:UpdatePasswordProxy;//writes new password to the database
		
		//object created from JSON string to hold preferences
		private var preferences:Object;
		
		private var app:MMMap_FB4;
		private var username:String;
		private var userID:int;
		public var md5Pword:String;//used to store the users md5 password for checking, should they wish to update this later
		

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
			
			writePrefsProxy = new WritingPreferencesProxy(phpURL);
			writePrefsProxy.addEventListener(prefsProxy.PREFERENCES_SET, preferencesSet);
			
			writePrefsProxy.addEventListener(writePrefsProxy.COMMS_ERROR, writeFailed);
			
			updatePaswordProxy = new UpdatePasswordProxy(phpURL);
			updatePaswordProxy.addEventListener(updatePaswordProxy.PASSWORD_UPDATED, passwordUpdated);
			
			updatePaswordProxy.addEventListener(updatePaswordProxy.COMMS_ERROR, passwordUpdateFailed);
			
			productsProxy = new ProductsProxy(phpURL);
			productsProxy.addEventListener(productsProxy.PRODUCTS_RECEIVED, productsLoaded);
			
			customersProxy = new CustomersProxy(phpURL);
			customersProxy.addEventListener(customersProxy.CUSTOMERS_RECEIVED, customersLoaded);
			
			resultsProxy = new ResultsProxy(phpURL);
			resultsProxy.addEventListener(resultsProxy.RESULTS_RECEIVED, resultsLoaded);
			
		}
		//database write error handlers
		private function passwordUpdateFailed(e:CustomEvent):void
		{
			app.showAlert("Password not updated", "Your new password has not been saved, please try again", true, app.showAccountSettings);
		}
		private function writeFailed(e:CustomEvent):void
		{
			app.showAlert("Database Error", "your preferences have not been saved, pleased try again", true, app.showAccountSettings);
		}
		//currently unused
		private function proxyError(e:CustomEvent):void
		{
			app.showAlert("Database error", "There was a problem communicating with the database, please try again", true, app.showAccountSettings);	
		}
		public function logMeIn(u:String, p:String):void
		{
			username = u;
			userProxy.login(u, p);
		}
		private function preferencesSet(e:CustomEvent):void
		{
			app.showAlert("Preferences Successfully Updated","",true,app.showPortal); 
			
			
		}
		private function passwordUpdated(e:CustomEvent):void
		{
			app.clearPasswords();
			app.showAlert("Password successfully updated", "", true, app.showAccountSettings);
		}
		private function loginSuccess(e:CustomEvent):void
		{
			trace("requesting customers list from model");
			var xml:XML = e.arg[0][0][0];
			userID = Number(xml.valueOf());
			
			md5Pword = e.arg[0][1];
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
			app.showAlert("Login Failed", "please enter correct username and password",true, app.logOut);			
		}
		private function preferencesLoaded(e:CustomEvent):void
		{
			var jsonString:String = e.arg[0];
			preferences = JSON.decode(jsonString);
			app.setPreferences(preferences);
		}
		public function setPreferences(o:Object):void
		{
			var jsonString:String = JSON.encode(o);
			writePrefsProxy.setPreferences(jsonString, userID);
		}
		//received md5 encoded pword and submits it
		public function setNewPassword(s:String):void
		{
			updatePaswordProxy.updatePassword(s, userID);	
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

		public function requestResults():void 
		{
			currentRequest = new ResultsRequest(
			trace("requesting data for:"+n);
			resultsProxy.requestData(n);
		}
		

		
		

	} // end class
} // end package