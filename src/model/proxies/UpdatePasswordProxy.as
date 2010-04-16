package model.proxies{
import com.adobe.crypto.MD5;


import utils.CustomEvent;
	
	public class UpdatePasswordProxy extends Proxy {
		public const PASSWORD_UPDATED:String = "passwUpdated";
		private var reqStr:String;
		 
				
		public function UpdatePasswordProxy(s:String) {
			
			super(s); 
		}
		
		public function updatePassword(s:String, i:int):void
		{
			var md5PWord:String = MD5.hash(s);
			reqStr = "UPDATE users SET password = '"+md5PWord+"' WHERE user_id = "+i.toString();
			sqlComm.sqlReq(reqStr+s.toString(), sqlMethod);
			trace("updating password:"+s);
		}
		
		override public function dataReturned(e:CustomEvent):void
		{
			dispatchEvent(new CustomEvent(PASSWORD_UPDATED));
		}

	} 
} 