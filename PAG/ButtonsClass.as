package  {
	
	import flash.display.MovieClip;
	
	public class ButtonsClass extends MovieClip{

		public function ButtonsClass() {			
			this.x = 200;
			this.y = 300;
			stop();
		}
		
		public function toBeginBtn(){
			gotoAndStop(1);
		}
		
		public function toStartBtn(){
			gotoAndStop(2);
		}
		
		public function toSubmitBtn(){
			gotoAndStop(3);
		}
		
		public function toNextBtn(){
			gotoAndStop(4);
		}

	}
	
}
