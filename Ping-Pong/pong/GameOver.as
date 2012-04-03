package pong
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	public class GameOver extends MovieClip
	{
		private var gameOver:TextField;
		
		private var format:TextFormat;
		
		function GameOver()
		{
			// Create the text field and go to the next score in the count
			this.gameOver = new TextField();
			this.gameOver.autoSize = TextFieldAutoSize.LEFT;
			addChild(this.gameOver);
			
			// Set up the format to use a big monospaced font
			this.format = new TextFormat();
			this.format.font = "ubuntu";
			this.format.size = 50;
			this.format.align = "center";
			this.format.color = 0xffffff;
		}
		
		function setMessage(msg:String):void
		{	
			this.gameOver.text = "Game Over\n" + "Score : "+msg;
			this.gameOver.setTextFormat(this.format);
		}
		
		function setBeginMessage(msg:String):void
		{	
			this.gameOver.text = msg;
			this.gameOver.setTextFormat(this.format);
		}
	}
}