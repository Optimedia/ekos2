package shell.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import shell.model.TesteProxy;
	import shell.view.component.MainComponent;

	public class MainComponentMediator extends Mediator
	{
		public static const NAME:String = 'MainComponentMediator';
		
		private var proxy:TesteProxy = new TesteProxy();
		
		public function MainComponentMediator(viewComponent:MainComponent=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			proxy = facade.retrieveProxy(TesteProxy.NAME) as TesteProxy;
			proxy.getDados('5');
			trace("TEste");
			/* proxy = facade.retrieveProxy(IdaProxy.NAME) as IdaProxy;
			proxy.getDados("ida_modulos"); */
		}
		
		public function get view():MainComponent
		{
			return viewComponent as MainComponent;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				/* case MainComponentMediator.GET_DADOS_OK:
					//view.txtMsg.text = "Logado!";
					break; */
				default:
					break;
			}
		}
	}
}