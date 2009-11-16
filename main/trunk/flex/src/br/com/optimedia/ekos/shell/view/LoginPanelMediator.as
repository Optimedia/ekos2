package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.shell.model.MainAppProxy;
	import br.com.optimedia.ekos.shell.view.component.LoginPanel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LoginPanelMediator extends Mediator
	{
		public static const NAME:String = 'LoginPanelMediator';
		
		private var proxy:MainAppProxy;
		
		public function LoginPanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			proxy = facade.retrieveProxy( MainAppProxy.NAME ) as MainAppProxy;
			
			view.loginBtn.addEventListener(MouseEvent.CLICK, doLogin);
			view.passTextInput.addEventListener(FlexEvent.ENTER, doLogin);
		}
		
		override public function onRemove():void {
			view.removePopUp();
		}
		
		public function get view():LoginPanel
		{
			return viewComponent as LoginPanel;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.LOGIN_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.LOGIN_OK:
					sendNotification( CommandConstants.DISPOSE_LOGIN_PANEL );
					break;
				default:
					break;
			}
		}
		
		private function doLogin(event:Event):void {
			proxy.doLogin(view.loginTextInput.text, view.passTextInput.text);
		}
	}
}