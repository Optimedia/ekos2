package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.MainAppFacade;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.AppsTabNavigator;
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AppsTabNavigatorMediator extends Mediator
	{
		public static const NAME:String = 'AppsTabNavigatorMediator';
		
		private var friendManagerProxy:FriendManagerProxy;
		
		public function AppsTabNavigatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
			
			view.addEventListener(IndexChangedEvent.CHANGE, onSelectedItemChange);
			
			view.friendsView.searchTextInput.addEventListener(FlexEvent.ENTER, onSearchBtnClick);
			view.friendsView.searchBtn.addEventListener(MouseEvent.CLICK, onSearchBtnClick);
		}
		
		override public function onRemove():void {
		}
		
		public function get view():AppsTabNavigator
		{
			return viewComponent as AppsTabNavigator;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.FIND_FRIEND_RESULT_ARRAY];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.FIND_FRIEND_RESULT_ARRAY:
					//var teste:Object = note.getBody();
					view.friendsView.usersArrayCollection = note.getBody() as Array;
					break;
				default:
					break;
			}
		}
		
		private function onSelectedItemChange(event:IndexChangedEvent):void {
			if(view.selectedChild is FriendsView) friendManagerProxy.getAllFriends( MainAppFacade(facade).myCompleteUserVO.account_id );
		}
		
		private function onSearchBtnClick(event:Event):void {
			friendManagerProxy.findFriend( view.friendsView.searchTextInput.text );
		}
	}
}