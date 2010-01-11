package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.EditProfile;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.utils.ArrayUtil;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class EditProfileMediator extends Mediator
	{
		public static const NAME:String = 'EditProfileMediator';
		
		private var userManagerProxy:UserManagerProxy;
		private var profileManagerProxy:ProfileManagerProxy;
		
		public function EditProfileMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			userManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;
			profileManagerProxy = facade.retrieveProxy( ProfileManagerProxy.NAME ) as ProfileManagerProxy;
			
			profileManagerProxy.getEducationLevels();
			profileManagerProxy.getAddressTypes();
			profileManagerProxy.getAvailableLanguages();
			
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
			return [NotificationConstants.AVATAR_UPLOAD_COMPLETE,
					NotificationConstants.USER_UPDATE_AVAILABLE,
					NotificationConstants.GET_EDUCATION_LEVELS_OK,
					NotificationConstants.GET_ADDRESS_TYPES_OK,
					NotificationConstants.GET_AVAILABLE_LANGUAGES_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.USER_UPDATE_AVAILABLE:
					view.completeUserVO = CompleteUserVO( note.getBody() ).clone();
					break;
				case NotificationConstants.AVATAR_UPLOAD_COMPLETE:
					view.completeUserVO.large_avatar = "http://10.1.1.10/amf/services/main/avatars/160x160/"+note.getBody();
					view.completeUserVO.small_avatar = "http://10.1.1.10/amf/services/main/avatars/100x100/"+note.getBody();
					break;
				case NotificationConstants.GET_EDUCATION_LEVELS_OK:
					view.educationLevelsAC = new ArrayCollection(ArrayUtil.toArray(note.getBody()));
					break;
				case NotificationConstants.GET_ADDRESS_TYPES_OK:
					view.addressTypesAC = new ArrayCollection(ArrayUtil.toArray(note.getBody()));
					break;
				case NotificationConstants.GET_AVAILABLE_LANGUAGES_OK:
					view.languagesAC = new ArrayCollection(ArrayUtil.toArray(note.getBody()));
					break;
				default:
					break;
			}
		}
		
		private function getUserData():void {
			userManagerProxy.getUserData();
		}
		
		private function resetBtnHandler(event:MouseEvent):void {
			getUserData();
		}
		
		private function saveBtnHandler(event:MouseEvent):void {
			userManagerProxy.updateUser( view.completeUserVO );
		}
	}
}