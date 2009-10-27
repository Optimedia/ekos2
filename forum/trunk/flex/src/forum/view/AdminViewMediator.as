package forum.view
{
	import forum.model.ForumProxy;
	import forum.view.component.AdminView;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AdminViewMediator extends Mediator
	{
		public static const NAME:String = 'AdminViewMediator';
		
		private var proxy:ForumProxy;
		
		public function AdminViewMediator( viewComponent:Object=null )
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+view.uid+".onRegister()");
			proxy = facade.retrieveProxy( ForumProxy.NAME ) as ForumProxy;
			
			//view.lng = new XML( proxy.getLng() );
		}
		
		public function get view():AdminView
		{
			return viewComponent as AdminView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ForumProxy.GET_LOCALE_RESULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ForumProxy.GET_LOCALE_RESULT:
					view.lng = new XML( note.getBody() );
				default:
					break;
			}
		}
	}
}