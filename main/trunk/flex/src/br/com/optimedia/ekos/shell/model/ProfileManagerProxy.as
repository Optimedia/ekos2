package br.com.optimedia.ekos.shell.model
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.generalcomponents.FaultHandler;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.assets.vo.FileVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ProfileManagerProxy extends Proxy
	{
		public static const NAME:String = "ProfileManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function ProfileManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.ProfileManager";
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
			sendNotification( NotificationConstants.AVATAR_UPLOAD_COMPLETE, event.result );
		}
		
	}
}