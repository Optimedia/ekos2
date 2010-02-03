package br.com.optimedia.ekos.contentcontainer.view
{
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ContentContainerMediator extends Mediator
	{
		public static const NAME:String = 'ContentContainerMediator';
		
		//private var friendManagerProxy:FriendManagerProxy;
		
		public function ContentContainerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			//friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
			
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():ContentContainer
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
	}
}