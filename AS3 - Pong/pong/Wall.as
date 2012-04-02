package pong
{
	/**
	 * A wall, which serves as a game boundary
	 */
	public class Wall extends RectangularMovieClip implements Bouncer
	{	
		public function bounce(ball:Ball):void
		{
			ball.vY = -ball.vY;
			ball.y += ball.vY;
		}
	}
}