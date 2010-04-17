package
{
	import com.afcomponents.umap.types.LatLng;
	
	import mx.events.Request;
	
	public class ResultsRequest extends Object
	{
		private var _customer:int;
		private var _product:int;
		private var _startDate:Date;
		private var _endDate:Date;
		private var _saleType:String; //"sales" "rentals" "all"
		private var _reqStr:String;
		private var _conditions:uint;
		
		
		public function ResultsRequest(c:int = null, p:int = null,  sD:Date = null, eD:Date = null, sT:String = "all",)
		{
			_customer = c;
			_product = p;
			_startDate = sD;
			_endDate = eD;
			_saleType = sT;
			_conditions = 0;
		}
		public function getRequest():String
		{
			reqStr = "SELECT * FROM transactions ";//customer_id = CUSTOMERID AND product_id = PRODUCTID AND.."
			if (_customer){
				if (conditions == 0) reqStr += "WHERE ";
				reqStr += "customer_id = "+_customer+" ";
			}
			if (_product){
				if (conditions == 0) reqStr += "WHERE ";
				if (conditions >0) reqStr += "AND ";
				reqStr += "product_id = "+_product+" ";
			}
			if (_saleType){
				if (conditions == 0) reqStr += "WHERE ";
				if (conditions >0) reqStr += "AND "
				reqStr += "type = "+_saleType+" ";
			}
			//if  start date is defined
			if (_sD){
				if (conditions == 0) reqStr += "WHERE ";
				if (conditions >0) reqStr += "AND "
				reqStr += "(sale_date > '"+getStringFromDate(_sD)+"' OR rental_end > '"getStringFromDate(_sD)+") "; 
			}
			//if  end date is defined
			if (_eD){
				if (conditions == 0) reqStr += "WHERE ";
				if (conditions >0) reqStr += "AND "
				reqStr += "(sale_date< '"+getStringFromDate(_eD)+"' OR rental_start < '"_+getStringFromDate(_eD)+") ";
			}
			return reqStr;
		}
		private function getDateFromString(s:String):Date
		{
			var retD:Date;
			var a:Array = s.split("-");
			var year:String = a[0].toString();
			var month:Number = Number(a[1])-1;
			//todo-check with mike that the dates in teh dbase dont have 0 for jan
			var date:String = a[2].toString();
			retD = new Date(year, month, date);
			return retD;
		}
		
		private function getStringFromDate(d:Date):String
		{
			var retS:String;
			retS = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
			trace("returning date string:"+retS);
			return retS;
		}
		
		
	}
}