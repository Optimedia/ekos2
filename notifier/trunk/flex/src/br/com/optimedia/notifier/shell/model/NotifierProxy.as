package br.com.optimedia.notifier.shell.model
{
	import br.com.optimedia.assets.vo.NotifierVO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class NotifierProxy extends Proxy
	{
		public static const NAME:String = "NotifierProxy";
		public static const RETRIEVENOTIFIER_RESULT:String = "RETRIEVENOTIFIER_RESULT";
		public static const SAVE_NOTIFIER_RESULT:String = "SAVE_NOTIFIER_RESULT"; 
		public static const SAVE_NOTIFIER_FAULT:String = "SAVE_NOTIFIER_FAULT";
		public static const GET_LOCALE_RESULT:String = "GET_LOCALE_RESULT";
		public static const DELETE_NOTIFIER_FAULT:String = "DELETE_NOTIFIER_FAULT";
		public static const DELETE_NOTIFIER_RESULT:String = "DELETE_NOTIFIER_RESULT";
		
		
		private var notifierVO:NotifierVO;
		
		private var remoteAdminService:RemoteObject;
		
		public function NotifierProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			remoteAdminService = new RemoteObject();
			remoteAdminService.destination = "amfphp";
			remoteAdminService.source = "notifier.NotifierService";
		}
		
		public function deleteNotifier(notifierVO:NotifierVO):void {
			var asyncToken:AsyncToken = remoteAdminService.deleteNotifier(notifierVO);			
			asyncToken.addResponder(new Responder(deleteNotifierResult, deleteNotifierFault));			
		}
		private function deleteNotifierResult(event:ResultEvent):void
		{
			if(event.result == true) sendNotification(DELETE_NOTIFIER_RESULT, event.result);
		}
		private function deleteNotifierFault(event:FaultEvent):void
		{
			trace(NAME+".deleteNotifierFault()");
			sendNotification(DELETE_NOTIFIER_FAULT, event.fault);
		}
		
		public function retrieveNotifier():void
		{
			var asyncToken:AsyncToken = remoteAdminService.retrieveNotifier();			
			asyncToken.addResponder(new Responder(retrieveNotifierResult, retrieveNotifierFault));
		}
		private function retrieveNotifierResult(event:ResultEvent):void
		{
			sendNotification(RETRIEVENOTIFIER_RESULT, event.result);
		}
		private function retrieveNotifierFault(event:FaultEvent):void
		{
			trace(NAME+".retrieveNotifierFault()");
		}
		
		public function saveNotifier(notifierVO:NotifierVO):void 
		{
			var asyncToken:AsyncToken = remoteAdminService.saveNotifier(notifierVO);			
			asyncToken.addResponder(new Responder(saveNotifierResult, saveNotifierFault));			
		}
		private function saveNotifierResult(event:ResultEvent):void
		{
			if(event.result == true) sendNotification(SAVE_NOTIFIER_RESULT, event.result);
		}
		private function saveNotifierFault(event:FaultEvent):void
		{
			trace(NAME+".saveNotifierFault()");
			sendNotification(SAVE_NOTIFIER_FAULT, event.fault);
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