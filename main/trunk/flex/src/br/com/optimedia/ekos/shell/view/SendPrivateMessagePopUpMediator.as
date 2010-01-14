package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.vo.MessageVO;
	import br.com.optimedia.ekos.shell.model.MessageManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.SendPrivateMessagePopUp;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class SendPrivateMessagePopUpMediator extends Mediator
	{
		public static const NAME:String = 'SendPrivateMessagePopUpMediator';
		
		private var proxy:MessageManagerProxy;
		
		public function SendPrivateMessagePopUpMediator(viewComponent:SendPrivateMessagePopUp=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			proxy = facade.retrieveProxy( MessageManagerProxy.NAME ) as MessageManagerProxy;
			
			view.addEventListener(CloseEvent.CLOSE, removePopUp);
			view.cancelBtn.addEventListener(MouseEvent.CLICK, cancelBtnClick);
			view.sendBtn.addEventListener(MouseEvent.CLICK, sendBtnClick);
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
			view.removePopup();
		}
		
		public function get view():SendPrivateMessagePopUp
		{
			return viewComponent as SendPrivateMessagePopUp;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.SEND_PRIVATE_MESSAGE_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.SEND_PRIVATE_MESSAGE_OK:
					Alert.show("Menssagem enviada com sucesso", "OK!");
					removePopUp( null );
					break;
				default:
					break;
			}
		}
		
		private function cancelBtnClick(event:MouseEvent):void {
			removePopUp( null );
		}
		
		private function sendBtnClick(event:MouseEvent):void {
			if(view.subjectTextInput.text != "" && view.messageTextArea.text != "") {
				var messageVO:MessageVO = new MessageVO();
				messageVO.receiver_profile_id = view.receiverUserVO.account_id;
				messageVO.subject = view.subjectTextInput.text;
				messageVO.text = view.messageTextArea.text;
				proxy.sendPrivateMessage( messageVO );
			}
		}
		
		private function removePopUp(event:CloseEvent):void {
			sendNotification( CommandConstants.DISPOSE_SEND_PRIVATE_MESSAGE_POPUP );
		}
	}
}