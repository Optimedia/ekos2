package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import flash.events.Event;

	public class FriendsViewMediator extends Mediator
	{
		public static const NAME:String = 'FriendsViewMediator';
		
		private var friendManagerProxy:FriendManagerProxy;
		
		public function FriendsViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			
			friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
			
			view.searchTextInput.addEventListener(FlexEvent.ENTER, onSearchBtnClick);
			view.searchBtn.addEventListener(MouseEvent.CLICK, onSearchBtnClick);
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():FriendsView
		{
			return viewComponent as FriendsView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				default:
					break;
			}
		}
		
		private function onSearchBtnClick(event:Event):void {
			friendManagerProxy.findFriend( view.searchTextInput.text );
		}
	}
}