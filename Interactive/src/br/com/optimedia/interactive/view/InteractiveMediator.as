package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.model.InteractiveProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class InteractiveMediator extends Mediator
	{
		public static const NAME:String = 'InteractiveMediator';
		
		private var interactiveProxy:InteractiveProxy = new InteractiveProxy();
		
		public function InteractiveMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			interactiveProxy = facade.retrieveProxy( InteractiveProxy.NAME ) as InteractiveProxy;
			interactiveProxy.getSlide();
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():Interactive
		{
			return viewComponent as Interactive;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				/* case ApplicationConstants.GET_SLIDE_OK:
					view.show(note.getBody() as SlideVO);
					break; */
				default:
					break;
			}
		}
	}
}