package  {
	
	import flash.display.MovieClip;
	
	public class AnswerBox extends MovieClip{

		public function AnswerBox() {
			this.x = 400;
			this.y = 300;
			
		}
		
		public function getAnswer():String {
			return answer_txt.text;
		}

	}
	
}
