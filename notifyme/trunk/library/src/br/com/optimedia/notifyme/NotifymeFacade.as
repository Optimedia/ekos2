package br.com.optimedia.notifyme
{
	import br.com.optimedia.notifyme.controller.StartupCommand;
	import br.com.optimedia.notifyme.model.proxy.NotifymeProxy;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class NotifymeFacade extends Facade implements IFacade {
		
		public static const STARTUP: String = "startup";
	
		public static const GOTO_PAGE: String  = "gotoPage";
		public static const GOTO_FIRST: String = "gotoFirst";
		public static const GOTO_PRIOR: String = "gotoPrior";
		public static const GOTO_NEXT: String  = "gotoNext";
		public static const GOTO_LAST: String  = "gotoLast";
		public static const GOTO_LIST: String  = "gotoList";
		public static const NOTIFY: String  = "NOTIFY";
		
		private static var instanceNotifymeFacade: NotifymeFacade;
		 
		private var notifymeProxy: NotifymeProxy; 

		override public function NotifymeFacade( key: String ) {
			super(key);
			notifymeProxy = new NotifymeProxy();
			registerProxy(notifymeProxy);
		}

		public static function getInstance(): NotifymeFacade {
			var key: String = "NotifymeFacade";
			if (instanceMap[ key ] == null) instanceMap[ key ] = new NotifymeFacade(key);
			return instanceMap[ key ] as NotifymeFacade;
		}
		
		override protected function initializeController():void {
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
		}
		
		public function gotoFirst(): void {
			this.notifymeProxy.gotoFirst();
		}

		public function gotoPrior(vo: NotificationVO): void {
			if (!vo.isFirst) {
				this.notifymeProxy.gotoPrior();
			}
		}
		
		public function gotoNext(vo: NotificationVO): void {
			if (!vo.isLast) {
				this.notifymeProxy.gotoNext();
			}
		}
		
		public function getList(): void {
			this.notifymeProxy.getList();
		}
	}
}