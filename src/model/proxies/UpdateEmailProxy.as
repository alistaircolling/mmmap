package model.proxies{
import com.adobe.crypto.MD5;


import utils.CustomEvent;
	
	public class UpdateEmailProxy extends Proxy {
		public const EMAIL_UPDATED:String = "emailUpdated";
		private var reqStr:String;
		 
				
		public function UpdateEmailProxy(s:String) {
			
			super(s); 
		}
		
		public function updateEmail(s:String, userID:int):void
		{
			reqStr = "UPDATE users SET email = '"+s+"' WHERE id = "+userID.toString();
			sqlComm.sqlReq(reqStr, sqlMethod);
			trace("updating password:"+reqStr);
		}
		
		override public function dataReturned(e:CustomEvent):void
		{
			if (e.arg[0].isError){
				dispatchEvent(new CustomEvent(COMMS_ERROR));
			}else{
				dispatchEvent(new CustomEvent(EMAIL_UPDATED));
			}
		}

	} 
} 