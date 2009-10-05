package forum.model
{
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ForumServiceProxy extends Proxy
	{
		public static const NAME:String = "ForumServiceProxy";
		
		private var remoteAdminService:RemoteObject;
		
		public function ForumServiceProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "forum.ForumService";
			remoteService.addEventListener(FaultEvent.FAULT, generalFault);
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
	}
}