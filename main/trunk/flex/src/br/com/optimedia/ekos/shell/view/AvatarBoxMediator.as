package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AvatarBoxMediator extends Mediator
	{
		public static const NAME:String = 'AvatarBoxMediator';
		
		private var friendManagerProxy:FriendManagerProxy;
		//private var profileManagerProxy:ProfileManagerProxy;
		
		public function AvatarBoxMediator(viewComponent:Object=null)
		{
			super(NAME+viewComponent.uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+viewComponent.uid+".onRegister()");
			friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
			//profileManagerProxy = facade.retrieveProxy( ProfileManagerProxy.NAME ) as ProfileManagerProxy;
			
			view.addFriendBtn.addEventListener(MouseEvent.CLICK, addFriendBtnClickHandler);
			//não está funcionando
			//view.addEventListener( FlexEvent.REMOVE, disposeMe);
		}
		
		override public function onRemove():void {
		}
		
		public function get view():AvatarBox
		{
			return viewComponent as AvatarBox;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				/* case NotificationConstants.USER_UPDATE_AVAILABLE:
					view.completeUserVO = CompleteUserVO( note.getBody() ).clone();
					break; */
				default:
					break;
			}
		}
		
		// não está funcionando
		/* private function disposeMe(event:FlexEvent):void {
			sendNotification( CommandConstants.DISPOSE_AVATAR_BOX, view);
		} */
		
		private function addFriendBtnClickHandler(event:MouseEvent):void {
			friendManagerProxy.addFriend(view.completeUserVO.account_id);
		}
	}
}