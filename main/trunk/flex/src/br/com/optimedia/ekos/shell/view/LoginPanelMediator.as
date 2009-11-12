package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.ekos.shell.model.MainAppProxy;
	import br.com.optimedia.ekos.shell.view.component.LoginPanel;
	
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