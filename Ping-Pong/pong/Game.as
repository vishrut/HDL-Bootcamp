﻿//Issues:
//1.Resizing
//2.Hitting the paddle breadthwise
//3.Hard-coded dimensions

package pong
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;


	
	public class Game extends MovieClip
	{
		/** Game over display */
		private var messageBox:MessageBox = new MessageBox();
		
		/** Score of the game */
		private var scores:Score = new Score();
		
		/** The user's paddle */
		private var userPaddle:UserPaddle = new UserPaddle();
		
		/** The user's 2nd paddle */
		private var userPaddle2:UserPaddle = new UserPaddle();
		
		/** The ball the players bounce back and forth */
		private var ball:Ball = new Ball();
		
		/** The top wall of the play area */
		private var wallTop:Wall = new Wall();
		
		/** The bottom wall of the play area */
		private var wallBottom:Wall = new Wall();
		
		private var prevStageWidth:Number;
		private var prevStageHeight:Number;		
		
		public static var isPaused:Boolean = false;
		
		function Game()
		{
			gameMethod();
		}
		
		private function gameMethod():void{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;	// We don't want stage to scale by itself
			this.stage.align = StageAlign.TOP_LEFT;			
			// The height of a wall
			var wallHeight:Number = 20;
			
			// Define the play area
			
			// Setup the graphical elements on the stage
			this.ball.setDimensions(20, 20);
			this.wallTop.setDimensions(this.stage.stageWidth, wallHeight);
			this.wallBottom.setDimensions(this.stage.stageWidth, wallHeight);
			//this.wallTop.x = 0;
			this.wallTop.y = 0;
			this.userPaddle.setDimensions(15, 75);
			this.userPaddle2.setDimensions(15, 75);
			this.wallBottom.y = this.stage.stageHeight - this.wallBottom.height;
			this.scores.y = this.wallTop.y + this.wallTop.height;
			this.scores.x = this.stage.stageWidth/2;
			//trace(this.scores.x);
			this.userPaddle.x = this.userPaddle.width;
			this.userPaddle.y = this.stage.stageHeight/2;
			this.userPaddle2.x = this.stage.stageWidth-2*this.userPaddle2.width;
			this.userPaddle2.y = this.stage.stageHeight/2;
			//trace(this.messageBox.width/2);

			addChild(this.scores);
			addChild(this.messageBox);
			addChild(this.userPaddle2);
			addChild(this.ball);
			addChild(this.userPaddle);
			addChild(this.wallTop);
			addChild(this.wallBottom);
			
			Paddle.topBound = this.wallTop.y + this.wallTop.height;
			Paddle.bottomBound = this.wallBottom.y - this.userPaddle.height;
			
			// Set up the ball to bounce off the paddles and walls
			this.ball.bouncers = [
				this.userPaddle,
				this.userPaddle2,
				this.wallTop,
				this.wallBottom
			];
			// Reset the game to initialize it
			reset(true);
			pauseGame("Click to Start");
			
			// Lock the player's paddle to the mouse to give them control
			this.userPaddle.lockToMouse();
			this.userPaddle2.lockToMouse();
			
			prevStageWidth = this.stage.stageWidth;
			prevStageHeight = this.stage.stageHeight;
			
						
			// Update the game every time a frame is played
			addEventListener(Event.ENTER_FRAME, update);	
			stage.addEventListener(Event.RESIZE, resizeStage);
		}
		
		private function resizeStage(e:Event):void{
			//gameMethod();
			// The height of a wall
			//isPaused = true;
			trace(this.ball.x);
			this.ball.x = this.ball.x*(this.stage.stageWidth/prevStageWidth);
			trace(this.ball.x);
			this.ball.y = this.ball.y*(this.stage.stageHeight/prevStageHeight);
			//isPaused = false;
			
			
			var wallHeight:Number = 20;
			// Define the play area
			
			// Setup the graphical elements on the stage
			//this.ball.setDimensions(20, 20);
			this.wallTop.setDimensions(this.stage.stageWidth, wallHeight);
			this.wallBottom.setDimensions(this.stage.stageWidth, wallHeight);
			//this.wallTop.x = 0;
			//this.wallTop.y = 0;
			//this.userPaddle.setDimensions(15, 75);
			//this.userPaddle2.setDimensions(15, 75);
			this.wallBottom.y = this.stage.stageHeight - this.wallBottom.height;
			this.scores.y = this.wallTop.y + this.wallTop.height;
			this.scores.x = this.stage.stageWidth/2;
			//trace(this.scores.x);
			this.userPaddle.x = this.userPaddle.width;
			this.userPaddle.y = this.stage.stageHeight/2;
			this.userPaddle2.x = this.stage.stageWidth-2*this.userPaddle2.width;
			this.userPaddle2.y = this.stage.stageHeight/2;
			Paddle.topBound = this.wallTop.y + this.wallTop.height;
			Paddle.bottomBound = this.wallBottom.y - this.userPaddle.height;
			//pauseGame("Game Paused");
			if(messageBox.visible){
				
			this.messageBox.x = this.stage.stageWidth/2-this.messageBox.width/2;
			this.messageBox.y = this.stage.stageHeight/2-this.messageBox.height/2;
			}
			
		}
		
		/**
		 * Reset the game. The game should be initialized first.
		 * @param clearScores If scores should be cleared as well
		 */
		private function reset(clearScores:Boolean):void
		{
			// Hide the game over
			this.messageBox.visible = false;

			// Set the ball's initial position to be the center of the stage
			this.ball.x = (this.stage.stageWidth - this.ball.width)/2;
			this.ball.y = (this.stage.stageHeight - this.ball.height)/2;
			
			// Serve the ball by giving it a random initial velocity
			this.ball.vX = (Math.random() % 2 == 0 ? 1 : -1) * 10;
			//trace(Math.random());
			this.ball.vY = Math.random() % 5;
			//trace(this.ball.vY);
			// Reset the scores
			if (clearScores)
			{
				setGameScore(0);
			}
		}
	
		private function endGame(msg:String):void
		{
			// Show the requested message
			
			this.messageBox.setMessage(msg);
			this.messageBox.x = this.stage.stageWidth/2-this.messageBox.width/2;
			this.messageBox.y = this.stage.stageHeight/2-this.messageBox.height/2;
			
			this.messageBox.visible = true;
			this.ball.visible = false;
			
			// Stop allowing the player to control the paddle
			this.userPaddle.unlockFromMouse();
			this.userPaddle2.unlockFromMouse();
						
			// Stop the ball
			this.ball.vX = this.ball.vY = 0;
			
			// Listen for the user pressing the mouse. When they do, reset and play agplayer2n
			this.stage.addEventListener(MouseEvent.CLICK, gameOverMouseListener);
			
			// Wait for the user to press the mouse
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function pauseGame(msg:String):void
		{
			// Show the requested message
			
			this.messageBox.setBeginMessage(msg);
			this.messageBox.x = this.stage.stageWidth/2-this.messageBox.width/2;
			this.messageBox.y = this.stage.stageHeight/2-this.messageBox.height/2;
			
			this.messageBox.visible = true;
			this.ball.visible = false;
			
			// Stop allowing the player to control the paddle
			this.userPaddle.unlockFromMouse();
			this.userPaddle2.unlockFromMouse();
						
			// Stop the ball
			this.ball.vX = this.ball.vY = 0;
			
			// Listen for the user pressing the mouse. When they do, reset and play agplayer2n
			this.stage.addEventListener(MouseEvent.CLICK, gameOverMouseListener);
			
			// Wait for the user to press the mouse
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		
		
		/**
		 * Listen for mouse clicks on the game over screen
		 * @param event Mouse click event to respond to
		 */
		private function gameOverMouseListener(event:MouseEvent):void
		{
			// Reset the game and stop listening for the user to do so again
			reset(true);
			this.ball.visible = true;
			this.stage.removeEventListener(MouseEvent.CLICK, gameOverMouseListener);

			this.userPaddle.lockToMouse();
			this.userPaddle2.lockToMouse();
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Update the game
		 * @param event Event we are updating for
		 */
		private function update(event:Event):void
		{
			
			// Update the ball's movement and check for the game over condition
			var winnerIndex:Number = this.ball.update();
			switch (winnerIndex)
			{
				case 0:
					setGameScore(scores.getScore()+1);
					break;
				case 1:
					reset(false);
					endGame(String(scores.getScore()));					
					break;
			}
			
			// If the game is not over, keep running the game by going to our own frame
			// to form the main loop
			gotoAndPlay(1);
		}
		
		private function setGameScore(player:Number)
		{
			this.scores.setScore(player);
			this.scores.x = (this.stage.stageWidth - this.scores.width) / 2;
		}
	}
}