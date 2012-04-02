package pong
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Represents the match score
	 */
	public class Score extends MovieClip
	{
		private var score:TextField;
		
		private var format:TextFormat;
	
		function Score()
		{
			// Create the text field and go to the next score in the count
			this.score = new TextField();
			this.score.autoSize = TextFieldAutoSize.LEFT;
			addChild(this.score);
			
			// Set up the format to use a big monospaced font
			this.format = new TextFormat();
			this.format.font = "ubuntu";
			this.format.size = 75;
			this.format.color = 0xffffff;
	
			setScore(0);
		}
		
		function setScore(score1:Number):void
		{
			this.score.text = String(score1);
			this.score.setTextFormat(this.format);
		}
		
		function getScore():Number
		{
			var score = Number(this.score.text);
			return score;
		}
		
	}
}