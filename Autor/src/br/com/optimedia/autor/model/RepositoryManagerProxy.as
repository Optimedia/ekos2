package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.FileVO;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class RepositoryManagerProxy extends Proxy
	{
		public static const NAME:String = "RepositoryManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function RepositoryManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "autor.RepositoryManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		
		public function uploadFile(fileVO:FileVO):void {
			var asynkToken:AsyncToken = remoteService.uploadFile(fileVO);
			asynkToken.addResponder( new Responder(uploadFileResult, generalFault) );
		}
		private function uploadFileResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.FILE_UPLOAD_COMPLETE, event.result );
		}
	}
}