package markers
{
	import com.afcomponents.umap.overlays.Marker;
	import com.afcomponents.umap.styles.MarkerStyle;
	
	public class BasicMarker extends Marker
	{
		public function BasicMarker(arg0:Object=null, arg1:Object=null)
		{
			//style is the second argument
			var sty:Object = getTheStyle();
			super(arg0, sty);
		}
		protected function getTheStyle():Object
		{
			var ss:StopSign = null;
			//TODO extend to return the style for the correct sign
			var style:MarkerStyle = new MarkerStyle();
			style.icon = "StopSign";
			style.shadow = true;
			//style.iconStyle.offset = new Offset(18,18);
			return style;
		}
	}
}