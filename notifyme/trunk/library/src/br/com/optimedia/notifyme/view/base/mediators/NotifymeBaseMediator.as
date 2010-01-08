package br.com.optimedia.notifyme.view.base.mediators
{
	import br.com.optimedia.notifyme.NotifymeFacade;
	import br.com.optimedia.notifyme.events.GotoFirstEvent;
	import br.com.optimedia.notifyme.events.GotoNextEvent;
	import br.com.optimedia.notifyme.events.GotoPriorEvent;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	import br.com.optimedia.notifyme.view.api.components.INotifymeView;
	import br.com.optimedia.notifyme.view.api.mediators.INotifymeMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class NotifymeBaseMediator  extends Mediator implements INotifymeMediator {
		
		public static const NAME:String = "NotifymeMediator";

		public function NotifymeBaseMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			viewComponent.addEventListener(NotifymeFacade.GOTO_FIRST, onGotoFirstClicked);
			viewComponent.addEventListener(NotifymeFacade.GOTO_PRIOR, onGotoPriorClicked);
			viewComponent.addEventListener(NotifymeFacade.GOTO_NEXT, onGotoNextClicked);
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
		
		public function onGotoFirstClicked(event: GotoFirstEvent): void {
			sendNotification(NotifymeFacade.GOTO_FIRST, event);
		}
		
		public function onGotoPriorClicked(event: GotoPriorEvent): void {
			sendNotification(NotifymeFacade.GOTO_PRIOR, event);
		}
		
		public function onGotoNextClicked(event: GotoNextEvent): void {
			sendNotification(NotifymeFacade.GOTO_NEXT, event);
		}
	}
}