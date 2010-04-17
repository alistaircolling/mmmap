package
{
	import com.afcomponents.umap.types.LatLng;

	public class ResultsRequest extends Object
	{
		private var _customer:int;
		private var _product:int;
		private var _startDate:Date;
		private var _endDate:Date;
		private var _saleType:String; //"sales" "rentals" "all"
		private reqStr:String;
		
		public function ResultsRequest(c:int = null, p:int = null,  sD:Date = null, eD:Date = null, sT:String = "all",)
		{
			_customer = c;
			_product = p;
			_startDate = sD;
			_endDate = eD;
			_saleType = sT;
		}
		public function getRequest():void
		{
			reqStr = "SELECT * FROM transactions WHERE customer_id = CUSTOMERID AND product_id = PRODUCTID AND.."
				
				//if customer id isnt entered dont add it to string
				
				//"SELECT * from transactions WHERE start_date < '2010-01-04'"
		}

	

	}
}