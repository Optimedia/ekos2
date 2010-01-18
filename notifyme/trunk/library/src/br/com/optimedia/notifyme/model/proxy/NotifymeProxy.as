package br.com.optimedia.notifyme.model.proxy
{
	import br.com.optimedia.notifyme.model.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class NotifymeProxy extends Proxy implements IProxy {
		
		public static const NAME:String = "NotifymeProxy";
		
		//private var xmppSocketConnection: XMPPSocketConnection;

		public function NotifymeProxy(data:Object = null) {
			super(NAME, data);
			
			configureListeners();
		}
		
		
		private function configureListeners():void {
			//xmppSocketConnection.addEventListener(NotifymeFacade.GOTO_FIRST, onGotoFirst);
		}
		
		/**
		 * The user has successfully logged on to the XMPP server
		 * 
		 * @param	connectionSuccessEvent
		 */
		public function gotoFirst(): void {
			var vo: NotificationVO = new NotificationVO();
			vo.id = "1";
			vo.source = "Source 1";
			vo.timestamp = "30 out 2010";
			vo.description = "Description\nDescription mono momno";
			vo.title = "Title";
			vo.url = "URL";
			sendNotification(NotifymeFacade.NOTIFY, vo);
		}
		
		public function gotoPrior(): void {
			var vo: NotificationVO = new NotificationVO();
			vo.id = "2";
			vo.source = "Source 2";
			vo.timestamp = "30 out 2010";
			vo.description = "Description\nDescription mono momno";
			vo.title = "Title";
			vo.url = "URL";
			sendNotification(NotifymeFacade.NOTIFY, vo);
		}
		
		public function gotoNext(): void {
			var vo: NotificationVO = new NotificationVO();
			vo.id = "3";
			vo.source = "Source 3";
			vo.timestamp = "30 out 2010";
			vo.description = "Description\nDescription mono momno";
			vo.title = "Title";
			vo.url = "URL";
			sendNotification(NotifymeFacade.NOTIFY, vo);
		}
		
		public function getList(): void {
		}
		
	}
}