package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.vo.PresentationVO;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class SlideManagerProxy extends Proxy
	{
		public static const NAME:String = "SlideManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function SlideManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "autor.SlideManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function getSubjects():void {
			//var asynkToken:AsyncToken = remoteService.getSubjects();
			//asynkToken.addResponder( new Responder(getSubjectsResult, generalFault) );
		}
		private function getSubjectsResult(event:ResultEvent):void {
			//sendNotification( NotificationConstants.GET_SUBJECTS_OK, event.result );
		}
	}
}