package pong
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	public class MessageBox extends MovieClip
	{
		private var messageText:TextField;
		
		private var format:TextFormat;
		
		function MessageBox()
		{
			// Create the text field and go to the next score in the count
			this.messageText = new TextField();
			this.messageText.autoSize = TextFieldAutoSize.LEFT;
			addChild(this.messageText);
			
			// Set up the format to use a big monospaced font
			this.format = new TextFormat();
			this.format.font = "ubuntu";
			this.format.size = 50;
			this.format.align = "center";
			this.format.color = 0xffffff;
		}
		
		function setMessage(msg:String):void
		{	
			this.messageText.text = "Game Over\n" + "Score : "+msg;
			this.messageText.setTextFormat(this.format);
		}
		
		function setBeginMessage(msg:String):void
		{	
			this.messageText.text = msg;
			this.messageText.setTextFormat(this.format);
		}
	}
}