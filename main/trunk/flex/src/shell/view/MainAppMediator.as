package shell.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MainAppMediator extends Mediator
	{
		public static const NAME:String = 'MainAppMediator';
		
		//private var proxy:ForumProxy;
		
		public function MainAppMediator(viewComponent:MainApp=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			//proxy = facade.retrieveProxy( ForumProxy.NAME ) as ForumProxy;
			//proxy.getLocale();
		}
		
		public function get view():MainApp
		{
			return viewComponent as MainApp;
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