package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.generalcomponents.MailItem;
	import br.com.optimedia.assets.vo.MessageVO;
	import br.com.optimedia.ekos.shell.model.MessageManagerProxy;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.view.component.MailBoxView;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.events.IndexChangedEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MailBoxViewMediator extends Mediator
	{
		public static const NAME:String = 'MailBoxViewMediator';
		
		private var messageManagerProxy:MessageManagerProxy;
		private var userManagerProxy:UserManagerProxy;
		
		public function MailBoxViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			messageManagerProxy = facade.retrieveProxy( MessageManagerProxy.NAME ) as MessageManagerProxy;
			userManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;
			
			view.viewStack.addEventListener(IndexChangedEvent.CHANGE, indexChangedEventHandler);
			view.addEventListener(MailItem.DELETE_MESSAGE_EVENT, deleteMessage);
			
			messageManagerProxy.getInBoxMessages();
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
			//view.removePopup();
		}
		
		public function get view():MailBoxView
		{
			return viewComponent as MailBoxView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.GET_INBOX_MESSAGES_RESULT,
					NotificationConstants.GET_OUTBOX_MESSAGES_RESULT,
					NotificationConstants.DELETE_MESSAGE_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_INBOX_MESSAGES_RESULT:
					view.inBoxList.dataProvider = note.getBody();
					break;
				case NotificationConstants.GET_OUTBOX_MESSAGES_RESULT:
					view.outBoxList.dataProvider = note.getBody();
					break;
				case NotificationConstants.DELETE_MESSAGE_OK:
					Alert.show("Mensagem apagada", "OK!");
					if(view.viewStack.selectedIndex == 0)
						messageManagerProxy.getInBoxMessages();
					else if(view.viewStack.selectedIndex == 1)
						messageManagerProxy.getOutBoxMessages();
					break;
				default:
					break;
			}
		}
		
		private function indexChangedEventHandler(event:IndexChangedEvent):void {
			switch(view.viewStack.selectedIndex) {
				case 0:
					messageManagerProxy.getInBoxMessages();
					break;
				case 1:
					messageManagerProxy.getOutBoxMessages();
					break;
				default:
					break;
			}
		}
		
		private function deleteMessage(event:Event):void {
			if(view.viewStack.selectedIndex == 0)
				messageManagerProxy.deleteMessage(MessageVO(view.inBoxList.selectedItem.messageVO).message_id);
			else if(view.viewStack.selectedIndex == 1)
				messageManagerProxy.deleteMessage(MessageVO(view.outBoxList.selectedItem.messageVO).message_id);
		}
	}
}