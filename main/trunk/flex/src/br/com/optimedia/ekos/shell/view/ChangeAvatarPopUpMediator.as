package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.ChangeAvatarPopUp;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ChangeAvatarPopUpMediator extends Mediator
	{
		public static const NAME:String = 'ChangeAvatarPopUpMediator';
		
		private var profileManagerProxy:ProfileManagerProxy;
		
		public function ChangeAvatarPopUpMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			profileManagerProxy = facade.retrieveProxy( ProfileManagerProxy.NAME ) as ProfileManagerProxy;
			view.addEventListener( ChangeAvatarPopUp.UPLOAD_FILE_EVENT, uploadFile );
			view.addEventListener( CloseEvent.CLOSE, removePopUp);
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
			view.removePopup();
		}
		
		public function get view():ChangeAvatarPopUp
		{
			return viewComponent as ChangeAvatarPopUp;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.AVATAR_UPLOAD_COMPLETE];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.AVATAR_UPLOAD_COMPLETE:
					Alert.show("Arquivo enviado com sucesso! FINISH ME!!", "uploadFileResult");
					removePopUp(null);
					break;
				default:
					break;
			}
		}
		
		private function uploadFile(event:Event):void {
			profileManagerProxy.uploadFile( view.fileVO );
		}
		
		private function removePopUp(event:CloseEvent):void {
			sendNotification( CommandConstants.DISPOSE_CHANGE_AVATAR_POPUP );
		}
	}
}