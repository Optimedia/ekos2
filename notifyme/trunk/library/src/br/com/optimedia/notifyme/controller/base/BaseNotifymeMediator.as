package br.com.optimedia.notifyme.controller.base
{
	import br.com.optimedia.notifyme.model.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	import br.com.optimedia.notifyme.view.api.INotifymeView;
	import br.com.optimedia.notifyme.controller.api.INotifymeMediator;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class BaseNotifymeMediator extends Mediator implements INotifymeMediator  {
		
		public static const NAME:String = "NotifymeMediator";

		public function BaseNotifymeMediator(viewComponent:INotifymeView) {
			super(NAME, viewComponent);
		}
		
		// overrides
		override public function getMediatorName():String {
			return NAME;
		}

		public function get notifymeView(): INotifymeView {
			return viewComponent as INotifymeView;
		}

		override public function listNotificationInterests():Array {
			return [ NotifymeFacade.NOTIFY ];
		}

		override public function handleNotification(note:INotification): void {
			switch (note.getName()) {
				case NotifymeFacade.NOTIFY:
					onNotify(note);
					break;
				default:
					break;
			}
		}
		
		// abstract
		public function onNotify(note:INotification): void {
			notifymeView.setNotificationVO( note.getBody() as NotificationVO );
		}
		
		public function notify(vo: NotificationVO): void {
			notifymeView.notify(vo);
		}
		
		public function onPriorClicked(event:MouseEvent): void {
			notifymeFacade.gotoPrior(notifymeView.getNotificationVO());
		}
		public function onNextClicked(event:MouseEvent): void {
			notifymeFacade.gotoNext(notifymeView.getNotificationVO());
		}
		public function onOpenPage(event:MouseEvent): void {
			
		}
		public function get notifymeFacade(): NotifymeFacade {
			return facade as NotifymeFacade; 
		} 
	}
}