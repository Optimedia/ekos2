package br.com.optimedia.ekos.shell.view
{
	
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.shell.model.MainAppProxy;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	

	public class MainAppMediator extends Mediator
	{
		public static const NAME:String = 'MainAppMediator';
		
		private var proxy:MainAppProxy;
		
		public function MainAppMediator(viewComponent:MainApp=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			proxy = facade.retrieveProxy( MainAppProxy.NAME ) as MainAppProxy;
			
			view.showLoginPanel();
			view.logoutBtn.addEventListener(MouseEvent.CLICK, doLogout);
		}
		
		public function get view():MainApp
		{
			return viewComponent as MainApp;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.LOGIN_OK,
					NotificationConstants.LOGOUT_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.LOGIN_OK:
					view.showCockpit();
					break;
				case NotificationConstants.LOGOUT_OK:
					view.visible = false;
					view.showLoginPanel();
					break;
				default:
					break;
			}
		}
		
		private function doLogout(event:MouseEvent):void {
			proxy.doLogout();
		}
	}
}