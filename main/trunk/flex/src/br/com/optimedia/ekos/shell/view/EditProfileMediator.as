package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.EditProfile;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class EditProfileMediator extends Mediator
	{
		public static const NAME:String = 'EditProfileMediator';
		
		//private var facade:MainAppFacade = MainAppFacade.getInstance();
		
		private var userManagerProxy:UserManagerProxy;
		
		public function EditProfileMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			userManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;
			//view.addEventListener( ChangeAvatarPopUp.UPLOAD_FILE_EVENT, uploadFile );
			//view.completeUserVO = MainAppFacade(facade).myCompleteUserVO;
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
					NotificationConstants.AVATAR_UPLOAD_COMPLETE];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.LOGIN_OK:
					view.completeUserVO = note.getBody() as CompleteUserVO;
					break;
				case NotificationConstants.AVATAR_UPLOAD_COMPLETE:
					view.completeUserVO.large_avatar = "//10.1.1.10/web/amf/services/main/avatars/160x160/"+note.getBody();
					break;
				default:
					break;
			}
		}
	}
}