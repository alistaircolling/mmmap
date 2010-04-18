package model{           
	import com.adobe.serialization.json.JSON;
	import com.adobe.utils.ArrayUtil;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.profiler.showRedrawRegions;
	import flash.utils.setTimeout;
	import flash.xml.XMLDocument;
	
	import model.proxies.CustomersProxy;
	import model.proxies.PreferencesProxy;
	import model.proxies.ProductsProxy;
	import model.proxies.ResultsProxy;
	import model.proxies.UpdateEmailProxy;
	import model.proxies.UpdatePasswordProxy;
	import model.proxies.UserProxy;
	import model.proxies.WritingPreferencesProxy;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectProxy;
	import mx.utils.StringUtil;
	
	import utils.CustomEvent;
	

	public class Model extends Object{

		private var proxies_ar:Array;
		//stores the results of the search
		private var results:XML;
		private var csv:String;//
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
		private var updatePasswordProxy:UpdatePasswordProxy;//writes new password to the database
		private var updateEmailProxy:UpdateEmailProxy;//writes new email to db
		
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
		public function getCSV():String
		{
			csv = "";
			//if there are no results show alert
			if (!results){
				app.showAlert("Update first!", "Please update the map before requesting the CSV", true, app.showPortal);
				return "";
			}else{
				var firstRow:XML = results.row[1];
				//add column titles 
				for (var k:uint = 0; k<firstRow.children().length(); k++){
					var valueName:String = firstRow.children()[k].name();
					trace("adding name:"+valueName);
					csv += valueName+",";
				}
				csv += "\r";
				//loop thru rows
				for (var i:uint = 0; i<results.children().length(); i++){
					var transaction:XML = results.row[i];
					//loop thru properties for each row
					for (var j:uint = 0; j<transaction.children().length(); j++){
						var val:String = transaction.children()[j].valueOf();
						var nam:String = transaction.children()[j].name();
						//remove commas so it doesnt break csv formatting
						if (nam == "position"){
							var a:Array = val.split(",");
							val = a[0]+" "+a[1];
						}
							csv+= val+","	
					}
					csv+="\r";
				}
				return csv;
			}
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
			
			updatePasswordProxy = new UpdatePasswordProxy(phpURL);
			updatePasswordProxy.addEventListener(updatePasswordProxy.PASSWORD_UPDATED, passwordUpdated);
			updatePasswordProxy.addEventListener(updatePasswordProxy.COMMS_ERROR, passwordUpdateFailed);
			
			updateEmailProxy = new UpdateEmailProxy(phpURL);
			updateEmailProxy.addEventListener(updateEmailProxy.EMAIL_UPDATED, emailUpdated);
			updateEmailProxy.addEventListener(updateEmailProxy.COMMS_ERROR, writeFailed);
			
			
			productsProxy = new ProductsProxy(phpURL);
			productsProxy.addEventListener(productsProxy.PRODUCTS_RECEIVED, productsLoaded);
			
			customersProxy = new CustomersProxy(phpURL);
			customersProxy.addEventListener(customersProxy.CUSTOMERS_RECEIVED, customersLoaded);
			
			resultsProxy = new ResultsProxy(phpURL);
			resultsProxy.addEventListener(resultsProxy.RESULTS_RECEIVED, resultsLoaded);
			
		}
		private function emailUpdated(c:CustomEvent):void
		{
			app.showAlert("Email Updated", "Your new email address has been set", true, app.showAccountSettings);
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
			app.updateMainFilters();
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
			var allObj:Object = new Object();
			allObj.id = 0;
			allObj.name = "All";
			array.splice(0,0,allObj);
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
			updatePasswordProxy.updatePassword(s, userID);	
		}
		public function setNewEmail(s:String):void
		{
			updateEmailProxy.updateEmail(s, userID);
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
			results = e.arg[0][0];
			trace("results returned:"+results.children().length());
			if (results.children().length() == 0){
				//no results!
				app.showAlert("No results", "", true, app.showPortal);
			}else{
				app.currentState = "portal";
				app.mapDisplay.showResults(results);
			}
		}

		public function requestResults(customer:int = 0, product:int = 0,  sD:Date = null, eD:Date = null, sT:String = "all"):void 
		{
			currentRequest = new ResultsRequest(customer, product, sD, eD, sT);
			resultsProxy.requestResults(currentRequest);
		}
		

		
		

	} // end class
} // end package