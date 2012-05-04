package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class Ticker extends MovieClip {
		
		

		public function Ticker()  {
			this.x = 195;
			this.y = 250;
		}
		
		public function setticker(str:String){
			this.ticker_txt.text = str;
		}

	}
	
}
