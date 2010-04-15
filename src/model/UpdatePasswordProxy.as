package model{
import com.adobe.crypto.MD5;

import proxies.SqlComm;

import utils.CustomEvent;
	
	public class UpdatePasswordProxy extends Proxy {
		public const PASSWORD_UPDATED:String = "passwUpdated";
		private var reqStr:String = "SELECT..............";
		 
				
		public function UpdatePasswordProxy(s:String) {
			
			super(s); 
		}
		
		public function updatePassword(s:String):void
		{
			var md5PWord:String = MD5.hash(s);
			//sqlComm.sqlReq(reqStr+s.toString(), sqlMethod);
			//todo write query that writes to the database and returns if succesful --Mike
			trace("updating password:"+s);
			trace("THE PASSWORD HAS NOT BEEN CORECTLY UPDATED-- TO DO IN UPDATEPASSWORDPROXY")
			//testing--- used as this data is not being sent to the server
			dispatchEvent(new CustomEvent(PASSWORD_UPDATED));
			
		}
		
		override public function dataReturned(e:CustomEvent):void
		{
			dispatchEvent(new CustomEvent(PASSWORD_UPDATED));
		}

	} 
} 