package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.EditProfile;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class EditProfileMediator extends Mediator
	{
		public static const NAME:String = 'EditProfileMediator';
		
		private var userManagerProxy:UserManagerProxy;
		
		public function EditProfileMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			userManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;
			
			view.resetBtn.addEventListener(MouseEvent.CLICK, resetBtnHandler);
			view.saveBtn.addEventListener(MouseEvent.CLICK, saveBtnHandler);
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():EditProfile
		{
			return viewComponent as EditProfile;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.LOGIN_OK,
					NotificationConstants.AVATAR_UPLOAD_COMPLETE,
					NotificationConstants.UPDATE_USER_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.LOGIN_OK:
					view.completeUserVO = CompleteUserVO(note.getBody()).clone();
					break;
				case NotificationConstants.AVATAR_UPLOAD_COMPLETE:
					view.completeUserVO.large_avatar = "http://10.1.1.10/amf/services/main/avatars/160x160/"+note.getBody();
					view.completeUserVO.small_avatar = "http://10.1.1.10/amf/services/main/avatars/100x100/"+note.getBody();
					break;
				case NotificationConstants.UPDATE_USER_OK:
					Alert.show("case NotificationConstants.UPDATE_USER_OK FINISH ME!", "ATENÇÃO");
				default:
					break;
			}
		}
		
		private function resetBtnHandler(event:MouseEvent):void {
			
		}
		
		private function saveBtnHandler(event:MouseEvent):void {
			userManagerProxy.updateUser( view.completeUserVO );
		}
	}
}