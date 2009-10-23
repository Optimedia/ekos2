package forum.view
{
	import forum.model.ForumProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ForumMediator extends Mediator
	{
		public static const NAME:String = 'ForumMediator';
		
		private var proxy:ForumProxy;
		
		public function ForumMediator(viewComponent:Forum=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			proxy = facade.retrieveProxy( ForumProxy.NAME ) as ForumProxy;
			proxy.getLocale();
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