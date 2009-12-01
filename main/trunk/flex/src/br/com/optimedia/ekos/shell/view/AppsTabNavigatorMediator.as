package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.ekos.shell.view.component.AppsTabNavigator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AppsTabNavigatorMediator extends Mediator
	{
		public static const NAME:String = 'AppsTabNavigatorMediator';
		
		//private var avatarManagerProxy:AvatarManagerProxy;
		
		public function AppsTabNavigatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			//avatarManagerProxy = facade.retrieveProxy( AvatarManagerProxy.NAME ) as AvatarManagerProxy;
		}
		
		override public function onRemove():void {
		}
		
		public function get view():AppsTabNavigator
		{
			return viewComponent as AppsTabNavigator;
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