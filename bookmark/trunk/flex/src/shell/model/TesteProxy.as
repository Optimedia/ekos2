package shell.model
{
	import mx.rpc.remoting.RemoteObject;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	import shell.view.TesteMediator;

	public class TesteProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "TesteProxy";
		
		private var remoteAdminService:RemoteObject;
		
		public function TesteProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			remoteAdminService = new RemoteObject();
			remoteAdminService.destination = "amfphp";
			remoteAdminService.source = "ida.AdminService";
		}
		
		public function getDados(id:String):void {
			//remoteAdminService.getDados(id);
			sendNotification(TesteMediator.GET_DADOS_OK, id);
		}
	}
}