package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.shell.model.SsoConnectProxy;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.EmailConfirmPopUp;
	import br.com.optimedia.ekos.shell.view.component.LoginPanel;
	import br.com.optimedia.ekos.shell.view.component.NewAccPopUp;
	import br.com.optimedia.ekos.shell.view.component.RememberPasswordPopUp;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LoginPanelMediator extends Mediator
	{
		public static const NAME:String = 'LoginPanelMediator';
		
		private var ssoConnectProxy:SsoConnectProxy;
		private var userManagerProxy:UserManagerProxy;
		
		public function LoginPanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			ssoConnectProxy = facade.retrieveProxy( SsoConnectProxy.NAME ) as SsoConnectProxy;
			userManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;
			
			view.loginBtn.addEventListener(MouseEvent.CLICK, doLogin);
			view.passTextInput.addEventListener(FlexEvent.ENTER, doLogin);
			view.newAccPopUp.addEventListener(NewAccPopUp.TRY_SIGN_UP_EVENT, trySignUp);
			view.rememberPasswordPopUp.addEventListener(RememberPasswordPopUp.REMEMBER_PASSWORD_EVENT, rememberPassword);
			view.emailConfirmPopUp.addEventListener(EmailConfirmPopUp.EMAIL_CONFIRM_EVENT, emailConfirm);
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
			return [NotificationConstants.LOGIN_OK,
					NotificationConstants.INSERT_USER_OK,
					NotificationConstants.REMEMBER_PASSWORD_OK,
					NotificationConstants.EMAIL_CONFIRM_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.LOGIN_OK:
					sendNotification( CommandConstants.DISPOSE_LOGIN_PANEL );
					break;
				case NotificationConstants.INSERT_USER_OK:
					view.newAccPopUp.visible = false;
					//PopUpManager.removePopUp( view.newAccPopUp );
					Alert.show("Usuário criado com sucesso, verifique seu e-mail para confirmação", "Operação realizada com sucesso");
					view.makeVisible(null);
					break;
				case NotificationConstants.REMEMBER_PASSWORD_OK:
					view.rememberPasswordPopUp.visible = false;
					//PopUpManager.removePopUp( view.rememberPasswordPopUp );
					Alert.show("Sua senha foi enviada para seu e-mail", "Operação realizada com sucesso");
					view.makeVisible(null);
					break;
				case NotificationConstants.EMAIL_CONFIRM_OK:
					view.emailConfirmPopUp.visible = false;
					//PopUpManager.removePopUp( view.emailConfirmPopUp );
					Alert.show("E-mail verificado com sucesso", "Operação realizada com sucesso");
					view.makeVisible(null);
					break;
				default:
					break;
			}
		}
		
		private function doLogin(event:Event):void {
			ssoConnectProxy.doLogin(view.loginTextInput.text, view.passTextInput.text);
		}
		
		private function trySignUp(event:Event):void {
			userManagerProxy.trySignUp( NewAccPopUp(event.target).completeUserVO );
		}
		
		private function rememberPassword(event:Event):void {
			userManagerProxy.rememberPassword( RememberPasswordPopUp(event.target).emailTextInput.text );
		}
		
		private function emailConfirm(event:Event):void {
			userManagerProxy.emailConfirm( EmailConfirmPopUp(event.target).userTextInput.text, EmailConfirmPopUp(event.target).codeTextInput.text );
		}
	}
}