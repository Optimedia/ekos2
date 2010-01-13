package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

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
			
			//view.tileList.addEventListener( ChildExistenceChangedEvent.CHILD_REMOVE, disposeAvatarItem);
			
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
			return [NotificationConstants.ADD_FRIEND_OK,
					NotificationConstants.GET_ALL_FRIENDS_RESULT,
					NotificationConstants.FIND_FRIEND_RESULT_ARRAY];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_ALL_FRIENDS_RESULT:
					view.usersArrayCollection = note.getBody() as Array;
					break;
				case NotificationConstants.FIND_FRIEND_RESULT_ARRAY:
					view.usersArrayCollection = note.getBody() as Array;
					break;
				case NotificationConstants.ADD_FRIEND_OK:
					Alert.show("Amigo adicionado com sucesso", "FINISH ME!");
					break;
				default:
					break;
			}
		}
		
		/* private function disposeAvatarItem(event:ChildExistenceChangedEvent):void {
			sendNotification( CommandConstants.DISPOSE_AVATAR_BOX, event.target);
		} */
		
		private function onSearchBtnClick(event:Event):void {
			friendManagerProxy.findFriend( view.searchTextInput.text );
		}
	}
}