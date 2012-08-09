package 
{
	import application.AFacade;
	import flash.display.Sprite;
	
	
	[SWF(bgColor = "#000000", frameRate = "32", width = "520", height = "630")]
	public class Main extends Sprite
	{
		private var facade:AFacade;
		public function Main()
		{
			facade = AFacade.getInstance();
			facade.sendNotification(AFacade.STARTUP, this);
		}
	}
}
