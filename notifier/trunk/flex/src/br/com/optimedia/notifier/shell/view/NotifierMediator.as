package br.com.optimedia.notifier.shell.view
{
	import br.com.optimedia.notifier.shell.model.NotifierProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class NotifierMediator extends Mediator
	{
		public static const NAME:String = 'NotifierMediator';
		
		private var proxy:NotifierProxy;
		
		public function NotifierMediator(viewComponent:Notifier=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace("Notifier");
			proxy = facade.retrieveProxy( NotifierProxy.NAME ) as NotifierProxy;
			proxy.getLocale();
		}
		
		public function get view():Notifier
		{
			return viewComponent as Notifier;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				default:
					break;
			}
		}
	}
}