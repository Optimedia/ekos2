package forum.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ForumMediator extends Mediator
	{
		public static const NAME:String = 'ForumMediator';
		
		public function ForumMediator(viewComponent:Forum=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace("TEste");
			/* proxy = facade.retrieveProxy(IdaProxy.NAME) as IdaProxy;
			proxy.getDados("ida_modulos"); */
		}
		
		public function get view():Forum
		{
			return viewComponent as Forum;
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