package br.com.optimedia.login.view
{
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.login.model.ConnectManagerProxy;
	import br.com.optimedia.login.view.components.AtivarContaPopUp;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AtivarContaPopUpMediator extends Mediator
	{
		public static const NAME:String = 'AtivarContaPopUpMediator';
		
		private var connectManagerProxy:ConnectManagerProxy;
		
		public function AtivarContaPopUpMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			Application.application.addEventListener(ResizeEvent.RESIZE, resizeHandler);
			PopUpManager.centerPopUp( view );
			connectManagerProxy = facade.retrieveProxy( ConnectManagerProxy.NAME ) as ConnectManagerProxy;
			view.ativarBtn.addEventListener(MouseEvent.CLICK, ativarConta);
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
			return [NotificationConstants.ATIVAR_CONTA_OK]
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.ATIVAR_CONTA_OK:
					Alert.show("Ativar conta OK, FINISH me!!");
					view.myHideEffect.play();
					break;
				default:
					break;
			}
		}
		
		private function resizeHandler(e:ResizeEvent):void {
			PopUpManager.centerPopUp( view );
		}
		
		private function ativarConta(e:MouseEvent):void {
			connectManagerProxy.ativarConta( view.loginInput.text, view.codigoInput.text );
		}
	}
}