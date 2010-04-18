package markers
{
	import com.afcomponents.umap.overlays.Marker;
	import com.afcomponents.umap.styles.MarkerStyle;
	
	public class SignMarker extends Marker
	{
		private var symbolNames:Array = ["StopSign", "GoSign", "RocksFalling", "Roadworks", "SpeedBumps", "Danger", "SlowDown"];
		
		
		public function SignMarker(arg0:Object=null, arg1:Object=null, signNum:int=0)
		{
			//style is the second argument
			var sty:Object = getTheStyle(signNum-1);
			super(arg0, sty);
		}
		protected function getTheStyle(i:uint):Object
		{
			
			var sS:StopSign = null;
			var gS:GoSign = null;
			var rF:RocksFalling = null;
			var rW:Roadworks = null;
			var sB:SpeedBumps = null;
			var dG:Danger = null;
			var sD:SlowDown = null;
			trace("adding sign:"+symbolNames[i]+" int:"+i);
			//TODO extend to return the style for the correct sign
			var style:MarkerStyle = new MarkerStyle();
			style.icon = symbolNames[i];
			style.shadow = true;
			//style.iconStyle.offset = new Offset(18,18);
			return style;
		}
	}
}