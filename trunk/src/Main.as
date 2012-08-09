package 
{
	import application.ApplicationFacade;
	import flash.display.Sprite;
	
	
	[SWF(bgColor = "#000000", frameRate = "32", width = "520", height = "630")]
	public class Main extends Sprite
	{
		private var facade:ApplicationFacade;
		public function Main()
		{
			facade = ApplicationFacade.getInstance();
			facade.sendNotification(ApplicationFacade.STARTUP, this);
		}
	}
}
