package model{
import adobe.utils.CustomActions;

import com.adobe.crypto.MD5;

import proxies.SqlComm;

import utils.CustomEvent;
	
	public class UserProxy extends Proxy {
		public var LOGIN_SUCCESS:String = "loginSuccess";
		public var LOGIN_FAILED:String = "loginFailed";
		private var reqStr:String = "SELECT ...."; 
		private var password:String;
		 
				
		public function UserProxy(s:String) {
			super(s); 
		}
		
		public function login(u:String, p:String):void
		{
			password = p;
			reqStr = "SELECT * FROM users WHERE username = '"+u+"'"
			trace("requesting customers....."+reqStr);
			sqlComm.sqlReq(reqStr, sqlMethod);
		} 
		private function checkPassword():Boolean
		{
			return true;
		}
		override public function dataReturned(e:CustomEvent):void
		{
			var myX:XML = e.arg[0].data[0] as XML;
			var md5Password:String = myX..password;
			//generate md5 version of submitted pword			
			var submittedPword:String = MD5.hash(password);
			if (md5Password == submittedPword){
				trace("login success");
				dispatchEvent(new CustomEvent(LOGIN_SUCCESS, false, true, [myX..id, md5Password]));
				
			}else{
				trace("login failed");
				dispatchEvent(new CustomEvent(LOGIN_FAILED));
				
			}
		}


	} 
} 