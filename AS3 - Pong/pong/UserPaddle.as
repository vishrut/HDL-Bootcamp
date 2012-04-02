package pong
{
	import flash.events.MouseEvent;
	
	public class UserPaddle extends Paddle
	{
		
		function lockToMouse():void
		{
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
		}
		
		function unlockFromMouse():void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
		}
		
		/**
		 * Listener to mouse movements. Requests movement to sync with the mouse's Y.
		 * @param event The mouse move event
		 */
		function mouseMoveListener(event:MouseEvent)
		{
			requestMove(event.stageY-this.height/2);
		}
	}
}