package br.com.optimedia.autor.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import flash.net.URLRequest;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import br.com.optimedia.autor.assets.FaultHandler;
	import mx.rpc.http.HTTPService;
	import mx.controls.Alert;
	import br.com.optimedia.autor.AutorFacade;

	public class AutorMediator extends Mediator
	{
		public static const NAME:String = 'AutorMediator';
		
		//private var friendManagerProxy:FriendManagerProxy;
		
		public function AutorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.visible = false;
			whoAmI();
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():Autor
		{
			return viewComponent as Autor;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.BEGIN_PRESENTATION_EDIT,
					NotificationConstants.BACK_TO_SUBJECT_MANAGER];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.BEGIN_PRESENTATION_EDIT:
					view.viewStack.selectedIndex++;
					break;
				case NotificationConstants.BACK_TO_SUBJECT_MANAGER:
					view.viewStack.selectedIndex--;
					break;
				default:
					break;
			}
		}
		
		private function whoAmI():void {
			var service:HTTPService = new HTTPService();
			service.url = 'http://www.educar.tv/sinase.moodle/autor/whoami.php';
			service.resultFormat = "array";
			service.showBusyCursor = true;
			service.addEventListener(ResultEvent.RESULT, resultHandler);
			service.addEventListener(FaultEvent.FAULT, faultHandler);
			service.send();
		}
		private function resultHandler(event:ResultEvent):void {
			view.visible = true;
			view.showModuleManager();
			view.showSlideEditor();
			AutorFacade(facade).roleID = 2;
			AutorFacade(facade).userID = 1;
			/* if( event.result.roleID == 0 ) {
				Alert.show("É necessário logar-se no Moodle antes.", "Erro");
			}
			else if( event.result.roleID == 3 || event.result.roleID == 2 ) {
				view.visible = true;
				view.showModuleManager();
				view.showSlideEditor();
				AutorFacade(facade).roleID = event.result.roleID;
				AutorFacade(facade).userID = event.result.userID;
			}
			else {
				Alert.show("Você não tem permissão para editar", "Atenção");
			} */
		}
		private function faultHandler(event:FaultHandler):void {
			trace(event);
		}
	}
}