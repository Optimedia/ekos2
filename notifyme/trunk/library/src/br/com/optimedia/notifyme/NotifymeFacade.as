package br.com.optimedia.notifyme
{
	import br.com.optimedia.notifyme.controller.GotoFirstCommand;
	import br.com.optimedia.notifyme.controller.GotoLastCommand;
	import br.com.optimedia.notifyme.controller.GotoListCommand;
	import br.com.optimedia.notifyme.controller.GotoNextCommand;
	import br.com.optimedia.notifyme.controller.GotoPageCommand;
	import br.com.optimedia.notifyme.controller.GotoPriorCommand;
	import br.com.optimedia.notifyme.controller.StartupCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class NotifymeFacade extends Facade implements IFacade {
		
		public static const STARTUP: String = "startup";
	
		public static const GOTO_PAGE: String  = "gotoPage";
		public static const GOTO_FIRST: String = "gotoFirst";
		public static const GOTO_PRIOR: String = "gotoPrior";
		public static const GOTO_NEXT: String  = "gotoNext";
		public static const GOTO_LAST: String  = "gotoLast";
		public static const GOTO_LIST: String  = "gotoList";
		public static const NOTIFY: String  = "NOTIFY";

		public function NotifymeFacade() {
		}
		
		public static function getInstance(): NotifymeFacade {
			if (instance == null) instance = new NotifymeFacade();
			return instance as NotifymeFacade;
		}
		
		override protected function initializeController():void {
			super.initializeController();
			
			registerCommand(STARTUP, StartupCommand);
			
			registerCommand(NotifymeFacade.GOTO_FIRST, GotoFirstCommand);
			registerCommand(NotifymeFacade.GOTO_PRIOR, GotoPriorCommand);
			registerCommand(NotifymeFacade.GOTO_NEXT,  GotoNextCommand);
		}
	}
}