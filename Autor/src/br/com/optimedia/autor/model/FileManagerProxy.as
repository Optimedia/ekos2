package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.FileVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class FileManagerProxy extends Proxy
	{
		public static const NAME:String = "FileManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function FileManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "autor.FileManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function uploadPresentationFile(fileVO:FileVO, presentationID:uint, type:String):void {
			var asynkToken:AsyncToken = remoteService.uploadPresentationFile(fileVO, presentationID, type);
			asynkToken.addResponder( new Responder(uploadPresentationFileResult, generalFault) );
		}
		private function uploadPresentationFileResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.UPLOAD_PRESENTATION_FILE_RESULT, event.result );
		}
	}
}