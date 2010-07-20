package br.com.optimedia.login.view
{
	import br.com.optimedia.login.view.components.LembrarSenhaPopup;
	
	import mx.core.Application;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LembrarSenhaPopUpMediator extends Mediator
	{
		public static const NAME:String = 'LembrarSenhaPopUpMediator';
		
		public function LembrarSenhaPopUpMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			Application.application.addEventListener(ResizeEvent.RESIZE, resizeHandler);
			PopUpManager.centerPopUp( view );
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
			Application.application.removeEventListener(ResizeEvent.RESIZE, resizeHandler);
		}
		
		public function get view():LembrarSenhaPopup
		{
			return viewComponent as LembrarSenhaPopup;
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
		
		private function resizeHandler(e:ResizeEvent):void {
			PopUpManager.centerPopUp( view );
		}
	}
}