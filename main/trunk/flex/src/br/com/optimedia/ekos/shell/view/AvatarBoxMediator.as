package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.model.IgnoreManagerProxy;

	public class AvatarBoxMediator extends Mediator
	{
		public static const NAME:String = 'AvatarBoxMediator';
		
		private var friendManagerProxy:FriendManagerProxy;
		private var ignoreManagerProxy:IgnoreManagerProxy;
		
		public function AvatarBoxMediator(viewComponent:Object=null)
		{
			super(NAME+viewComponent.uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+viewComponent.uid+".onRegister()");
			friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
			ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
			
			view.addFriendBtn.addEventListener(MouseEvent.CLICK, addFriendBtnClick);
			view.removeFriendBtn.addEventListener(MouseEvent.CLICK, removeFriendBtnClick);
			view.ignoreUserBtn.addEventListener(MouseEvent.CLICK, ignoreUser);
			view.removeFromIgnoreBtn.addEventListener(MouseEvent.CLICK, removeIgnoreClick);

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
				default:
					break;
			}
		}
		
		private function addFriendBtnClick(event:MouseEvent):void {
			friendManagerProxy.addFriend(view.completeUserVO.account_id);
		}
		
		private function removeFriendBtnClick(event:MouseEvent):void {
			Alert.yesLabel = "Sim";
			Alert.noLabel = "Não";
			Alert.show("Tem certeza que deseja remover "+view.completeUserVO.first_name+" "+view.completeUserVO.last_name+" da sua lista de amigos?", "Atenção!", 3, null, doRemoveFriend);
		}
		private function doRemoveFriend(event:CloseEvent):void {
			friendManagerProxy.removeFriend( view.completeUserVO.account_id );
		}
		
		private function ignoreUser(event:MouseEvent):void {
			ignoreManagerProxy.addIgnore( view.completeUserVO.account_id );
		}
		
		private function removeIgnoreClick(event:MouseEvent):void {
			ignoreManagerProxy.removeIgnore( view.completeUserVO.account_id );
		}
	}
}