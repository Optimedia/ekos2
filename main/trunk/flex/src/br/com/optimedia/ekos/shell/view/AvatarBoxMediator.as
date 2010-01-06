package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.ekos.shell.model.AvatarManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AvatarBoxMediator extends Mediator
	{
		public static const NAME:String = 'AvatarBoxMediator';
		
		private var avatarManagerProxy:AvatarManagerProxy;
		
		public function AvatarBoxMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			avatarManagerProxy = facade.retrieveProxy( AvatarManagerProxy.NAME ) as AvatarManagerProxy;
		}
		
		override public function onRemove():void {
		}
		
		public function get view():AvatarBox
		{
			return viewComponent as AvatarBox;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.LOGIN_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.LOGIN_OK:
					view.completeUserVO = CompleteUserVO(note.getBody()).clone();
					/* view.completeUserVO.large_avatar = CompleteUserVO(note.getBody()).large_avatar;
					view.completeUserVO.first_name = CompleteUserVO(note.getBody()).first_name;
					view.completeUserVO.last_name = CompleteUserVO(note.getBody()).last_name;
					view.completeUserVO.nickname = CompleteUserVO(note.getBody()).nickname; */
					break;
				default:
					break;
			}
		}
	}
}