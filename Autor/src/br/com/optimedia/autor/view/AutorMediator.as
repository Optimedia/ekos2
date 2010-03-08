package br.com.optimedia.autor.view
{
	import br.com.optimedia.assets.FaultHandler;
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.autor.AutorFacade;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AutorMediator extends Mediator
	{
		public static const NAME:String = 'AutorMediator';
		
		public function AutorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.visible = false;
			whoAmI();
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
			service.resultFormat = "e4x";
			service.showBusyCursor = true;
			service.addEventListener(ResultEvent.RESULT, resultHandler);
			service.addEventListener(FaultEvent.FAULT, faultHandler);
			service.send();
		}
		private function resultHandler(event:ResultEvent):void {
			/* view.visible = true;
			view.showModuleManager();
			view.showSlideEditor();
			AutorFacade(facade).userRole = AutorFacade.IS_ADMIN;
			AutorFacade(facade).userID = 1; */
			//SE NÃO ESTIVER LOGADO NO MOODLE
			if( event.result.roleID == 0 ) {
				Alert.show("É necessário logar-se no Moodle antes.", "Erro");
			}
			//SE FOR AUTOR
			else if( event.result.roleID == 2 || event.result.roleID == 1 ) {
				view.visible = true;
				view.showModuleManager();
				view.showSlideEditor();
				AutorFacade(facade).userRole = AutorFacade.IS_ADMIN;
				AutorFacade(facade).userID = event.result.userID;
			}
			//SE FOR CONTEUDISTA (EDITOR)
			else if( event.result.roleID == 8 ) {
				view.visible = true;
				view.showModuleManager();
				view.showSlideEditor();
				AutorFacade(facade).userRole = AutorFacade.IS_EDITOR;
				AutorFacade(facade).userID = event.result.userID;
			}
			//SE NÃO TIVER PREMISSÃO DE ADMIN, AUTOR OU CONTEUDISTA
			else {
				Alert.show("Você não tem permissão para editar", "Atenção");
			}
		}
		private function faultHandler(event:FaultHandler):void {
			trace(event);
		}
	}
}