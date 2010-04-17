package model.proxies{
import com.adobe.crypto.MD5;


import utils.CustomEvent;
	
	public class UpdatePasswordProxy extends Proxy {
		public const PASSWORD_UPDATED:String = "passwUpdated";
		private var reqStr:String;
		 
				
		public function UpdatePasswordProxy(s:String) {
			
			super(s); 
		}
		
		public function updatePassword(s:String, userID:int):void
		{
			
			var md5PWord:String = MD5.hash(s);
			trace("new pword:"+s+":  hashed:"+md5PWord);
			reqStr = "UPDATE users SET password = '"+md5PWord+"' WHERE id = "+userID.toString();
			sqlComm.sqlReq(reqStr, sqlMethod);
			trace("updating password:"+s);
		}
		
		override public function dataReturned(e:CustomEvent):void
		{
			if (e.arg[0].isError){
				dispatchEvent(new CustomEvent(COMMS_ERROR));
			}else{
				dispatchEvent(new CustomEvent(PASSWORD_UPDATED));
			}
		}

	} 
} 