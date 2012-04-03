package  {
	
	public class ScoreBox {

		public function ScoreBox() {
			// constructor code
			//this.score = new TextField();
			this.score_txt.autoSize = TextFieldAutoSize.LEFT;
			//addChild(this.score);
			
			// Set up the format to use a big monospaced font
			this.format = new TextFormat();
			this.format.font = "ubuntu";
			this.format.size = 75;
			this.format.color = 0xffffff;
			setScore(0);
		}
								
		public function setScore(score1:Number):void
		{
			this.score_txt.setTextFormat(this.format);
			this.score_txt.text = String(score1);			
		}
		
		public function getScore():Number
		{
			var score = Number(this.score.text);
			return score;
		}

	}
	
}
