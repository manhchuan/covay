package application.view
{
	import application.AFacade;
	import application.model.DataProxy;
	import application.view.components.Board;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BoardMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BoardMediator";
		
		private var data:DataProxy;
		
		public function BoardMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			data = facade.retrieveProxy( DataProxy.NAME) as DataProxy;
			
			board.soundState = data.soundState;
			board.addEventListener(Board.TILE_CLICK, onTileClick);
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array( AFacade.START_GAME,
							  AFacade.RESTART_GAME,
							  AFacade.AI_MOVE,
							  AFacade.GAME_OVER,
							  AFacade.DRAWN_GAME,
							  AFacade.SOUND_CHANGE );
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{
				case AFacade.START_GAME:
					board.setBoardEnabled(true);
					board.makeFirstMove();
					break;
					
				case AFacade.RESTART_GAME:
					board.setBoardEnabled(true);
					board.makeFirstMove();
					break;
				
				case AFacade.AI_MOVE:
					board.showAIMove( notification.getBody().x, notification.getBody().y);
					break;
				
				case AFacade.GAME_OVER:
					var y1:Number = notification.getBody().y1;
					var x1:Number = notification.getBody().x1;
					var y2:Number = notification.getBody().y2;
					var x2:Number = notification.getBody().x2;
					var tile:Number = notification.getBody().tile;
					
					board.drawWinLine(y1, x1, y2, x2, tile);
					board.setBoardEnabled(false);
					break;
				
				case AFacade.DRAWN_GAME:
					board.setBoardEnabled(false);
					break;
				
				case AFacade.SOUND_CHANGE:
					board.soundState = notification.getBody() as Boolean;
					break;
			}
		}
		
		protected function get board():Board
		{
			return viewComponent as Board;
		}
		
		private function onTileClick(event:Event):void
		{
			sendNotification(AFacade.USER_MOVE, board.tileCoordinate);
		}
	}
}