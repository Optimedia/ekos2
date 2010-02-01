package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.AppsTabNavigator;
	import br.com.optimedia.ekos.shell.view.component.EditProfile;
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	
	import mx.events.IndexChangedEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.ekos.shell.view.component.MailBoxView;
	import br.com.optimedia.ekos.shell.model.MessageManagerProxy;

	public class AppsTabNavigatorMediator extends Mediator
	{
		public static const NAME:String = 'AppsTabNavigatorMediator';
		
		//private var friendManagerProxy:FriendManagerProxy;
		private var profileManagerProxy:ProfileManagerProxy;
		private var messageManagerProxy:MessageManagerProxy;
		
		public function AppsTabNavigatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			//friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
			profileManagerProxy = facade.retrieveProxy( ProfileManagerProxy.NAME ) as ProfileManagerProxy;
			messageManagerProxy = facade.retrieveProxy( MessageManagerProxy.NAME ) as MessageManagerProxy;
			
			view.addEventListener(IndexChangedEvent.CHANGE, onSelectedItemChange);
		}
		
		override public function onRemove():void {
		}
		
		public function get view():AppsTabNavigator
		{
			return viewComponent as AppsTabNavigator;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				/* case NotificationConstants.GET_ALL_FRIENDS_RESULT:
					view.friendsView.usersArrayCollection = note.getBody() as Array;
					break; */
				/* case NotificationConstants.FIND_FRIEND_RESULT_ARRAY:
					view.friendsView.usersArrayCollection = note.getBody() as Array;
					break; */
				default:
					break;
			}
		}
		
		private function onSelectedItemChange(event:IndexChangedEvent):void {
			if(view.selectedChild is EditProfile) profileManagerProxy.getProfile();
			if(view.selectedChild is FriendsView) profileManagerProxy.getAllFriends();
			if(view.selectedChild is MailBoxView) messageManagerProxy.getAllMessages();
		}
		
		/* private function onSearchBtnClick(event:Event):void {
			friendManagerProxy.findFriend( view.friendsView.searchTextInput.text );
		} */
	}
}