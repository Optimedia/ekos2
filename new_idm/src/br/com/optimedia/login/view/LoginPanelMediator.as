package br.com.optimedia.login.view
{
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.login.model.ConnectManagerProxy;
	import br.com.optimedia.login.view.components.LoginPanel;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LoginPanelMediator extends Mediator
	{
		public static const NAME:String = 'LoginPanelMediator';
		
		private var connectManagerProxy:ConnectManagerProxy;
		
		public function LoginPanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			connectManagerProxy = facade.retrieveProxy( ConnectManagerProxy.NAME ) as ConnectManagerProxy;
			view.entrarBtn.addEventListener(MouseEvent.CLICK, doLogin);
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
			return [NotificationConstants.DO_LOGIN_OK,
					NotificationConstants.ATIVAR_CONTA_OK]
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.DO_LOGIN_OK:
					Alert.show("login OK, FINISH ME!!!");
					view.myHideEffect.play();
					break;
				case NotificationConstants.ATIVAR_CONTA_OK:
					view.myHideEffect.play();
				default:
					break;
			}
		}
		
		private function doLogin(e:MouseEvent):void {
			connectManagerProxy.doLogin( view.loginInput.text, view.senhaInput.text );
		}
	}
}