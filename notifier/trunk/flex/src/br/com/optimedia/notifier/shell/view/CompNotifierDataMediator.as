package br.com.optimedia.notifier.shell.view
{
	import br.com.optimedia.assets.vo.NotifierVO;
	import br.com.optimedia.notifier.shell.model.NotifierProxy;
	import br.com.optimedia.notifier.shell.view.component.CompNotifierData;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class CompNotifierDataMediator extends Mediator
	{
		public static const NAME:String = 'CompNotifierDataMediator';
		
		private var proxy:NotifierProxy = new NotifierProxy();
		
		public function CompNotifierDataMediator(viewComponent:CompNotifierData=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			proxy = facade.retrieveProxy(NotifierProxy.NAME) as NotifierProxy;
			proxy.retrieveNotifier();
			
			view.addEventListener(CompNotifierData.ON_DELETE_EVENT, onDeleteEvent);

		}
		
		public function get view():CompNotifierData
		{
			return viewComponent as CompNotifierData;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotifierProxy.GET_LOCALE_RESULT,
					NotifierProxy.RETRIEVENOTIFIER_RESULT,
					NotifierProxy.SAVE_NOTIFIER_RESULT,
					NotifierProxy.DELETE_NOTIFIER_RESULT];		
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	
				case NotifierProxy.GET_LOCALE_RESULT:
					view.lng = new XML(note.getBody());
					break
				case NotifierProxy.RETRIEVENOTIFIER_RESULT:
					view.dataProvider = note.getBody() as Array; 
					break;
				case NotifierProxy.SAVE_NOTIFIER_RESULT:
					proxy.retrieveNotifier();
				default:
					break;
			}
		}
		private function onDeleteEvent(event:Event):void {
			proxy.deleteNotifier( view.dpNotifier.selectedItem as NotifierVO );
		}
	}
}