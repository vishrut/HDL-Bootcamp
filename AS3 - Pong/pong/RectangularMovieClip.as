package pong
{
	import flash.display.MovieClip;
	
	public class RectangularMovieClip extends MovieClip
	{
	
		function setDimensions(width:Number, height:Number)
		{
			// Be a rectangle
			this.graphics.beginFill(0xffffff, 1.0);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
		}
	}
}