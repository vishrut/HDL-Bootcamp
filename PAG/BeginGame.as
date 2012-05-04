package{
	import flash.text.*;
	import flash.display.*;
  	import flash.events.*;
  	import flash.net.*;
  	import flash.errors.*;
	import flash.utils.*;
    import flash.ui.Keyboard;	
  	import ButtonsClass;
	import FactBox;
	import AnswerBox;
	import Ticker;
	import GameStrings;
	
	
	public class BeginGame extends Sprite{
		
		var myStage:Stage;//Receiving the reference to the stage from Main class, storing it in myStage
		
		var level_num:Number = 1; //Current level
		var question_num:Number = 0; //Current question number, 0 implies the first question
		var maxQuestions:Number; // Maximum number of questions in the level
		var count:Number = 5;//For displaying the timer
		
		var myTimer:Timer; //Countdown timer
		
		var levelData:XML = new XML(); //levelData stores the complete XML level file
		
		var lastAnswer:String; //Storing the answer to the last question
		
		var ansIsCorrect:Boolean = false; //Whether the last answer was correct or not
		var timerON:Boolean = false; //Checks if the timer has any listener added
		
		var btn:ButtonsClass; //Creating a button from a custom class
		var timerCount:TimerCount; //Custom class for controlling our timer 
		var factBox:FactBox; //MovieClip, displays the facts
		var ansBox:AnswerBox;  //MovieClip, for typing in the answer
		var ticker:Ticker; //MovieClip, shows if the answer submitted was correct or not
		var logger:LoggerClass = new LoggerClass;
		
		public function BeginGame(_stage:Stage){
			
			myStage = _stage;
			
			//Adding all the children to the stage
			ticker = new Ticker();
			addChild(ticker);
			
			factBox = new FactBox();
			addChild(factBox);
			
			ansBox = new AnswerBox();
			addChild(ansBox);
			
			timerCount = new TimerCount();
			addChild(timerCount);
			
			btn = new ButtonsClass();
			addChild(btn);
			//Completed adding children
			
			btn.addEventListener(MouseEvent.CLICK, displayFacts);
			
			//Visibility of the MovieClips
			factBox.visible = false;
			ansBox.visible = false;
			timerCount.visible = false;
			ticker.visible = false;
			
			addKeyboard();//This function enables keyboard control	
		}
		
		//Enables keyboard control
		private function addKeyboard():void{
			trace("keyboard added");
			myStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);			
		}
		
		//Dispatches MouseClick to btn whenever ENTER key is pressed
		public function keyPressedDown(event:KeyboardEvent):void {
			if((event.keyCode == Keyboard.ENTER) && btn.visible==true)
      		btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));      			
    	}
		
		//Removes event listener from myTimer
		private function removeTimer(){
			if (timerON == true)
			myTimer.removeEventListener(TimerEvent.TIMER, timeOut);
			timerON = false;
		}

		//When the timer runs out
		function timeOut(event:TimerEvent):void {
			if(count==1){
				trace("timeOut() called @ " + getTimer() + " ms");
				trace("timeout");
				timerCount.setCounter(0);
				removeTimer();
				btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));  
			}
			else{
				count -= 1;
				timerCount.setCounter(count);
			}
		}
		
		//To dislpay the facts 
		private function displayFacts(e:MouseEvent):void{
			ticker.visible = false;
			timerCount.visible = false;
			fileLoader(); //Loads XML file and displays questions in the factBox
			removeTimer();
			btn.toStartBtn();
			btn.removeEventListener(MouseEvent.CLICK, displayFacts);
			btn.addEventListener(MouseEvent.CLICK, askQuestion);
		}
		
		//Checks if the submitted answer is correct or not 
		private function submitAnswer(e:MouseEvent){
			ansBox.visible = false;
			removeTimer();
			checkAnswer();
			trace("submitted");
		}
		
		//Answer checking
		private function checkAnswer(){
			ansBox.visible = false;			
			count = 5;
			
			if(levelData.facts.fact.answer[question_num - 1] == ansBox.getAnswer()){
				trace("Correct");
				logger.hits += 1;
				trace(logger.hits);
				ticker.setticker("Perfect!");
				ticker.visible = true;
				ansIsCorrect = true;
				nextQuestion();
			}
			
			else{
				ansIsCorrect = false;
				ticker.visible = true;
				lastAnswer = ansBox.getAnswer();
				ticker.setticker("Incorrect");
				factBox.setFact(levelData.facts.fact.question[question_num - 1]+" = "+levelData.facts.fact.answer[question_num - 1]);
				factBox.addFact("Your Answer : "+lastAnswer);
				btn.toNextBtn();
				btn.removeEventListener(MouseEvent.CLICK, submitAnswer);
				btn.addEventListener(MouseEvent.CLICK, askQuestion);
				removeTimer();
				startTimer(3);
			}
			
			ansBox.answer_txt.text = "";
		}
		
		//Provides XMLLoader with the file name to load
		private function fileLoader(){
			factBox.visible = true;
			ansBox.visible = false;
			
			var lString = "level" + level_num + ".xml";
			
			XMLLoader(lString);			
		}
		
		//Accepts file name as a String and loads it
		private function XMLLoader( request:String ) {
			var loader:URLLoader = new URLLoader(  );
      		loader.addEventListener( Event.COMPLETE, handleComplete );
			loader.addEventListener(IOErrorEvent.IO_ERROR, handleIOError );
    		loader.load( new URLRequest( request ) );
		}
		
		//IO error handling during file loading
		private function handleIOError( e:Event){
			btn.visible = false;
			removeTimer();
			factBox.setFact(GameStrings.ENDGame);
			trace("completed all levels or xml files missing");
		}
		
		//Supplies factBox with the facts
		private function handleComplete( event:Event ):void {
			levelData = new XML(event.target.data);	
			maxQuestions = levelData.maxQ;
		    question_num = 0;
			var factList:XMLList = levelData.facts.fact;
			var qString:String = new String();
			 
			for each ( var factElement:XML in factList) {			
				qString = qString + factElement.question + " = " + factElement.answer + "\n";
			}
			
			factBox.setFact(qString);
			trace(qString);
		 }
		 		 
		 private function askQuestion(e:Event):void{			
			nextQuestion();
		 }
		 
		 //Starts timer for sec seconds
		 private function startTimer(sec:Number):void{
			 
			 if(timerON == true)
			    myTimer.removeEventListener(TimerEvent.TIMER, timeOut);
			 
			 count = sec;
			 timerCount.visible = true;
			 timerCount.setCounter(sec);
			 myTimer = new Timer(1000, sec);
			 myTimer.addEventListener(TimerEvent.TIMER, timeOut);
			 myTimer.start();
			 timerON = true;				
		 }
		 
		 //Asks the next question in the level
		 private function nextQuestion(){
			 if(ansIsCorrect == false)
			 	ticker.visible = false;
			
			 timerCount.visible = true; 
			 ansBox.visible = true;
			 myStage.focus = ansBox.answer_txt;
			 btn.toSubmitBtn();
			 btn.removeEventListener(MouseEvent.CLICK, askQuestion);
			 btn.addEventListener(MouseEvent.CLICK, submitAnswer);
			 			 
			 if (question_num < maxQuestions){
				startTimer(5);
			 	factBox.setFact(levelData.facts.fact.question.text()[question_num]);
				question_num += 1;
			 }
			 
			 else{
				removeTimer(); 
				level_num += 1;
				timerCount.visible = false;
				factBox.visible = true;
				factBox.setFact("New Level");
				ansBox.visible = false;
				btn.toBeginBtn();
				btn.removeEventListener(MouseEvent.CLICK, askQuestion);
				btn.addEventListener(MouseEvent.CLICK, displayFacts);
			 }
		}
	}	
}



