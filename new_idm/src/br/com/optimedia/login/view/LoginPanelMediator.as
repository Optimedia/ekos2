package br.com.optimedia.login.view
{
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.login.view.components.LoginPanel;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LoginPanelMediator extends Mediator
	{
		public static const NAME:String = 'LoginPanelMediator';
		
		public function LoginPanelMediator(viewComponent:Object=null)
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
		
		public function get view():LoginPanel
		{
			return viewComponent as LoginPanel;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.DO_LOGIN_OK]
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.DO_LOGIN_OK:
					Alert.show("login OK, FINISH ME!!!");
					break;
				default:
					break;
			}
		}
	}
}