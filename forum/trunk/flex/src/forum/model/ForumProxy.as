package forum.model
{
	import assets.vo.CategoryVO;
	import assets.vo.ForumVO;
	import assets.vo.PostVO;
	import assets.vo.RoomVO;
	import assets.vo.TopicVO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ForumProxy extends Proxy
	{
		public static const NAME:String = "ForumProxy";
		
		public static const CATEGORIES_LIST_NOTIFICATION:String = "CATEGORIES_LIST_NOTIFICATION";
		public static const SAVE_CATEGORY_OK_NOTIFICATION:String = "SAVE_CATEGORY_OK_NOTIFICATION";
		public static const ROOMS_LIST_NOTIFICATION:String = "ROOMS_LIST_NOTIFICATION";
		public static const TOPICS_LIST_NOTIFICATION:String = "TOPICS_LIST_NOTIFICATION";
		public static const POST_LIST_NOTIFICATION:String = "POST_LIST_NOTIFICATION";
		public static const GET_LOCALE_RESULT:String = "GET_LOCALE_RESULT";
		
		private var remoteService:RemoteObject;
		
		// NECESSÁRIO DECLARAR ESTAS VARIÁVEIS APENAS PARA Q O FLEX COMPILE OS VOs
		// REMOVER QUANDO O CÓDIGO ESTIVER COMPLETO 
		private var postVO:PostVO;
		
		
		public function ForumProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "forum.ForumService";
			remoteService.showBusyCursor = true;
			remoteService.addEventListener(FaultEvent.FAULT, generalFault);
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function retrieveCategories():void {
			var asynkToken:AsyncToken = remoteService.retrieveCategories();
			asynkToken.addResponder( new Responder(retrieveCategoriesResult, generalFault) );
		}
		private function retrieveCategoriesResult(event:ResultEvent):void {
			trace(NAME+".retrieveCategoriesResult() = "+event.result);
			sendNotification(CATEGORIES_LIST_NOTIFICATION, event.result);
		}
		
		public function saveCategory(categoryVO:CategoryVO):void {
			var asynkToken:AsyncToken = remoteService.saveCategory(categoryVO);
			asynkToken.addResponder( new Responder(saveCategoryResult, generalFault) );
		}
		private function saveCategoryResult(event:ResultEvent):void {
			trace(NAME+".saveCategoryResult() = "+event.result);
			sendNotification(SAVE_CATEGORY_OK_NOTIFICATION);
		}
		
		public function retrieveRooms(forumVO:ForumVO):void {
			var asynkToken:AsyncToken = remoteService.retrieveRooms(forumVO);
			asynkToken.addResponder( new Responder(retrieveRoomsResult, generalFault) );
		}
		private function retrieveRoomsResult(event:ResultEvent):void {
			trace(NAME+".retrieveRoomsResult() = "+event.result);
			sendNotification(ROOMS_LIST_NOTIFICATION, event.result);
		}
		
		public function retrieveTopics(roomVO:RoomVO):void {
			var asynkToken:AsyncToken = remoteService.retrieveTopics(roomVO);
			asynkToken.addResponder( new Responder(retrieveTopicsResult, generalFault) );
		}
		private function retrieveTopicsResult(event:ResultEvent):void {
			trace(NAME+".retrieveTopicsResult() = "+event.result);
			sendNotification(TOPICS_LIST_NOTIFICATION, event.result);
		}
		
		public function retrievePosts(topicVO:TopicVO):void {
			var asynkToken:AsyncToken = remoteService.retrievePosts(topicVO);
			asynkToken.addResponder( new Responder(retrievePostsResult, generalFault) );
		}
		private function retrievePostsResult(event:ResultEvent):void {
			trace(NAME+".retrievePostsResult() = "+event.result);
			sendNotification(POST_LIST_NOTIFICATION, event.result);
		}
		
		private var lng:XML = new XML();
		
		public function getLng():XML {
			return lng;
		}
		
		public function getLocale(localePath:String='pt_BR/forum.xml'):void {
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onURLLoaderComplete);
			urlLoader.load( new URLRequest('locale/'+localePath) );
			
			function onURLLoaderComplete(event:Event):void {
				trace(NAME+".onURLLoaderComplete() = "+event.target.data);
				lng = new XML(event.target.data);
				sendNotification(GET_LOCALE_RESULT, event.target.data);
			}
		}
	}
}