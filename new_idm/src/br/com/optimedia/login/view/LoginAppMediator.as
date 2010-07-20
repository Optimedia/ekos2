package br.com.optimedia.login.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LoginAppMediator extends Mediator
	{
		public static const NAME:String = 'LoginAppMediator';
		
		public function LoginAppMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():LoginApp
		{
			return viewComponent as LoginApp;
		}
		
		override public function listNotificationInterests():Array
		{
			return []
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