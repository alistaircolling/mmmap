package
{
	import com.afcomponents.umap.types.LatLng;
	
	public class Transaction extends Object
	{
		private var _customer:String;
		private var _location:LatLng;
		private var _productSold:uint;
		private var _saleDate:Date;
		private var _saleType:uint; //0 sale  //1  rental 
		private var _rentalStart:Date;
		private var _rentalEnd:Date;
		
		public function Transaction(s:String, l:LatLng, prod:uint,  sT:uint, sD:Date=null, rS:Date = null, rE:Date = null)
		{
			_customer = s;
			_location = l;
			_productSold = prod;
			_saleType = sT;
			_saleDate = d;
			_rentalStart = rS;
			_rentalEnd = rE;
		}
		
		public function get saleType():uint
		{
			return _saleType;
		}
		
		public function set saleType(value:uint):void
		{
			_saleType = value;
		}
		
		public function get saleDate():Date
		{
			return _saleDate;
		}
		
		public function set saleDate(value:Date):void
		{
			_saleDate = value;
		}
		
		public function get productSold():uint
		{
			return _productSold;
		}
		
		public function set productSold(value:uint):void
		{
			_productSold = value;
		}
		
		public function get location():LatLng
		{
			return _location;
		}
		
		public function set location(value:LatLng):void
		{
			_location = value;
		}
		
		public function get name():String
		{
			return _customer;
		}
		
		public function set name(value:String):void
		{
			_customer = value;
		}
		
		public function get rentalEnd():Date
		{
			return _rentalEnd;
		}
		
		public function set rentalEnd(value:Date):void
		{
			_rentalEnd = value;
		}
		
		public function get rentalStart():Date
		{
			return _rentalStart;
		}
		
		public function set rentalStart(value:Date):void
		{
			_rentalStart = value;
		}
		
		
	}
}