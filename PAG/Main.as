package  {
	
	import flash.display.Sprite;
	import BeginGame;
	
	public class Main extends Sprite{
		
		var beginGame:BeginGame;
		
		public function Main() {						
			beginGame = new BeginGame(stage);
			addChild(beginGame);			
		}
	}	
}
