package br.com.optimedia.login.view
{
	import br.com.optimedia.login.view.components.AtivarContaPopUp;
	
	import mx.core.Application;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AtivarContaPopUpMediator extends Mediator
	{
		public static const NAME:String = 'AtivarContaPopUpMediator';
		
		public function AtivarContaPopUpMediator(viewComponent:Object=null)
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
		
		public function get view():AtivarContaPopUp
		{
			return viewComponent as AtivarContaPopUp;
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