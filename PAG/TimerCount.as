package  {
	
	import flash.display.MovieClip;
	
	public class TimerCount extends MovieClip {

		public function TimerCount() {
			setCounter(5);
		}
		
		public function setCounter(num:Number){
			this.counter.text = num.toString();
		}

	}
	
}
