package forum.view
{
	import assets.vo.ForumVO;
	import assets.vo.RoomVO;
	import assets.vo.TopicVO;
	
	import flash.events.Event;
	
	import forum.model.ForumProxy;
	import forum.view.component.MainView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MainViewMediator extends Mediator
	{
		public static const NAME:String = 'MainViewMediator';
		
		private var forumProxy:ForumProxy = new ForumProxy();
		
		public function MainViewMediator(viewComponent:MainView=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			forumProxy = facade.retrieveProxy(ForumProxy.NAME) as ForumProxy;
			forumProxy.retrieveCategories();
			
			view.addEventListener(MainView.FORUM_SELECTED_EVENT, onForumSelectedEvent);
			view.addEventListener(MainView.ROOM_SELECTED_EVENT, onRoomSelectedEvent);
			view.addEventListener(MainView.TOPIC_SELECTED_EVENT, onTopicSelectedEvent);
		}
		
		public function get view():MainView
		{
			return viewComponent as MainView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ForumProxy.CATEGORIES_LIST_NOTIFICATION,
					ForumProxy.ROOMS_LIST_NOTIFICATION,
					ForumProxy.TOPICS_LIST_NOTIFICATION,
					ForumProxy.POST_LIST_NOTIFICATION];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ForumProxy.CATEGORIES_LIST_NOTIFICATION:
					view.forumListDataProvider = note.getBody();
					break;
				case ForumProxy.ROOMS_LIST_NOTIFICATION:
					view.roomListDataProvider = note.getBody();
					break;
				case ForumProxy.TOPICS_LIST_NOTIFICATION:
					view.topicListDataProvider = note.getBody();
					break;
				case ForumProxy.POST_LIST_NOTIFICATION:
					view.postListDataProvider = note.getBody();
					break;
				default:
					break;
			}
		}
		
		private function onForumSelectedEvent(event:Event):void {
			forumProxy.retrieveRooms(view.selectedForum as ForumVO);
		}
		
		private function onRoomSelectedEvent(event:Event):void {
			forumProxy.retrieveTopics(view.selectedRoom as RoomVO);
		}
		
		private function onTopicSelectedEvent(event:Event):void {
			forumProxy.retrievePosts(view.selectedTopic as TopicVO);
		}
	}
}