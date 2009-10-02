package shell.view
{
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class TesteMediator extends Mediator
	{
		public static const NAME:String = 'TesteMediator';
		
		public static const GET_DADOS_OK:String = "GET_DADOS_OK";
		
		public function TesteMediator(viewComponent:Teste=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace("TEste");
			/* proxy = facade.retrieveProxy(IdaProxy.NAME) as IdaProxy;
			proxy.getDados("ida_modulos"); */
		}
		
		public function get view():Teste
		{
			return viewComponent as Teste;
		}
		
		override public function listNotificationInterests():Array
		{
			return [GET_DADOS_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case GET_DADOS_OK:
					Alert.show(note.getBody() as String);
					//view.txtMsg.text = "Logado!";
					break;
				default:
					break;
			}
		}
	}
}