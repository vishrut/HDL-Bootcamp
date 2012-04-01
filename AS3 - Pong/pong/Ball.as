package pong
{
	/**
	 * The ball the two paddles bounce back and forth
	 */
	public class Ball extends RectangularMovieClip
	{
		/** Velocity in the X direction */
		var vX:Number = 0;
		
		/** Velocity in the Y direction */
		var vY:Number = 0;
		
		/** Bouncers the ball collides with (type: Bouncer) */
		var bouncers:Array;
		
		function update():Number
		{
			// Update based on velocity
			this.x += vX;
			this.y += vY;
			
			if (this.x < Game.playArea.x+18)
			{
				return 1;
			}

			if (this.x >= Game.playArea.x + 507 - 7)
			{
				return 1;
			}
			
			// Check if we hit any of the bouncers. If we did, have it bounce us.
			for (var it:String in this.bouncers)
			{
				var bouncer:Bouncer = this.bouncers[it];
	
				// Check if we hit the current bouncer
				if (hitTestObject(bouncer))
				{
					// Bounce off the current bouncer and stop checking
					bouncer.bounce(this);
					
					if(bouncer is UserPaddle)
						return 0;
					else 
						return -1;
					//break;
				}
			}
			
			return -1;
		}
	}
}