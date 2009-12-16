package br.com.optimedia.notifier.shell.view
{
	
	import br.com.optimedia.notifier.shell.model.NotifierProxy;
	import br.com.optimedia.notifier.shell.view.component.PopNotifier;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class PopNotifierMediator extends Mediator
	{
		public static const NAME:String = 'PopNotifierMediator';
		
		private var proxy:NotifierProxy = new NotifierProxy();
		
		//public static const GET_DADOS_OK:String = "GET_DADOS_OK";
		
		public function PopNotifierMediator(viewComponent:PopNotifier=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			view.addEventListener(PopNotifier.NOTIFIER_SAVE_EVENT, onNotifierSaveEvent);
			proxy = facade.retrieveProxy(NotifierProxy.NAME) as NotifierProxy;			
		}
		
		public function get view():PopNotifier
		{
			return viewComponent as PopNotifier;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotifierProxy.SAVE_NOTIFIER_RESULT,
					NotifierProxy.SAVE_NOTIFIER_FAULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	
				case NotifierProxy.SAVE_NOTIFIER_RESULT:
					proxy.retrieveNotifier();
					view.fechar(); 
					break;
				case NotifierProxy.SAVE_NOTIFIER_FAULT:
					proxy.retrieveNotifier();
					Alert.show(note.getBody() as String, "Atenção!");
					break;
				default:
					break;
			}
		}
		
		private function onNotifierSaveEvent(event:Event):void
		{
			proxy.saveNotifier(view.notifierVO);
		}
	}
}