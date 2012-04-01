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
		/** The text field displaying the score */
		private var score:TextField;
		
		/** Format of the text field */
		private var format:TextFormat;
	
		/**
		 * Constructor. Creates a text field and sets it up with the default score of
		 * zero versus zero.
		 */
		function Score()
		{
			// Create the text field and go to the next score in the count
			this.score = new TextField();
			this.score.autoSize = TextFieldAutoSize.LEFT;
			addChild(this.score);
			
			// Set up the format to use a big monospaced font
			this.format = new TextFormat();
			this.format.font = "_typewriter";
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