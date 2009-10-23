package shell.model
{
	import assets.vo.BookmarkVO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class BookmarkProxy extends Proxy
	{
		public static const NAME:String = "BookmarkProxy";
		public static const RETRIEVEBOOKMARK_RESULT:String = "RETRIEVEBOOKMARK_RESULT";
		public static const SAVE_BOOKMARK_RESULT:String = "SAVE_BOOKMARK_RESULT"; 
		public static const SAVE_BOOKMARK_FAULT:String = "SAVE_BOOKMARK_FAULT";
		public static const DELETE_BOOKMARK_RESULT:String = "DELETE_BOOKMARK_RESULT"; 
		public static const DELETE_BOOKMARK_FAULT:String = "DELETE_BOOKMARK_FAULT";
		public static const GET_LOCALE_RESULT:String = "GET_LOCALE_RESULT";
		
		
		private var bookmarkVO:BookmarkVO;
		
		private var remoteAdminService:RemoteObject;
		
		public function BookmarkProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			remoteAdminService = new RemoteObject();
			remoteAdminService.destination = "amfphp";
			remoteAdminService.source = "bookmark.BookmarkService";
		}
		
		public function retrieveBookmark():void
		{
			var asyncToken:AsyncToken = remoteAdminService.retrieveBookmark();			
			asyncToken.addResponder(new Responder(retrieveBookmarkResult, retrieveBookmarkFault));
		}
		private function retrieveBookmarkResult(event:ResultEvent):void
		{
			sendNotification(RETRIEVEBOOKMARK_RESULT, event.result);
		}
		private function retrieveBookmarkFault(event:FaultEvent):void
		{
			trace(NAME+".retrieveBookmarkFault()");
		}
		
		public function saveBookmark(bookmarkVO:BookmarkVO):void 
		{
			var asyncToken:AsyncToken = remoteAdminService.saveBookmark(bookmarkVO);			
			asyncToken.addResponder(new Responder(saveBookmarkResult, saveBookmarkFault));			
		}
		private function saveBookmarkResult(event:ResultEvent):void
		{
			if(event.result == true) sendNotification(SAVE_BOOKMARK_RESULT, event.result);
		}
		private function saveBookmarkFault(event:FaultEvent):void
		{
			trace(NAME+".saveBookmarkFault()");
			sendNotification(SAVE_BOOKMARK_FAULT, event.fault);
		}
		
		public function deleteBookmark(bookmarkVO:BookmarkVO):void {
			var asyncToken:AsyncToken = remoteAdminService.deleteBookmark(bookmarkVO);			
			asyncToken.addResponder(new Responder(deleteBookmarkResult, deleteBookmarkFault));			
		}
		private function deleteBookmarkResult(event:ResultEvent):void
		{
			if(event.result == true) sendNotification(DELETE_BOOKMARK_RESULT, event.result);
		}
		private function deleteBookmarkFault(event:FaultEvent):void
		{
			trace(NAME+".deleteBookmarkFault()");
			sendNotification(DELETE_BOOKMARK_FAULT, event.fault);
		}
		
		public function getLocale(localePath:String='pt_BR/bkm.xml'):void {
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onURLLoaderComplete);
			urlLoader.load( new URLRequest('locale/'+localePath) );
			
			function onURLLoaderComplete(event:Event):void {
				trace(NAME+".onURLLoaderComplete() = "+event.target.data);
				sendNotification(GET_LOCALE_RESULT, event.target.data);
			}
		}
	}
}