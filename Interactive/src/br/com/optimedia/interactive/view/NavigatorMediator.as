package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.view.components.NavigatorView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class NavigatorMediator {
		
		public static const NAME:String = 'NavigatorMediator';
		
		//private var interactiveProxy:InteractiveProxy = new InteractiveProxy();
		
		public function NavigatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():NavigatorView
		{
			return viewComponent as NavigatorView;
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
					show( note.getBody() as SlideVO );
					break; */
				default:
					break;
			}
		}
	}
}