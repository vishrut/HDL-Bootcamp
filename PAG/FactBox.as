package  {
	
	import flash.display.MovieClip;
	import flash.sampler.Sample;
	
	public class FactBox extends MovieClip{

		public function FactBox() {
			this.x = 90;
			this.y = 50;
		}
		
		public function setFact(str:String){
			this.fact_txt.text = str;
		}
		
		public function addFact(str:String){
			this.fact_txt.text = this.fact_txt.text + "\n" + str;
		}

	}
	
}
