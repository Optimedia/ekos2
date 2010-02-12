package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.SubjectVO;
	import br.com.optimedia.autor.assets.vo.PresentationVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class SubjectManagerProxy extends Proxy
	{
		public static const NAME:String = "SubjectManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function SubjectManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "autor.SubjectManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function getModules():void {
			var asynkToken:AsyncToken = remoteService.getModules();
			asynkToken.addResponder( new Responder(getAllResult, generalFault) );
		}
		private function getModulesResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_MODULES_OK, event.result );
		}
		
		public function newModule(moduleVO:SubjectVO):void {
			var asynkToken:AsyncToken = remoteService.newModule(moduleVO);
			asynkToken.addResponder( new Responder(newModuleResult, generalFault) );
		}
		private function newModuleResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.NEW_SUBJECT_OK, event.result );
		}
		
		public function newTheme(themeVO:PresentationVO):void {
			var asynkToken:AsyncToken = remoteService.newModule(themeVO);
			asynkToken.addResponder( new Responder(newThemeResult, generalFault) );
		}
		private function newThemeResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.NEW_PRESENTATION_OK, event.result );
		}
	}
}