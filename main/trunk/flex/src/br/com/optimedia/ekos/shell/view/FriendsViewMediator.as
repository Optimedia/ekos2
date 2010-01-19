package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;

	public class FriendsViewMediator extends Mediator
	{
		public static const NAME:String = 'FriendsViewMediator';
		
		private var friendManagerProxy:FriendManagerProxy;
		private var profileManagerProxy:ProfileManagerProxy;
		
		public function FriendsViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			
			friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
			profileManagerProxy = facade.retrieveProxy( ProfileManagerProxy.NAME ) as ProfileManagerProxy;
			
			//view.tileList.addEventListener( ChildExistenceChangedEvent.CHILD_REMOVE, disposeAvatarItem);
			
			view.searchTextInput.addEventListener(FlexEvent.ENTER, onSearchBtnClick);
			view.searchBtn.addEventListener(MouseEvent.CLICK, onSearchBtnClick);
			view.backToFriendsBtn.addEventListener(MouseEvent.CLICK, backToFriends);
			view.seeIgnoredBtn.addEventListener(MouseEvent.CLICK, seeIgnored);
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
					NotificationConstants.FIND_FRIEND_RESULT_ARRAY,
					NotificationConstants.REMOVE_FRIEND_OK,
					NotificationConstants.GET_ALL_IGNORES];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_ALL_FRIENDS_RESULT:
					view.usersArrayCollection = new ArrayCollection(note.getBody() as Array);
					break;
				case NotificationConstants.FIND_FRIEND_RESULT_ARRAY:
					view.usersArrayCollection = new ArrayCollection(note.getBody() as Array);
					break;
				case NotificationConstants.ADD_FRIEND_OK:
					Alert.show("Amigo adicionado com sucesso", "FINISH ME!");
					profileManagerProxy.getAllFriends();
					break;
				case NotificationConstants.REMOVE_FRIEND_OK:
					Alert.show("Amigo removido com sucesso", "FINISH ME!");
					profileManagerProxy.getAllFriends();
					break;
				case NotificationConstants.GET_ALL_IGNORES:
					view.usersArrayCollection = new ArrayCollection(note.getBody() as Array);
					break;
				case NotificationConstants.ADD_IGNORE_OK:
					Alert.show("O usuário foi ignorado com sucesso", "OK!");
					profileManagerProxy.getAllFriends();
					break;
				default:
					break;
			}
		}
		
		/* private function disposeAvatarItem(event:ChildExistenceChangedEvent):void {
			sendNotification( CommandConstants.DISPOSE_AVATAR_BOX, event.target);
		} */
		
		private function onSearchBtnClick(event:Event):void {
			view.usersArrayCollection = new ArrayCollection();
			view.backToFriendsBtn.visible = true;
			view.backToFriendsBtn.includeInLayout = true;
			view.seeIgnoredBtn.visible = false;
			view.seeIgnoredBtn.includeInLayout = false;
			view.avatarBoxCurrentState = AvatarBox.SEARCH_VIEW_STATE;
			friendManagerProxy.findFriend( view.searchTextInput.text );
		}
		
		private function backToFriends(event:MouseEvent):void {
			view.usersArrayCollection = new ArrayCollection();
			view.backToFriendsBtn.includeInLayout = false;
			view.backToFriendsBtn.visible = false;
			view.seeIgnoredBtn.visible = true;
			view.seeIgnoredBtn.includeInLayout = true;
			view.avatarBoxCurrentState = AvatarBox.FRIENDS_VIEW_STATE;
			profileManagerProxy.getAllFriends();
		}
		
		private function seeIgnored(event:MouseEvent):void {
			view.usersArrayCollection = new ArrayCollection();
			view.backToFriendsBtn.visible = true;
			view.backToFriendsBtn.includeInLayout = true;
			view.seeIgnoredBtn.visible = false;
			view.seeIgnoredBtn.includeInLayout = false;
			view.avatarBoxCurrentState = AvatarBox.IGNORE_VIEW_STATE;
			profileManagerProxy.getAllIgnores();
		}
	}
}