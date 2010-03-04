package br.com.optimedia.player.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class PlayerModuleMediator extends Mediator
	{
		public static const NAME:String = 'PlayerModuleMediator';
		
		//private var friendManagerProxy:FriendManagerProxy;
		
		public function PlayerModuleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():PlayerModule
		{
			return viewComponent as PlayerModule;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				/* case NotificationConstants.BEGIN_PRESENTATION_EDIT:
					view.viewStack.selectedIndex++;
					break; */
				default:
					break;
			}
		}
	}
}